#!/bin/sh

set -e

# https://tshock.readme.io/docs/command-line-parameters
exec mono --server --gc=sgen -O=all TerrariaServer.exe \
  --stats-optout \
  -configpath /world \
  -worldpath /world \
  -logpath /world \
  -world /world/world1.wld
