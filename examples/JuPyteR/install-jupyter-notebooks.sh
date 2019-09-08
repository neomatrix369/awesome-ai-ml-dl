#!/usr/bin/env bash

set -e
set -u
set -o pipefail

echo ""
echo "Installing Jupyter Lab and dependencies"

export JAVA_HOME=/opt/java/openjdk/
export PATH=${JAVA_HOME}/bin:${PATH}
echo "JDK9, Linux only: We are enabling JVMCI flags (enabling Graal as Tier-2 compiler)"
echo "Graal setting: please check docs for higher versions of Java and for other platforms"
export JAVA_OPTS="-XX:+UnlockExperimentalVMOptions -XX:+EnableJVMCI -XX:+UseJVMCICompiler"

echo "JAVA_OPTS=${JAVA_OPTS}"

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