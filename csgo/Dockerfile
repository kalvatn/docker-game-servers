FROM steamcmd:latest

ENV GAME_ID 740
ENV GAME_NAME csgo
ENV GAME_PATH /mnt/steam/$GAME_NAME

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --no-install-recommends -y net-tools && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh /entrypoint.sh
COPY ./server.cfg /server.cfg

ENV SERVER_NAME "CS:GO Dedicated Server"
ENV SERVER_PASSWORD ""
ENV RCON_PASSWORD ""
ENV GSLT ""
ENV STEAM_API_KEY ""

ENV WORKSHOP_COLLECTION "1195239108"
ENV WORKSHOP_START_MAP "1190593932"

VOLUME /mnt/steam

EXPOSE 27015

ENTRYPOINT ["/entrypoint.sh"]

