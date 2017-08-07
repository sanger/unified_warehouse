
require_relative '../postman'

class Postman
  # Configures and wraps a Bunny Channel/Queue
  class Channel
    def initialize(client:, config:, type: :topic)
      @client = client
      @exchange_name = config.exchange
      @queue_name = config.queue
      @routing_keys = config.routing_keys
      @deadletter_exchange = config.deadletter_exchange
      @ttl = config.fetch(:ttl, 0)
      @type = type
    end

    delegate :nack, :ack, to: :channel

    def subscribe(consumer_tag = '', &block)
      queue.subscribe(manual_ack: true, block: false, consumer_tag: consumer_tag, &block)
    end

    def publish(payload, options)
      options[:persistent] = true
      exchange.publish(payload, options)
    end

    def activate!
      establish_bindings!
    end

    private

    def channel
      @channel ||= @client.create_channel
    end

    def exchange
      channel.public_send(@type, @exchange_name, auto_delete: false, durable: true)
    end

    def queue
      raise StandardError, "No queue configured" if @queue_name.nil?
      channel.queue(@queue_name, arguments: queue_arguments)
    end

    def queue_arguments
      { 'x-dead-letter-exchange' => @deadletter_exchange, 'x-message-ttl' => @ttl }
    end

    def routing_keys
      if  @type == :topic
        @routing_keys
      else
        [:topic]
      end
    end

    def establish_bindings!
      routing_keys.each do |key|
        queue.bind(exchange, routing_key: key)
      end
    end
  end
end
