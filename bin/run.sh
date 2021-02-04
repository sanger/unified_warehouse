#!/bin/sh
if test -z "${INTEGRATION_TEST_SETUP}" ; then
  ./bin/amqp_client start
else
  echo "Setting up for integration tests"
  RAILS_ENV=test bundle exec rake db:reset
  RAILS_ENV=test bundle exec rake db:views:schema:load
fi