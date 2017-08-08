require 'active_support'
require 'active_support/core_ext'

class Postman
  # A message takes a rabbitMQ message, and handles its acknowledgement
  # or rejection.
  class Message
    # Database connection messages indicated temporary issues connecting to the database
    # We handle them separately to ensure we can recover from network issues.
    DATABASE_CONNECTION_MESSAGES = [
      /Mysql2::Error: closed MySQL connection:/,
      /Mysql2::Error: MySQL server has gone away/,
      /Mysql2::Error: Can't connect to local MySQL server through socket/
    ].freeze

    attr_reader :delivery_info, :metadata, :payload, :postman

    delegate :warn, :info, :error, :debug, to: :logger
    delegate :main_exchange, :delay_exchange, :max_retries, to: :postman

    def logger
      Rails.logger
    end

    def initialize(postman, delivery_info, metadata, payload)
      @postman = postman
      @delivery_info = delivery_info
      @metadata = metadata
      @payload = payload
    end

    def process
      info "Started message process"
      debug payload

      begin
        message
      rescue Payload::InvalidMessage => exception
        # Our message fails to meet our basic requirements, there's little point
        # sending it to the delayed queue, as it will still be invalid next time.
        deadletter(exception)
        return
      end

      begin
        message.record
        main_exchange.ack(delivery_info.delivery_tag)
      rescue ActiveRecord::StatementInvalid => exception
        if database_connection_error?(exception)
          requeue(exception)
          postman.pause!
        else
          delay(exception)
        end
      rescue => exception
        delay(exception)
      end
      info "Finished message process"
    end

    private

    def message
      @message ||= Payload.from_json(payload)
    end

    def attempt
      metadata.headers.fetch('attempts', 0)
    end

    def delivery_tag
      delivery_info.delivery_tag
    end

    def database_connection_error?(exception)
      DATABASE_CONNECTION_MESSAGES.any? { |regex| regex.match?(exception.message) }
    end

    def ack
      main_exchange.ack(delivery_tag)
    end

    # Re-queue the message for later processing
    # Remove from the standard queue
    def delay(exception)
      warn "Delay: #{payload}"
      warn exception.message
      if attempt <= max_retries
        # Publish the message to the delay queue
        delay_exchange.publish(payload, routing_key: delivery_info.routing_key, headers: { attempts: attempt + 1 })
        # Acknowledge the original message
        main_exchange.ack(delivery_tag)
      else
        deadletter(exception)
      end
    end

    # Reject the message and re-queue ready for
    # immediate reprocessing.
    def requeue(exception)
      warn "Re-queue: #{payload}"
      warn exception.message
      main_exchange.nack(delivery_tag, false, true)
    end

    # Reject the message without re-queuing
    # Will end up getting dead-lettered
    def deadletter(exception)
      error "Deadletter: #{payload}"
      error exception.message
      main_exchange.nack(delivery_tag)
    end
  end
end
