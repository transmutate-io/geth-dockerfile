#!/bin/sh
set -e

# default is to call geth withoud args or with the provided args
if [ "$1" = "" ] || [ "$(echo $1|cut -b 1)" = "-" ]; then
  set -- geth "$@"
fi

exec "$@"
