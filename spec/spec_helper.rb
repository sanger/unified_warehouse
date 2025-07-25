# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'

require 'simplecov'
require 'simplecov_json_formatter'
require 'simplecov-lcov'
SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov::Formatter::LcovFormatter.config.single_report_path = 'lcov.info'
SimpleCov.formatters =
  SimpleCov::Formatter::MultiFormatter.new(
    [SimpleCov::Formatter::HTMLFormatter, SimpleCov::Formatter::JSONFormatter, SimpleCov::Formatter::LcovFormatter]
  )
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
# require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Rails.root.glob('spec/support/**/*.rb').each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    ActiveRecord::Migration.maintain_test_schema!
    # Lint our factories unless we are running just a single file
    unless config.files_to_run.one?
      ActiveRecord::Base.transaction do
        FactoryBot.lint
        raise ActiveRecord::Rollback
      end
    end
  end
end
