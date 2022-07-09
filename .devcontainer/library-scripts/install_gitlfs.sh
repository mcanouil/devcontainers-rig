#!/usr/bin/env bash

set -e

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

if [ "${INSTALL_ZSH}" = "true" ]; then
  apt_get_update_if_needed
  apt-get install -y --no-install-recommends curl libcurl4-openssl-dev

  # https://github.com/git-lfs/git-lfs/wiki/Installation
  curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && apt-get install git-lfs

  # Clean up
  apt-get autoremove -y
  apt-get autoclean -y
  rm -rf /var/lib/apt/lists/*
  rm -rf /tmp/*
fi
