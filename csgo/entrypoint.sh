#!/bin/bash

set -e

echo "updating and validating $GAME_NAME ($GAME_ID) located at $GAME_PATH ..."
# $STEAM_CMD +login anonymous +force_install_dir $GAME_PATH +app_update $GAME_ID validate +quit
$STEAM_CMD +login anonymous +force_install_dir $GAME_PATH +app_update $GAME_ID +quit

IP_ADDRESS="$(ifconfig eth0 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"

sed -i "s/SERVER_NAME/$SERVER_NAME/" /server.cfg
sed -i "s/RCON_PASSWORD/$RCON_PASSWORD/" /server.cfg
sed -i "s/SERVER_PASSWORD/$SERVER_PASSWORD/" /server.cfg

cp /server.cfg $GAME_PATH/csgo/cfg/server.cfg

cd $GAME_PATH

# ./srcds_run \
#   -game csgo \
#   -usercon \
#   -net_port_try 1 \
#   +net_public_adr "$IP_ADDRESS" \
#   +ip "$IP_ADDRESS" -port 27015 \
#   +sv_setsteamaccount "$GSLT" \
#   +game_type 0 \
#   +game_mode 1 \
#   -authkey "$STEAM_API_KEY" \
#   +host_workshop_collection "$WORKSHOP_COLLECTION" \
#   +workshop_start_map "$WORKSHOP_START_MAP" \
#   +map de_dust2
#   # +exec esl_csgo_configs/esl5on5.cfg

./srcds_run \
  -game csgo \
  -usercon \
  -authkey "$STEAM_API_KEY" \
  +sv_setsteamaccount "$GSLT" \
  +host_workshop_collection "$WORKSHOP_COLLECTION" \
  +workshop_start_map "$WORKSHOP_START_MAP" \
  +game_type 0 \
  +game_mode 1 \
  +map de_dust2
