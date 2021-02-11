require File.expand_path('boot', __dir__)

require 'rails/all'
require 'active_support/core_ext'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(assets: %w[development test]))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module UnifiedWarehouse
  class Application < Rails::Application
    config.load_defaults 5.0
    config.autoload_paths    += ["#{config.root}/lib"]
    config.time_zone          = 'UTC'
    config.encoding           = 'utf-8'
    config.filter_parameters += [:password]
    # config.assets.enabled     = false
    # config.assets.version     = '1.0'

    # We've already agreed a schema with NPG, I'd prefer not to do this but rails
    # isn't the only convention in play here.
    config.active_record.pluralize_table_names = false

    # If you want to enable structure.sql again, uncomment this line:
    # config.active_record.schema_format = :sql

    # We're going to need a specialised configuration for our AMQP consumer
    config.amqp                       = ActiveSupport::Configurable::Configuration.new
    config.amqp.server                = ActiveSupport::Configurable::Configuration.new
    config.amqp.main                  = ActiveSupport::Configurable::Configuration.new
    config.amqp.delay                 = ActiveSupport::Configurable::Configuration.new
    config.amqp.main.deadletter       = ActiveSupport::Configurable::Configuration.new
    config.amqp.deadletter            = ActiveSupport::Configurable::Configuration.new
  end
end
