#!/bin/bash

set -e

echo `whoami`

ulimit -n 300000

# wait for weave network?
sleep 5

# Add elasticsearch as command if needed
if [ "${1:0:1}" = '-' ]; then
  set -- elasticsearch "$@"
fi

# Drop root privileges if we are running elasticsearch
if [ "$1" = 'elasticsearch' ]; then
  # Change the ownership of /usr/share/elasticsearch/data to elasticsearch
  chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data
  exec gosu elasticsearch "$@"
fi

# As argument is not related to elasticsearch,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
