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
  gem 'pry'
  gem 'rspec-rails'
end

group :development do
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'rubocop'
end
