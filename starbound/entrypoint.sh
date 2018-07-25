#!/bin/bash

set -e

echo "updating and validating $GAME_NAME ($GAME_ID) located at $GAME_PATH ..."
# $STEAM_CMD +login "$STEAM_USER" "$STEAM_PASS" +force_install_dir $GAME_PATH +app_update $GAME_ID validate +quit
$STEAM_CMD +login anonymous +force_install_dir $GAME_PATH +app_update $GAME_ID validate +quit

sed -i "s/SERVER_NAME/$SERVER_NAME/" /starbound_server.config
sed -i "s/RCON_PASSWORD/$RCON_PASSWORD/" /starbound_server.config
sed -i "s/ADMIN_USERNAME/$ADMIN_USERNAME/" /starbound_server.config
sed -i "s/ADMIN_PASSWORD/$ADMIN_PASSWORD/" /starbound_server.config
sed -i "s/PLAYER_USERNAME/$PLAYER_USERNAME/" /starbound_server.config
sed -i "s/PLAYER_PASSWORD/$PLAYER_PASSWORD/" /starbound_server.config

cp /starbound_server.config $GAME_PATH/storage/starbound_server.config

cd $GAME_PATH/linux
./starbound_server
