#!/bin/bash

set -e
# sudo mkdir -p /mnt/factorio
# sudo chown 845:845 /mnt/factorio
RCON_PORT=27015
RCON_PASSWORD=""
ADMIN_USERS=''
GAME_PASSWORD=""

docker run --rm -it \
  -p 34197:34197/udp \
  -p $RCON_PORT:$RCON_PORT/tcp \
  -e RCON_PASSWORD="$RCON_PASSWORD" \
  -e CFG_ADMIN_USERS="$ADMIN_USERS" \
  -e CFG_GAME_PASSWORD="$GAME_PASSWORD" \
  -v /mnt/factorio:/factorio \
  factorio-headless:0.16
