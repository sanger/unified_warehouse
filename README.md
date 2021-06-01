# Unified Warehouse Builder

[![Build Status](https://travis-ci.org/sanger/unified_warehouse.svg?branch=develop)](https://travis-ci.org/sanger/unified_warehouse)

A denormalised warehouse for multiple LIMS.

## Usage (Development)

### Requirement

1.  MySQL (currently 5.7) is required and usually installed with homebrew:

        brew install mysql@5.7
        brew link mysql@5.7 --force

### Installation

1.  Clone the git repository
2.  Install the relevant ruby from `.ruby-version`

    Rbenv will read .ruby-version automatically

         rbenv install

3.  Run the setup process:

        bin/setup

**NB**: If getting an error while installing the `mysql2` gem, try:

    bundle config build.mysql2 --with-opt-dir=$(brew --prefix openssl)

and try runnning `bundle install` again.

#### Database preparation

Before you can use the system in any capacity, you must first prepare the database.
This should be handled by `bin/setup` above, but if not:

    bundle exec rake db:setup

#### (Optional) Create the views

This project provides the view `cherrypicked_samples` that links data with
the event warehouse. To create the view you need to run the command:

    bundle exec rake db:views:schema:load

### Running tests

Ensure the test suite is running and passing:

    bundle exec rspec

### Integration tests

#### Setup

1. Initialize the integration tests setup for events warehouse (please check the
   Integration Tests setup section at <https://github.com/sanger/event_warehouse/#integration-tests-setup>)

2. Reset the database

       bundle exec rake db:reset

3. Create the dependent views

        bundle exec rake db:views:schema:load

These actions can also be performed automatically if you run the Docker container of the service
and pass the environment variables:

    RAILS_ENV="test"
    INTEGRATION_TEST_SETUP="true"

#### Running the integration tests

1.  Run the integration tests:

        bundle exec rspec --tag integration

### Execution

Execute the worker to pick up messages in the queue and process them into the
database:

        bundle exec warren consumer start

The consumer will run in the foreground, logging to the console. You can stop ti with Ctrl-C.

For more warren actions, either use `bundle exec warren help` or see the
[warren documentation](https://rubydoc.info/gems/sanger_warren)

### Preparing to run locally with Traction Service

RabbitMQ is essential for this process, so if you haven't already, install it using:

    brew install rabbitmq
    brew services start rabbitmq

You can now view the instance running at [http://localhost:15672/](http://localhost:15672/).

You may wish to start the warren consumers with:

    bundle exec warren consumers start --path='config/warren_traction_service_dev.yml'

This will adjust the configuration options to be compatible with those suggested in the traction setup.

Also see [managing custom configs](#manage-custom-configs)

### Mange Custom Configs

It is possible to run the consumers with a custom configuration, eg.

    bundle exec warren consumers start --path='config/my_customized_config.local.yml'

The `.gitignore` file will automatically prevent these configurations from being committed.

#### Troubleshooting

If you receive an error about a missing output file under `tmp/pid/` it may be that you need to create this directory manually.
Once the directory above has been inserted at the root of the repository, the error should go away.

#### How To Section

COG-UK Ids - These ids are given to positive samples imported through the Lighthouse-UI. This process should automatically record those Ids in the sample table, and also into the lighthouse_sample table.
To migrate COG-UK Ids into the lighthouse_sample table manually via SQL, see this Confluence page:
https://ssg-confluence.internal.sanger.ac.uk/display/PSD/How+to+migrate+Cog+UK+IDs+into+the+lighthouse_sample+table
