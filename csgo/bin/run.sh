#!/bin/bash

set -e

SERVER_NAME="CS:GO Dedicated Server"
SERVER_PASSWORD=""
RCON_PASSWORD=""
GSLT=""

read -sp "SERVER_PASSWORD: " SERVER_PASSWORD
echo
read -sp "RCON_PASSWORD: " RCON_PASSWORD
echo

docker run --rm -it \
  -eSERVER_NAME="$SERVER_NAME" \
  -eSERVER_PASSWORD="$SERVER_PASSWORD" \
  -eRCON_PASSWORD="$RCON_PASSWORD" \
  -eGSLT="$GSLT" \
  -v /mnt/steam:/mnt/steam \
  csgo
