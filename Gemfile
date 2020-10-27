source 'https://rubygems.org'

gem 'bootsnap'
gem 'mysql2'

# We hardly use any of the features of Rails, so lets just load what we need
# Initially installed with
# gem 'rails', '~> 6.0'
# And then extracted the dependencies from the Gemfile.lock
# I've commented out those we don't need.
# RAILS DEPENDENCIES
# gem 'actioncable', '~> 6.0.3'
# gem 'actionmailbox', '~> 6.0.3'
# gem 'actionmailer', '~> 6.0.3'
# gem 'actionpack', '~> 6.0.3'
# gem 'actiontext', '~> 6.0.3'
# gem 'actionview', '~> 6.0.3'
# gem 'activejob', '~> 6.0.3'
gem 'activemodel', '~> 6.0.3'
gem 'activerecord', '~> 6.0.3'
# gem 'activestorage', '~> 6.0.3'
gem 'activesupport', '~> 6.0.3'
gem 'bundler', '>= 1.3.0'
gem 'railties', '~> 6.0.3'
# gem 'sprockets-rails', '>= 2.0.0'
# # RAILS DEPENDENCIES

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
