#!/bin/bash
set -Eeuxo pipefail

if test "${INTEGRATION_TEST_SETUP:-}" = "true" ; then
  echo "Setting up for integration tests"
  RAILS_ENV=test bundle exec rake db:reset
fi

echo "Starting the service"
mkdir tmp/pids || true

./bin/amqp_client start
