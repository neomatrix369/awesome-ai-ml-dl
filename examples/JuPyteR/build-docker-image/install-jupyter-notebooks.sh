#!/usr/bin/env bash

set -e
set -u
set -o pipefail

echo ""
echo "Installing Jupyter notebook and dependencies"

export JAVA_HOME=/opt/java/openjdk/
export PATH=${JAVA_HOME}/bin:${PATH}

java --version
javac --version

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