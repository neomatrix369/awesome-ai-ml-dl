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

export PATH="${HOME}/.local/bin:${PATH}"
echo "PATH=${PATH}"

echo ""
echo "~~~ A list of already installed kernels in your jupyter environment ~~~"
jupyter kernelspec list

echo ""
JAVA_KERNEL_VERSION=1.2.0
if [[ ! -e ijava-${JAVA_KERNEL_VERSION}.zip ]]; then
	echo "~~~ Downloading the Java kernel version ${JAVA_KERNEL_VERSION} ~~~"
	curl --location https://github.com/SpencerPark/IJava/releases/download/v${JAVA_KERNEL_VERSION}/ijava-${JAVA_KERNEL_VERSION}.zip \
     --output   ijava-${JAVA_KERNEL_VERSION}.zip
else
	echo "~~~ Found Java kernel version ${JAVA_KERNEL_VERSION}, using it instead. ~~~"
fi

echo ""
if [[ -e java ]] && [[ -e install.py ]]; then
	echo "~~~ Java kernel version ${JAVA_KERNEL_VERSION} already unzipped in the current folder ~~~"
else 
	echo "~~~ Unzipping the Java kernel version ${JAVA_KERNEL_VERSION} ~~~"
	unzip ijava-${JAVA_KERNEL_VERSION}.zip
fi

echo ""
echo "~~~ Python version (available environment) ~~~"
python --version

echo ""
echo "~~~ Using the install.py command to install Java kernel version ${JAVA_KERNEL_VERSION} for the available python environment ~~~ "
python install.py --sys-prefix

echo ""
echo "~~~ A list of already installed kernels in your jupyter environment ~~~ "
jupyter kernelspec list

sed '/\"java\",/a\
      \"-XX:+UnlockExperimentalVMOptions\",\
      \"-XX:+EnableJVMCI\",\
      \"-XX:+UseJVMCICompiler",\
'  /usr/share/jupyter/kernels/java/kernel.json