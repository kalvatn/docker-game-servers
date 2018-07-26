FROM frolvlad/alpine-mono

ENV TSHOCK_VERSION=4.3.25 \
DIR_MOUNT=/storage \
DIR_TSHOCK=/tshock

ENV DIR_WORLD="$DIR_MOUNT/world" \
DIR_CONFIG="$DIR_MOUNT/config" \
DIR_LOGS="$DIR_MOUNT/logs" \
DIR_PLUGINS="$DIR_TSHOCK/ServerPlugins" \
SETTINGS_SERVER_TEMPLATE=/config-template.json \
ZIP_FILE="tshock_$TSHOCK_VERSION.zip" \
CFG_MAX_PLAYERS=8 \
CFG_SERVER_NAME="Terraria TShock Server" \
CFG_SERVER_PASSWORD="" \
SYS_USER=terraria \
SYS_GROUP=terraria \
SYS_PUID=845 \
SYS_PGID=845

ADD "https://github.com/NyxStudios/TShock/releases/download/v$TSHOCK_VERSION/$ZIP_FILE" .

RUN mkdir -p $DIR_TSHOCK && \
ln -sf $DIR_LOGS/server.log $DIR_TSHOCK/ServerLog.txt && \
unzip $ZIP_FILE -d $DIR_TSHOCK && \
rm $ZIP_FILE && \
addgroup -g $SYS_PGID -S $SYS_GROUP && \
adduser -u $SYS_PUID -G $SYS_GROUP -s /bin/sh -SD $SYS_USER

COPY config/config-template.json $SETTINGS_SERVER_TEMPLATE
COPY entrypoint.sh /entrypoint.sh

COPY plugins/* $DIR_PLUGINS

RUN chown -R $SYS_USER:$SYS_GROUP $DIR_TSHOCK

USER $SYS_USER

WORKDIR $DIR_TSHOCK

VOLUME $DIR_MOUNT

ENTRYPOINT ["/entrypoint.sh"]
