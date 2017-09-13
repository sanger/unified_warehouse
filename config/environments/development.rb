UnifiedWarehouse::Application.configure do
  # NOTE: Much of this can probably be removed as we're not really using Rails, more AR.
  config.cache_classes = false
  # config.whiny_nils = true
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  # config.action_dispatch.best_standards_support = :builtin
  # config.assets.compress = false
  config.assets.debug = true

  config.logger = Logger.new(STDOUT)

  # Here is some ActiveRecord configuration that is useful
  # But not rails 4 compatible!
  # config.active_record.mass_assignment_sanitizer         = :strict
  # config.active_record.auto_explain_threshold_in_seconds = 0.5

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

  # Added for rails 4
  config.eager_load = false
end
