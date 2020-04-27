#!/usr/bin/env bash

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

echo ""
echo "Installing Jupyter notebook and dependencies"

echo "JAVA_TOOL_OPTIONS=${JAVA_TOOL_OPTIONS:-}"
echo "Unsetting JAVA_TOOL_OPTIONS"
unset JAVA_TOOL_OPTIONS

export JAVA_HOME=/opt/java/openjdk/
export PATH=${JAVA_HOME}/bin:${PATH}

java -version
javac -version

SUDO_CMD=""
if [[ -f "/etc/sudoers" ]]; then
   SUDO_CMD=sudo
fi

${SUDO_CMD} apt-get update && \
    apt-get install -qy       \
    	unzip                 \
    	curl                  \
		python-pip            \
		python-setuptools     \
	--no-install-recommends && rm -r /var/lib/apt/lists/

python --version
pip --version

pip install --user --upgrade pip 
python -m pip install --user jupyter

export PATH="${HOME}/.local/bin:${PATH}"
echo "PATH=${PATH}"

jupyter --version