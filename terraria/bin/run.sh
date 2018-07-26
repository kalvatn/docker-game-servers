#!/bin/bash

set -e

DIR_MOUNT=/mnt/terraria
sudo mkdir -p $DIR_MOUNT/config $DIR_MOUNT/world $DIR_MOUNT/logs
sudo chown -R 845:845 $DIR_MOUNT

ENTRYPOINT="/entrypoint.sh"
# ENTRYPOINT="/bin/sh"

read -sp "SERVER_PASSWORD : " SERVER_PASSWORD ; echo

docker run --rm -it \
  --entrypoint $ENTRYPOINT \
  -eCFG_SERVER_PASSWORD=$SERVER_PASSWORD \
  -p 7777:7777 \
  -v /mnt/terraria:/storage \
  terraria-tshock:4.3.25
