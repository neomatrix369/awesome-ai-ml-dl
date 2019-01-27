#!/usr/bin/env bash

set -e
set -u
set -o pipefail

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