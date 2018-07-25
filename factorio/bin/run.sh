#!/bin/bash

set -e
# sudo mkdir -p /mnt/factorio
# sudo chown 845:845 /mnt/factorio

docker run --rm -it \
  -p 34197:34197/udp \
  -p 34198:34198/tcp \
  -v /mnt/factorio:/factorio \
  dtandersen/factorio
