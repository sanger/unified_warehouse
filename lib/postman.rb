
require 'bunny'
require_relative 'message'

# A postman listens to a rabbitMQ message queues
# and funnels messages onto it.
class Postman
  # Database connection messages indicated temporary issues connecting to the database
  # We handle them separately to ensure we can recover from network issues.
  DATABASE_CONNECTION_MESSAGES = [
    /Mysql2::Error: closed MySQL connection:/,
    /Mysql2::Error: MySQL server has gone away/,
    /Mysql2::Error: Can't connect to local MySQL server through socket/
  ].freeze

  attr_reader :client, :queue_name, :exchange_name, :routing_keys, :deadletter_exchange

  def initialize(client:, queue_name:, exchange_name:, routing_keys:, consumer_tag: nil, deadletter_exchange:, delay_exchange:)
    @client = client
    @queue_name = queue_name.dup.freeze
    @exchange_name = exchange_name.dup.freeze
    @routing_keys = routing_keys.map { |k| k.dup.freeze }
    @consumer_tag = consumer_tag || "#{@queue_name}_#{Rails.env}_#{Process.pid}"
    @deadletter_exchange = deadletter_exchange.dup.freeze
    @state = :initialized
    @delay_exchange =  delay_exchange
    @recovery_attempts = 0
  end

  def stopping?
    @state == :stopping
  end

  def alive?
    @state != :stopped
  end

  def stopped?
    @state == :stopped
  end

  def paused?
    @state == :paused
  end

  def channel
    @channel ||= @client.create_channel
  end

  def exchange
    channel.topic(exchange_name, auto_delete: false, durable: true)
  end

  def queue
    channel.queue(queue_name, arguments: { 'x-dead-letter-exchange' => deadletter_exchange })
  end

  def establish_bindings!
    routing_keys.each do |key|
      queue.bind(exchange, routing_key: key)
    end
  end

  def run!
    @state = :starting
    # Capture the term signal and set the state to stopping.
    # We can't directly cancel the consumer from here as Bunny
    # uses Mutex locking while checking the state. Ruby forbids this
    # from inside a trap block.
    Signal.trap("TERM") { stop! }
    Signal.trap("INT") { manual_stop! }

    # We reconnect to the database after the fork.
    ActiveRecord::Base.establish_connection
    @client.start       # Start the client
    establish_bindings! # Set up the queues
    @delay_exchange.activate!
    @state = :running   # Transition to running state
    subscribe!          # Subscribe to the queue
    # Monitor our state to control stopping and re-connection
    # This loop blocks until the state is :stopped
    control_loop while alive?
    # And we leave the application
    Rails.logger.info "Stopped #{@consumer_tag}"
    Rails.logger.info "Goodbye!"
  ensure
    @client.close
  end

  def stop!
    @state = :stopping
    STDOUT.puts "Stopping #{@consumer_tag}"
  end

  private

  # The control loop. Checks the state of the process every three seconds
  # stopping: cancels the consumer, sets the processes to stopped and breaks the loop
  # stopped: (alive? returns false) terminates the loop. In practice the break should have achieved this
  # anything else: waits three seconds and tries again
  def control_loop
    if stopping?
      @consumer.cancel
      @state = :stopped
    elsif paused?
      sleep(attempt_recovery)
    else
      sleep(3)
    end
  end

  # Our consumer operates in another thread. It is non blocking.
  # While a blocking consumer would be convenient, it causes problems:
  # 1. @consumer never gets set, requiring up instead to instantiate it first, then use subscribe_with
  # 2. We are still unable to call @consumer.cancel in our trap, give the aforementioned restrictions
  # 3. However, as our main thread is locked, we don't have anywhere else to handle the shutdown from
  # 4. There doesn't seem to be much gained from spinning up the control loop in its own thread
  def subscribe!
    raise StandardError, "Consumer already exists" unless @consumer.nil?
    @consumer ||= queue.subscribe(manual_ack: true, block: false, consumer_tag: @consumer_tag) do |delivery_info, metadata, payload|
      process(delivery_info, metadata, payload)
    end
  end

  def attempt_recovery
    Rails.logger.warn "Attempting recovery of database connection: #{@recovery_attempts}"
    ActiveRecord::Base.connection.reconnect!
    @state = :running
    @consumer.recover_from_network_failure
    @recovery_attempts = 0
    0
  rescue Mysql2::Error
    @recovery_attempts += 1
    # We haven't recovered, increase out wait time to a maximum of 5 minutes
    delay_for_attempt
  end

  def delay_for_attempt
    [2 ^ @recovery_attempts, 60 * 5].min
  end

  # Called in an interrupt. (Ctrl-C)
  def manual_stop!
    exit 1 if stopping?
    stop!
    STDOUT.puts "Press Ctrl-C again to stop immediately."
  end

  def pause!
    return if stopping? || stopped?
    @consumer.cancel
    @state = :paused
  end

  def process(delivery_info, metadata, payload)
    begin
      Rails.logger.info "Started message process"
      Rails.logger.debug payload
      message = Message.from_json(payload)
    rescue Message::InvalidMessage => exception
      # Our message fails to meet our basic requirements, there's little point
      # sending it to the delayed queue, as it will still be invalid next time.
      deadletter(delivery_info, payload, exception)
      return
    end

    begin
      message.record
      channel.ack(delivery_info.delivery_tag)
    rescue ActiveRecord::StatementInvalid => exception
      if DATABASE_CONNECTION_MESSAGES.any? { |regex| regex.match?(exception.message) }
        pause!
        requeue(delivery_info, payload, exception)
      else
        attempt = metadata.headers.fetch('attempts', 0)
        delay(delivery_info, payload, exception, attempt)
      end
    rescue => exception
      delay(delivery_info, payload, exception)
    end

    Rails.logger.info "Finished message process"
  end

  # Re-queue the message for later processing
  # Remove from the standard queue
  def delay(delivery_info, payload, exception, attempt)
    Rails.logger.warn "Delay: #{payload}"
    Rails.logger.warn exception.message
    # Publish the message to the delay queue
    @delay_exchange.publish(payload, routing_key: delivery_info.routing_key, headers: { attempts: attempt + 1 })
    # Acknowledge the original message
    channel.ack(delivery_info.delivery_tag)
  end

  # Reject the message and requeue ready for
  # immediate reprocessing.
  def requeue(delivery_info, payload, exception)
    Rails.logger.warn "Re-queue: #{payload}"
    Rails.logger.warn exception.message
    channel.nack(delivery_info.delivery_tag, false, true)
  end

  # Reject the message without re-queuing
  # Will end up getting dead-lettered
  def deadletter(delivery_info, payload, exception)
    Rails.logger.error "Deadletter: #{payload}"
    Rails.logger.error exception.message
    channel.nack(delivery_info.delivery_tag)
  end
end
