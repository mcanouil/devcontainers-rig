#!/usr/bin/env bash

set -e

RIG_VERSION=${1:-${RIG_VERSION:-latest}}

export DEBIAN_FRONTEND=noninteractive

# Function to call apt-get if needed
apt_get_update_if_needed()
{
    if [ ! -d "/var/lib/apt/lists" ] || [ "$(ls /var/lib/apt/lists/ | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update
    else
        echo "Skipping apt-get update."
    fi
}

apt_get_update_if_needed
apt-get install -y --no-install-recommends
    curl \
    libcurl4-openssl-dev \
    ca-certificates \
    bash-completion \
    gzip

curl -Ls "https://github.com/r-lib/rig/releases/download/${RIG_VERSION}/rig-linux-${RIG_VERSION#v}.tar.gz" |
    sudo tar xz -C /usr/local

for rver in release 4.2 4.1 4.0; do
    rig add $rver
done

# rig system add-pak --all

# Clean up
apt-get autoremove -y
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
strip /usr/local/lib/R/site-library/*/libs/*.so
