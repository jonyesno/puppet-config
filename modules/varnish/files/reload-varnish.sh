#!/usr/bin/env bash

STAMP=$( date '+%Y%m%d-%H%M%S' )

fail() {
  echo "[reload-varnish] FAILED"
  exit 1
}

trap fail ERR

echo "[reload-varnish] current configurations"
varnishadm vcl.list

echo "[reload-varnish] loading new configuration"
varnishadm vcl.load ${STAMP} /etc/varnish/local.vcl

echo "[reload-varnish] current configurations"
varnishadm vcl.list

echo "[reload-varnish] switch new configuration in"
varnishadm vcl.use ${STAMP}

echo "[reload-varnish] current configurations"
varnishadm vcl.list
