FROM debian:stretch-slim

RUN apt-get update && \
apt-get install --no-install-recommends -y \
debconf-utils=1.5.61 && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo steam steam/question select "I AGREE" | debconf-set-selections

RUN dpkg --add-architecture i386
RUN sed -i "/^deb/ s/$/ non-free/" /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive \
apt-get update && \
apt-get install --no-install-recommends -y \
ca-certificates="20161130+nmu1+deb9u1" \
steamcmd="0~20130205-1" && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

RUN /usr/games/steamcmd +login anonymous +quit

ENV STEAM_CMD /usr/games/steamcmd
ENV STEAM_HOME /mnt/steam

VOLUME $STEAM_HOME
ENTRYPOINT ["/usr/games/steamcmd"]
