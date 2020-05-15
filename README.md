# Unified Warehouse Builder

[![Build Status](https://travis-ci.org/sanger/unified_warehouse.svg?branch=develop)](https://travis-ci.org/sanger/unified_warehouse)

This application is a denormalised warehouse for multiple LIMS.

## Usage (Development)

### Installation

1. Clone the git repository
1. Install the relevant ruby is installed - have a look in the `.ruby-version` file
1. Install bundler the version of bundler used to create the `Gemfile.lock`:

       gem install bundler -v $(tail -1 Gemfile.lock)

1. Install the relevant gems using bundler:

       bundle install

### Database preparation

Before you can use the system in any capacity, you must first prepare the database:

1. `bundle exec rake db:create`
1. `bundle exec rake db:structure:load`
1. `bundle exec rake db:seed`

### Running tests

Ensure the test suite is running and passing:

    bundle exec rspec

### Execution

Execute the worker to pick up messages in the queue and process them into the database:

    bundle exec ./script/worker 1 start

where `1` is an identifier for the worker, and `start` instructs it to start.
You can also stop a worker by calling `stop` or restart it with `restart`.
