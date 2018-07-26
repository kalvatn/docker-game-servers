#!/bin/sh

set -e

SETTINGS_SERVER="$DIR_CONFIG/config.json"

cp $SETTINGS_SERVER_TEMPLATE $SETTINGS_SERVER

sub_cfg() {
  sed -i "$1" "$SETTINGS_SERVER";
}

sub_cfg "s/CFG_MAX_PLAYERS/$CFG_MAX_PLAYERS/"
sub_cfg "s/CFG_SERVER_NAME/$CFG_SERVER_NAME/"
sub_cfg "s/CFG_SERVER_PASSWORD/$CFG_SERVER_PASSWORD/"

# https://tshock.readme.io/docs/command-line-parameters
exec mono-sgen --server -O=all TerrariaServer.exe \
  --stats-optout \
  -ignoreversion \
  -configpath $DIR_CONFIG \
  -worldpath $DIR_WORLD \
  -logpath $DIR_LOGS \
  -world $DIR_WORLD/world1.wld
