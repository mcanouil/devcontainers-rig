#!/bin/bash
set -e

RIG_VERSION=${1:-${RIG_VERSION:-0.4.1}}

apt-get update
apt-get install -y --no-install-recommends \
  curl \
  libcurl4-openssl-dev \
  ca-certificates \
  bash-completion \
  sudo \
  gzip

curl -Ls https://github.com/r-lib/rig/releases/download/v${RIG_VERSION}/rig-linux-${RIG_VERSION}.tar.gz |
  sudo tar xz -C /usr/local

for rver in release 4.2 4.1 4.0; do
  rig add $rver
done

# rig system add-pak --all
