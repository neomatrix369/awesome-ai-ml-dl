#!/usr/bin/env bash

set -e
set -u
set -o pipefail

### Installation docs: https://docs.docker.com/install/linux/docker-ce/ubuntu/
echo "Installing Docker, target OS: Ubuntu 16.04 or higher"

SUDO_CMD=""
if [[ -f "/etc/sudoers" ]]; then
   SUDO_CMD=sudo
fi

${SUDO_CMD} apt-get remove docker docker-engine docker.io containerd runc

${SUDO_CMD} apt-get update

${SUDO_CMD} apt-get install  -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | ${SUDO_CMD} apt-key add -

${SUDO_CMD} apt-key fingerprint 0EBFCD88

${SUDO_CMD} add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

${SUDO_CMD} apt-get update

${SUDO_CMD} apt-get install -y docker-ce docker-ce-cli containerd.io

apt-cache madison docker-ce

${SUDO_CMD} docker run hello-world

echo "Finished installing and testing Docker"