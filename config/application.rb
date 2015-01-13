require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module UnifiedWarehouse
  class Application < Rails::Application
    config.autoload_paths    += [ "#{config.root}/lib" ]
    config.time_zone          = 'UTC'
    config.encoding           = "utf-8"
    config.filter_parameters += [:password]
    config.assets.enabled     = false
    config.assets.version     = '1.0'

    # Configure the worker death messages
    config.worker_death_from    = 'Projects Exception Notifier <example@example.com>'
    config.worker_death_to      = 'example@example.com'
    config.worker_death_restart = %Q{Please restart the worker.}

    # We've already agreed a schema with NPG, I'd prefer not to do this but rails
    # isn't the only convention in play here.
    config.active_record.pluralize_table_names = false
    config.active_record.schema_format = :sql

    # We're going to need a specialised configuration for our AMQP consumer
    config.amqp                       = ActiveSupport::Configurable::Configuration.new
    config.amqp.main                  = ActiveSupport::Configurable::Configuration.new
    config.amqp.main.deadletter       = ActiveSupport::Configurable::Configuration.new
    config.amqp.deadletter            = ActiveSupport::Configurable::Configuration.new
  end
end
