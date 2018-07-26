FROM frolvlad/alpine-mono

ENV TSHOCK_VERSION=4.3.25

ADD "https://github.com/NyxStudios/TShock/releases/download/v$TSHOCK_VERSION/tshock_$TSHOCK_VERSION.zip" /tmp

RUN mkdir /world /tshock && \
touch /world/server.log && \
ln -s /world/server.log /tshock/ServerLog.txt && \
unzip /tmp/tshock_$TSHOCK_VERSION.zip -d /tshock && \
rm /tmp/tshock_$TSHOCK_VERSION.zip && \
chmod 777 /tshock/TerrariaServer.exe

COPY entrypoint.sh /entrypoint.sh

WORKDIR /tshock

VOLUME ["/world", "/tshock/ServerPlugins"]

ENTRYPOINT ["/entrypoint.sh"]
