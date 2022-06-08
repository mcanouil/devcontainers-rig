#!/bin/bash
set -e

RIG_VERSION=${1:-${RIG_VERSION:-0.4.1}}

apt-get update && apt-get install -y --no-install-recommends curl libcurl4-openssl-dev bash-completion

curl -Ls https://github.com/r-lib/rig/releases/download/v${RIG_VERSION}/rig-linux-${RIG_VERSION}.tar.gz |
  sudo tar xz -C /usr/local

rig add 4.0 4.1 4.2
rig default 4.2
rig system add-pak --all
