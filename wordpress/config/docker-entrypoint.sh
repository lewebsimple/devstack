#!/bin/bash
set -e

. /etc/apache2/envvars

exec apache2 -DFOREGROUND "$@"
