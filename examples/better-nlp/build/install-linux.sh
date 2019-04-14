#!/usr/bin/env bash

set -e
set -u
set -o pipefail

echo "Please check if you fulfill the requirements mentioned in the README file."

# Install and update necessary Linux packages

apt-get update && apt-get install -y --fix-missing \
                  wget curl liblapack-dev libswscale-dev pkg-config

apt-get install -y --fix-missing zip vim 

echo "fs.inotify.max_user_watches=100000" > /etc/sysctl.conf

# Install node and update npm
curl --silent --location https://deb.nodesource.com/setup_8.x | \
                                         bash - && apt-get install nodejs -y

./install-dependencies.sh