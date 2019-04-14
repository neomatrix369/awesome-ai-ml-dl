#!/usr/bin/env bash

set -e
set -u
set -o pipefail

echo "Please check if you fulfill the requirements mentioned in the README file."

# Install and update necessary MacOS packages

brew update && brew install -y wget curl liblapack-dev libswscale-dev pkg-config

brew install -y --fix-missing zip vim

# Install node and update npm
curl --silent --location https://deb.nodesource.com/setup_8.x | bash - && brew install -y nodejs

./install-dependencies.sh