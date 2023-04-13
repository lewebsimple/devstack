#!/bin/bash
set -e

# Load Apache environment variables
. /etc/apache2/envvars

# Remove existing PID file
if [ -f /var/run/apache2/apache2.pid ]; then
  rm -f /var/run/apache2/apache2.pid
fi

exec apache2 -DFOREGROUND "$@"
