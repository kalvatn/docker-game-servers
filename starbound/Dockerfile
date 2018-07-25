FROM steamcmd:latest

ENV GAME_ID 211820
ENV GAME_NAME starbound
ENV GAME_PATH $STEAM_HOME/$GAME_NAME

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install --no-install-recommends -y libvorbisfile3 && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
COPY starbound_server.config /starbound_server.config

ENV SERVER_NAME "Starbound Dedicated Server"
ENV RCON_PASSWORD ""
ENV PLAYER_USERNAME "player"
ENV PLAYER_PASSWORD ""
ENV ADMIN_USERNAME "admin"
ENV ADMIN_PASSWORD ""

VOLUME /mnt/steam

EXPOSE 21025 21026

ENTRYPOINT ["/entrypoint.sh"]
