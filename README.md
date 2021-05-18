# Unified Warehouse Builder

[![Build Status](https://travis-ci.org/sanger/unified_warehouse.svg?branch=develop)](https://travis-ci.org/sanger/unified_warehouse)

This application is a denormalised warehouse for multiple LIMS.

## Usage (Development)

### Installation

1. Clone the git repository
2. Install the relevant ruby is installed

   ```bash Example using rbenv
   rbenv install
   ```

3. Install bundler the version of bundler used to create the `Gemfile.lock`:

   ```bash
   gem install bundler -v $(tail -1 Gemfile.lock)
   ```

4. Run the setup process:

   ```bash
   bin/setup
   ```

#### Database preparation

Before you can use the system in any capacity, you must first prepare the database.
This should be handled by `bin/setup` above, but if not:

```bash
bundle exec rake db:setup
```

#### (Optional) Create the views

This project provides with the view `cherrypicked_samples` that links data with
the event warehouse. To create the view you need to run the command:

```bash
bundle exec rake db:views:schema:load
```

### Running tests

Ensure the test suite is running and passing:

```bash
bundle exec rspec
```

### Integration tests

#### Setup

1. Initialize the integration tests setup for events warehouse (please check the
   Integration Tests setup section at <https://github.com/sanger/event_warehouse/>)

2. Reset the database

   ```bash
   bundle exec rake db:reset
   ```

3. Create the dependent views

   ```bash
   bundle exec rake db:views:schema:load
   ```

These actions can also be performed automatically if you run the Docker container of the service
and pass the environment variables:

```bash
RAILS_ENV="test"
INTEGRATION_TEST_SETUP="true"
```

#### Running the integration tests

1. Run the integration tests:

   ```bash
   bundle exec rspec --tag integration
   ```

### Execution

Execute the worker to pick up messages in the queue and process them into the
database:

```bash
bundle exec warren consumer start
```

The consumer will run in the foreground, logging to the console. You can stop ti with Ctrl-C.

### Preparing to run locally with Traction Service

RabbitMQ is essential for this process, so if you haven't already, install it using:

```bash
brew install rabbitmq
brew services start rabbitmq
```

You can now view the instance running at [http://localhost:15672/](http://localhost:15672/).

You may wish to start the warren consumers with:

```bash
bundle exec warren consumers start --path='config/warren_traction_dev.yml'
```

This will adjust the configuration options to be compatible with those suggested in the traction setup.

#### Troubleshooting

If you receive an error about a missing output file under `tmp/pid/` it may be that you need to create this directory manually.
Once the directory above has been inserted at the root of the repository, the error should go away.

#### How To Section

Cog Uk Ids - These ids are given to positive samples imported through the Lighthouse-UI. This process should automatically record those Ids in the sample table, and also into the lighthouse_sample table.
To migrate Cog Uk Ids into the lighthouse_sample table manually via SQL, see this Confluence page:
https://ssg-confluence.internal.sanger.ac.uk/display/PSD/How+to+migrate+Cog+UK+IDs+into+the+lighthouse_sample+table
