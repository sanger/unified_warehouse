# Unified Warehouse Builder

[![Build Status](https://travis-ci.org/sanger/unified_warehouse.svg?branch=develop)](https://travis-ci.org/sanger/unified_warehouse)

A denormalised warehouse for multiple LIMS.

Populating a table in the warehouse is done asynchronously. This project is a Railtie application that facilitate asynchronous database population through a message queue. This application listens to a message queue, consumes the message, converts the message into a database model, and persists in the corresponding table. 

Take the example below.

```json
{
    "lims": "traction",
    "aliquot": {
        "id_lims": "LIMS123456",
        "lims_uuid": "550e8400-e29b-41d4-a716-446655440000",
        "aliquot_type": "DNA",
        "source_type": "Blood",
        "source_barcode": "SRC123456",
        "sample_name": "SampleA",
        "used_by_type": "Research",
        "used_by_barcode": "USR123456",
        "volume": 50,
        "concentration": 200,
        "last_updated": "2024-07-09T10:15:30Z",
        "recorded_at": "2024-07-09T09:00:00Z",
        "created_at": "2024-07-08T08:00:00Z",
        "insert_size": 350
    }
}
```

If the message above is consumed by `unified_warehouse`, it will create a new record in `aliquot` table with the values set to the given attributes.

## Usage (Development)

### Requirement

1. MySQL (currently 8.0) is required and usually installed with homebrew:

       brew install mysql@8.0
       brew link mysql@8.0 --force

### Installation

1. Clone the git repository
2. Install the relevant ruby from `.ruby-version`  
    Rbenv will read .ruby-version automatically   
   `rbenv install`

3. Run the setup process:  
    3.1. Set up your MySQL root password inside the file config/database.yml  
    3.2. Run `bin/setup ` 

**NB**: If getting an error while installing the `mysql2` gem, try:

    bundle config build.mysql2 --with-opt-dir=$(brew --prefix openssl)
    
if that doesn't work, try:

       gem install mysql2 -- \
        --with-mysql-lib=/Users/your_user/homebrew/Cellar/mysql/your_version/lib \
        --with-mysql-dir=/Users/your_user/homebrew/Cellar/mysql/your_version  \
        --with-mysql-config=/Users/your_user/homebrew/Cellar/mysql/your_version/bin/mysql_config \
        --with-mysql-include=/Users/your_user/homebrew/Cellar/mysql/your_version/include

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

1. Run the integration tests:

        bundle exec rspec --tag integration

### Execution

Execute the worker to pick up messages in the queue and process them into the
database:

        bundle exec warren consumer start

The consumer will run in the foreground, logging to the console. You can stop it with Ctrl-C.

For more warren actions, either use `bundle exec warren help` or see the
[warren documentation](https://rubydoc.info/gems/sanger_warren)

### Preparing to run locally with Traction Service

RabbitMQ is essential for this process, so if you haven't already, install it using:

    brew install rabbitmq
    brew services start rabbitmq

You can now view the instance running at [http://localhost:15672/](http://localhost:15672/).

You may wish to start the warren consumers with:

    bundle exec warren consumer start --path='config/warren_traction_service_dev.yml'

This will adjust the configuration options to be compatible with those suggested in the traction setup.

Also see [managing custom configs](#manage-custom-configs)

### Manage Custom Configs

It is possible to run the consumers with a custom configuration, eg.

    bundle exec warren consumer start --path='config/my_customized_config.local.yml'

The `.gitignore` file will automatically prevent these configurations from being committed.

#### Troubleshooting

If you receive an error about a missing output file under `tmp/pid/` it may be that you need to create this directory manually.
Once the directory above has been inserted at the root of the repository, the error should go away.

#### How To Section

COG-UK Ids - These ids are given to positive samples imported through the Lighthouse-UI. This process should automatically record those Ids in the sample table, and also into the lighthouse_sample table.
To migrate COG-UK Ids into the lighthouse_sample table manually via SQL, see [this Confluence page](https://ssg-confluence.internal.sanger.ac.uk/display/PSD/How+to+migrate+Cog+UK+IDs+into+the+lighthouse_sample+table).
