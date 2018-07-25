FROM frolvlad/alpine-glibc:alpine-3.8

ENV FACTORIO_VERSION=0.16.51 \
DIR_FACTORIO=/opt/factorio \
DIR_MOUNT=/factorio

ENV DIR_SAVES="$DIR_MOUNT/saves" \
DIR_CONFIG="$DIR_MOUNT/config" \
DIR_MODS="$DIR_MOUNT/mods" \
DIR_SCENARIOS="$DIR_MOUNT/scenarios" \
DIR_SCRIPT_OUTPUT="$DIR_MOUNT/script-output" \
SETTINGS_SERVER_TEMPLATE=/server-settings-template.json \
PORT_GAME=34197 \
PORT_RCON=27015 \
RCON_PASSWORD="" \
CFG_SERVER_NAME="Factorio Dedicated Server"
CFG_SERVER_DESCRIPTION="Factorio Dedicated Server"
CFG_SERVER_TAGS="\"factorio\""
CFG_MAX_PLAYERS=10 \
CFG_VISIBILITY_PUBLIC_ENABLED=false \
CFG_VISIBILITY_LAN_ENABLED=true \
CFG_FACTORIO_LOGIN_USERNAME="" \
CFG_FACTORIO_LOGIN_PASSWORD="" \
CFG_FACTORIO_LOGIN_TOKEN="" \
CFG_GAME_PASSWORD="" \
CFG_REQUIRE_USER_VERIFICATION=false \
CFG_ALLOW_COMMANDS="admins-only" \
CFG_AUTO_PAUSE_ENABLED=true \
CFG_ADMIN_USERS="" \
SYS_USER=factorio \
SYS_GROUP=factorio \
SYS_PUID=845 \
SYS_PGID=845 \
TAR_FILE=/tmp/factorio_headless_x64.tar.xz

RUN env

RUN mkdir -p /opt $DIR_MOUNT && \
apk --update add --no-cache --virtual build-dependencies curl && \
curl -sSL "https://www.factorio.com/get-download/$FACTORIO_VERSION/headless/linux64" -o $TAR_FILE && \
tar xf $TAR_FILE --directory /opt && rm $TAR_FILE && \
ln -s $DIR_SAVES $DIR_FACTORIO/saves && \
ln -s $DIR_MODS $DIR_FACTORIO/mods && \
ln -s $DIR_SCENARIOS $DIR_FACTORIO/scenarios && \
ln -s $DIR_SCRIPT_OUTPUT $DIR_FACTORIO/script-output && \
addgroup -g $SYS_PGID -S $SYS_GROUP && \
adduser -u $SYS_PUID -G $SYS_GROUP -s /bin/sh -SDH $SYS_USER && \
chown -R $SYS_USER:$SYS_GROUP $DIR_FACTORIO $DIR_MOUNT && \
apk del build-dependencies && rm -rf /var/cache/apk/*

COPY config/server-settings.json "$SETTINGS_SERVER_TEMPLATE"
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER "$USER"

VOLUME "$DIR_MOUNT"

EXPOSE $PORT_GAME/udp $PORT_RCON/tcp

ENTRYPOINT ["/entrypoint.sh"]
