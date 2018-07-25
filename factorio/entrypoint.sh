#!/bin/sh
set -e

mkdir -p $DIR_SAVES $DIR_CONFIG $DIR_MODS $DIR_SCENARIOS $DIR_SCRIPTOUTPUT

SETTINGS_SERVER="$DIR_CONFIG/server-settings.json"
SETTINGS_MAP_GEN="$DIR_CONFIG/map-gen-settings.json"
SETTINGS_MAP="$DIR_CONFIG/map-settings.json"
cp "$SETTINGS_SERVER_TEMPLATE" "$SETTINGS_SERVER"

# cat config/server-settings.json | grep CFG_ | sed -E "s/^.*(CFG_[A-Z\_]+).*$/sed -i \"s\/\1\/$\1\/\" $SETTINGS_SERVER/"

sub_cfg() {
  sed -i "$1" "$SETTINGS_SERVER";
}

sub_cfg "s/CFG_SERVER_NAME/$CFG_SERVER_NAME/"
sub_cfg "s/CFG_SERVER_DESCRIPTION/$CFG_SERVER_DESCRIPTION/"
sub_cfg "s/CFG_MAX_PLAYERS/$CFG_MAX_PLAYERS/"
sub_cfg "s/CFG_VISIBILITY_PUBLIC_ENABLED/$CFG_VISIBILITY_PUBLIC_ENABLED/"
sub_cfg "s/CFG_VISIBILITY_LAN_ENABLED/$CFG_VISIBILITY_LAN_ENABLED/"
sub_cfg "s/CFG_FACTORIO_LOGIN_USERNAME/$CFG_FACTORIO_LOGIN_USERNAME/"
sub_cfg "s/CFG_FACTORIO_LOGIN_PASSWORD/$CFG_FACTORIO_LOGIN_PASSWORD/"
sub_cfg "s/CFG_FACTORIO_LOGIN_TOKEN/$CFG_FACTORIO_LOGIN_TOKEN/"
sub_cfg "s/CFG_GAME_PASSWORD/$CFG_GAME_PASSWORD/"
sub_cfg "s/CFG_REQUIRE_USER_VERIFICATION/$CFG_REQUIRE_USER_VERIFICATION/"
sub_cfg "s/CFG_ALLOW_COMMANDS/$CFG_ALLOW_COMMANDS/"
sub_cfg "s/CFG_AUTO_PAUSE_ENABLED/$CFG_AUTO_PAUSE_ENABLED/"
sub_cfg "s/CFG_ADMIN_USERS/$CFG_ADMIN_USERS/"

if [ ! -f $SETTINGS_MAP_GEN ]; then
  cp "$DIR_FACTORIO/data/map-gen-settings.example.json" $SETTINGS_MAP_GEN
fi

if [ ! -f $SETTINGS_MAP ]; then
  cp "$DIR_FACTORIO/data/map-settings.example.json" $SETTINGS_MAP
fi

if find -L $DIR_SAVES -iname \*.tmp.zip -mindepth 1 -print | grep -q .; then
  rm -f $DIR_SAVES/*.tmp.zip
fi

if ! find -L $DIR_SAVES -iname \*.zip -mindepth 1 -print | grep -q .; then
  "$DIR_FACTORIO/bin/x64/factorio" \
    --create $DIR_SAVES/_autosave1.zip  \
    --map-gen-settings $SETTINGS_MAP_GEN \
    --map-settings $SETTINGS_MAP
fi

exec "$DIR_FACTORIO/bin/x64/factorio" \
  --port $PORT_GAME \
  --rcon-port $PORT_RCON \
  --rcon-password $RCON_PASSWORD \
  --server-settings $SETTINGS_SERVER \
  --server-whitelist $DIR_CONFIG/server-whitelist.json \
  --server-banlist $DIR_CONFIG/server-banlist.json \
  --server-id $DIR_CONFIG/server-id.json \
  --start-server-load-latest \
  $@
