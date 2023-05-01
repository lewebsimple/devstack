#!/bin/bash
set -e

# Load Apache environment variables
. /etc/apache2/envvars

# Check UID / GID
usermod --non-unique --uid ${APACHE2_UID} www-data
groupmod --non-unique --gid ${APACHE2_GID} www-data
if [[ `stat -c '%u' /var/www` != "${APACHE2_UID}" ]]; then
  chown -R www-data:www-data /var/www /tmp
fi

# Remove existing PID file
if [ -f /var/run/apache2/apache2.pid ]; then
  rm -f /var/run/apache2/apache2.pid
fi

exec apache2 -DFOREGROUND "$@"
