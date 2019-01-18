source 'https://rubygems.org'

# TODO: We pretty much just use active record and active mailer, do we need rails?
gem "mysql2", "~> 0.4.10"
gem "rails", "~> 4.1"

gem "bunny"
gem "daemons"
gem "hashie", "~> 3.3"
gem "migration_comments"

group :test, :development do
  gem 'factory_girl_rails'
  gem 'mocktra', '~> 1.0.2'
  gem 'pry'
  gem 'rspec-rails'
end

group :development do
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'rubocop'
end

group :deployment do
  gem "psd_logger", github: "sanger/psd_logger"
end
