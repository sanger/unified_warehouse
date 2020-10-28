Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.

  # NOTE: Much of this can probably be removed as we're not really using Rails, more AR.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  # config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options)
  # config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  # config.assets.debug = true

  # Suppress logger output for asset requests.
  # config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.logger = Logger.new(STDOUT)
  config.log_level = :debug

  # Configure the numeric tolerance
  config.numeric_tolerance = 0.05

  # Configure the main AMQP consumer

  config.amqp.server.host                 = '127.0.0.1'
  config.amqp.server.username             = 'guest'
  config.amqp.server.password             = 'guest'
  config.amqp.server.port                 = 5672
  config.amqp.server.heartbeat            = 30

  config.amqp.max_retries                 = 20

  config.amqp.requeue_key                 = "requeue.#{Rails.env}"
  config.amqp.main.queue                  = 'psd.mlwh'
  config.amqp.main.exchange               = 'psd.sequencescape'
  config.amqp.main.routing_keys           = ['test.key']
  config.amqp.main.deadletter_exchange    = 'deadletters'

  config.amqp.delay.queue                  = 'psd.mlwh.delay'
  config.amqp.delay.exchange               = 'psd.sequencescape.delay'
  config.amqp.delay.routing_keys           = []
  config.amqp.delay.ttl                    = 30 * 1000
  config.amqp.delay.deadletter_exchange    = 'psd.sequencescape'

  # Configure the deadletter AMQP consumer
  config.amqp.deadletter.url                             = 'amqp://guest:guest@127.0.0.1:5672'
  config.amqp.deadletter.queue                           = 'deadletters'
  config.amqp.deadletter.prefetch                        = 50
  config.amqp.deadletter.requeue                         = true
  config.amqp.deadletter.reconnect_interval              = 10
  config.amqp.deadletter.empty_queue_disconnect_interval = 30
end
