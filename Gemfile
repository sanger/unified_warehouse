source 'https://rubygems.org'

# We hardly use any of the features of Rails, so lets just load what we need
# Initially installed with
# gem 'rails', '~> 6.0'
# And then extracted the dependencies from the Gemfile.lock
# I've removed those we don't need. If reinstating a dependency try and match
# the version to those already included.
# A full list of rails components can be found in the Gemfile:
# https://github.com/rails/rails/blob/master/rails.gemspec
#
# Be aware when adding in new components that they may require an initializer
# or additional configuration options.
# RAILS DEPENDENCIES
gem 'activemodel', '~> 7.1.2'
gem 'activerecord', '~> 7.1.2'
gem 'activesupport', '~> 7.1.2'
gem 'bundler', '>= 1.3.0'
gem 'railties', '~> 7.1.2'
# # RAILS DEPENDENCIES

# Remove and test without the following after rails and ruby are updated
gem 'concurrent-ruby', '1.3.4'

gem 'bunny', '>= 2.22.0'
gem 'rbtree', '~> 0.4.5'
gem 'sanger_warren', '~> 0.4.1'

gem 'bootsnap', '~> 1.7', '>= 1.7.3', require: false
gem 'hashie', '~> 5.0'
gem 'mysql2', '~> 0.5.3'

gem 'views_schema', github: 'sanger/views_schema'

group :test, :development do
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end

group :development do
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end
