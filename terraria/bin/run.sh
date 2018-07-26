#!/bin/bash

set -e

docker run --rm -it \
  -p 7777:7777 \
  -v /mnt/terraria/world:/world \
  -v /mnt/terraria/tshock-plugins:/tshock/ServerPlugins \
  terraria-tshock:4.3.25-alpine
