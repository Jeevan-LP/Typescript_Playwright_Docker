#Purpose: Executes initial commands when the container starts.
#What it does:
#- Executes startup instructions.
#- Accepts test arguments.
#- Starts the Playwright test execution.
#- Can configure the environment before running tests.


#!/bin/sh
# Runs first when the container starts, then runs the test command.

set -eu
cd /app
 
# Install dependencies only if they are missing
if [ ! -f node_modules/@playwright/test/package.json ]; then
  echo "Installing dependencies..."
  npm ci
fi
 
# Show the settings coming from the Dockerfile / docker-compose.yml
echo "Browser: ${BROWSER:-chromium} | Environment: ${ENV_NAME:-QA}"
 
# Run the command received from CMD (or from docker compose run ...)
exec "$@"