source 'https://rubygems.org'

gem 'bootsnap'
gem 'mysql2'

# We hardly use any of the features of Rails, so lets just load what we need
# Initially installed with
# gem 'rails', '~> 5.0'
# And then extracted the dependencies from the Gemfile.lock
# I've commented out those we don't need.
# RAILS DEPENDENCIES
# gem 'actioncable', '~> 5.2.4.4'
gem 'actionmailer', '~> 5.2.4.4'
# gem 'actionpack', '~> 5.2.4.4'
# gem 'actionview', '~> 5.2.4.4'
# gem 'activejob', '~> 5.2.4.4'
gem 'activemodel', '~> 5.2.4.4'
gem 'activerecord', '~> 5.2.4.4'
# gem 'activestorage', '~> 5.2.4.4'
gem 'activesupport', '~> 5.2.4.4'
gem 'railties', '~> 5.2.4.4'
# gem 'sprockets-rails', '>= 2.0.0'
# RAILS DEPENDENCIES

gem 'bunny'
gem 'daemons'
gem 'hashie', '~> 4.0'
gem 'migration_comments'

group :test, :development do
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'rspec-rails'
end

group :development do
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end
