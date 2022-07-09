#!/usr/bin/env bash

set -e

USER_LANG=${1:-${USER_LANG:-en_GB.UTF-8}}

export DEBIAN_FRONTEND=noninteractive

if ! grep -o -E "^\s*${USER_LANG}\s+UTF-8" /etc/locale.gen > /dev/null; then
    echo "${USER_LANG} UTF-8" >> /etc/locale.gen 
    locale-gen
fi

# Clean up
apt-get autoremove -y
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
strip /usr/local/lib/R/site-library/*/libs/*.so
