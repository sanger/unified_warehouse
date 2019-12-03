# Unified Warehouse Builder

[![Build Status](https://travis-ci.org/sanger/unified_warehouse.svg?branch=develop)](https://travis-ci.org/sanger/unified_warehouse)

This application is a denormalised warehouse for multiple LIMS.

## Usage (Development)

1. Clone the git repository
1. Install the relevant ruby is installed - have a look in the `.ruby-version` file
1. Install bundler the version of bundler used to create the `Gemfile.lock`:

        gem install bundler -v $(tail -1 Gemfile.lock)
1. Install the relevant gems using bundler:

        bundle install
1. Ensure the test suite is running and passing:

        bundle exec rspec
