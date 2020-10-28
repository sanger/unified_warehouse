source 'https://rubygems.org'

# TODO: We pretty much just use active record and active mailer, do we need rails?
gem 'bootsnap'
gem 'mysql2'
gem 'rails', '~> 5.0'

gem 'bunny'
gem 'daemons'
gem 'hashie', '~> 4.0'
gem 'migration_comments'

group :test, :development do
  gem 'factory_girl_rails'
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
