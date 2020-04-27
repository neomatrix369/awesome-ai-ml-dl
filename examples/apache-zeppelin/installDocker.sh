#!/bin/bash

#
# Copyright 2019 Mani Sarkar
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e
set -u
set -o pipefail

### Installation docs: https://docs.docker.com/install/linux/docker-ce/ubuntu/
echo "Installing Docker, target OS: Ubuntu 16.04 or higher"

SUDO_CMD=""
if [[ -f "/etc/sudoers" ]]; then
   SUDO_CMD=sudo
fi

${SUDO_CMD} apt-get remove docker docker-engine docker.io containerd runc || true

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

${SUDO_CMD} groupadd docker || true
${SUDO_CMD} usermod -aG docker $USER
newgrp docker

docker run hello-world

echo "Finished installing and testing Docker"