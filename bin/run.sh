#!/bin/bash
#
# This script provides the funcionality to use the service for 
# testing purposes inside a Docker container. It allows you to
#
# - Initialize the testing database when INTEGRATION_TEST_SETUP is set
# - Start the service
#

# Default behaviour in bash is that a line with a failure doesnt break 
# the script, but it carries on. With these set of flags defined, if there is an 
# error during the script it will break; this minimise unexpected behaviours 
# in the script during a failure (like a fail in the condition check that 
# carries on and runs the next line).
# More info in: <https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/>
set -Eeuxo pipefail

if test "${INTEGRATION_TEST_SETUP:-}" = "true" ; then
  if test "${RAILS_ENV:-}" = "test"; then
    echo "Setting up for integration tests"
    RAILS_ENV=test bundle exec rake db:reset db:views:schema:load
  else
    echo "You are providing the flag INTEGRATION_TEST_SETUP, but RAILS_ENV"
    echo "is different from test, which it is a dangerous operation."
    echo "This script will stop."
    exit 1
  fi
fi

echo "Starting the service"
mkdir tmp/pids || true

./bin/amqp_client start
