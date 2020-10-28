source 'https://rubygems.org'

# TODO: We pretty much just use active record and active mailer, do we need rails?
gem 'bootsnap'
gem "mysql2" # , "~> 0.4.10"
gem "rails", "~> 5.0"

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
