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

downloadJar() {
	echo ""
	echo "~~~ A list of already installed kernels in your jupyter environment ~~~"
	jupyter kernelspec list

	echo ""
	if [[ ! -e ijava-${JAVA_KERNEL_VERSION}.zip ]]; then
		echo "~~~ Downloading the Java kernel version ${JAVA_KERNEL_VERSION} ~~~"
		JAR_ARTIFACT="https://github.com/SpencerPark/IJava/releases/download/v${JAVA_KERNEL_VERSION}/ijava-${JAVA_KERNEL_VERSION}.zip"
		curl --location ${JAR_ARTIFACT} \
	         --output ijava-${JAVA_KERNEL_VERSION}.zip
	else
		echo "~~~ Found Java kernel version ${JAVA_KERNEL_VERSION}, using it instead. ~~~"
	fi
}

unzipKernelZip() {
	echo ""
	if [[ -e java ]] && [[ -e install.py ]]; then
		echo "~~~ Java kernel version ${JAVA_KERNEL_VERSION} already unzipped in the current folder ~~~"
	else 
		echo "~~~ Unzipping the Java kernel version ${JAVA_KERNEL_VERSION} ~~~"
		unzip ijava-${JAVA_KERNEL_VERSION}.zip
		echo "~~~ Finished unzipping the Java kernel version ${JAVA_KERNEL_VERSION} ~~~"
	fi

	rm -f ijava-${JAVA_KERNEL_VERSION}.zip && echo "~~~ Removed the downloaded artifact"
}

buildJar(){
	echo "~~~ Building jar from source"
	rm -fr IJava && echo "Removed old/existing IJava folder"
	echo "Cloning repo frankfliu/IJava"
	git clone https://github.com/frankfliu/IJava
	PROJECT_FOLDER=$(pwd)
	cd IJava
	git checkout exec
	echo "Build project using gradle (zipped kernel)"
	chmod u+x gradlew && ./gradlew zipKernel
	pwd
	cp "build/distributions/ijava-${JAVA_KERNEL_VERSION}.zip" ${PROJECT_FOLDER}
	cd ${PROJECT_FOLDER}
	echo "ijava-${JAVA_KERNEL_VERSION}.zip created in ${PROJECT_FOLDER}"
}

installJar() {
	if [[ ! -d "java" ]]; then
		echo "Kernel 'java' not found, are you sure this is the right folder?"
		echo "Did you download the kernel before calling install, like the below command?"
		echo ""; echo "       $0 --downloadJar"; echo ""
		exit -1
	fi

	# Used when using valohai/jupyhai or /opt/conda/share/jupyter/kernels as base image
	KERNEL_CONFIG_FOLDER="/opt/conda/share/jupyter/kernels"
	ALT_KERNEL_CONFIG_FOLDER="$HOME/.local/share/jupyter/kernels/"
	
    # Using jupyter/repo2docker as base image
	# KERNEL_CONFIG_FOLDER="/usr/local/share/jupyter/kernels"
	if [[ ! -e "${KERNEL_CONFIG_FOLDER}" ]]; then
		if [[ ! -e ${ALT_KERNEL_CONFIG_FOLDER} ]]; then
			echo "${KERNEL_CONFIG_FOLDER} not found, try a different path"
			exit -1
		else
		   KERNEL_CONFIG_FOLDER="${ALT_KERNEL_CONFIG_FOLDER}"
		fi
	fi

	export PATH="${HOME}/.local/bin:${PATH}"
	echo "PATH=${PATH}"

	echo ""
	echo "~~~ Python version (available environment) ~~~"
	python --version

	echo ""
	echo "~~~ Using the install.py command to install Java kernel version ${JAVA_KERNEL_VERSION} for the available python environment ~~~ "
	exit_code=0
	python install.py --sys-prefix || true && exit_code=$?
	if [[ ${exit_code} -ne 0 ]]; then
		echo "Retrying installation using: python install.py --user"
		python install.py --user
	fi

	echo ""
	echo "~~~ A list of already installed kernels in your jupyter environment ~~~ "
	jupyter kernelspec list

	sed '/\"java\",/a\
	      \"-XX:+UnlockExperimentalVMOptions\",\
	      \"-XX:+EnableJVMCI\",\
	      \"-XX:+UseJVMCICompiler",\
	'  ${KERNEL_CONFIG_FOLDER}/java/kernel.json

	echo "Removing left over folder and installation file"
	rm -fr java
	rm -f install.py
}

showUsageText() {
    cat << HEREDOC

       Usage: $0 --downloadJar
                                       --buildJar
                                       --installJar
                                       --help

       --downloadJar             (command action) download the jar from
                                 SpencerPark/IJava GitHub release page
       --buildJar                (command action) build the SpencerPark/IJava 
                                 interpreter from source 
       --installJar              (command action) install the jar after downloading or 
                                 building from source
       --help                    shows the script usage help text

HEREDOC

	exit 1
}

JAVA_KERNEL_VERSION=1.3.0

if [[ "$#" -eq 0 ]]; then
	echo "No parameter has been passed. Please see usage below:"
	showUsageText
fi

while [[ "$#" -gt 0 ]]; do case $1 in
  --help)                  showUsageText;
                           exit 0;;
  --downloadJar)           downloadJar;; 
  --buildJar)              buildJar;;
  --installJar)            unzipKernelZip;
                           installJar;
                           exit 0;;
  *) echo "Unknown parameter passed: $1";
     showUsageText;
esac; shift; done