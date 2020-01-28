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

source common.sh

showUsageText() {
    cat << HEREDOC

       Usage: $0 --buildUberJar
                 --extract   [/path/to/JAR file]
                 --build     [/path/to/JAR file]
                 --test      [/path/to/native-image file]

       --buildUberJar                                   build the Uber jar before building the native image
       --extract          [/path/to/JAR file]           extract the Jar file configuration information and
                                                        save into the META-INF folder
       --buildNativeImage [/path/to/JAR file]           build the native image from the Jar file provided
       --test             [/path/to/native-image file]  test the native image
       --help                                           shows the script usage help text

HEREDOC
}

IMAGE_NAME=""
SHOW_STACK_TRACES=${SHOW_STACK_TRACES:-}
OPTIONS=""

GRAKN_VERSION=${GRAKN_VERSION:-$(cat grakn_version.txt)}

checkForJarFileParam() {
	if [[ -z "${JARFILE:-}" ]]; then
		echo "Jar file not provided as argument to script."
		showUsageText

		exit -1
	fi
}

setupVariables() {
	checkForJarFileParam

	IMAGE_NAME=$(basename ${JARFILE%.*})
	# --enable-all-security-services --enable-http --enable-https --enable-url-protocols
	OPTIONS="${2:-} --no-fallback --no-fallback --report-unsupported-elements-at-runtime --allow-incomplete-classpath"
	OPTIONS="${OPTIONS} -H:ReflectionConfigurationFiles=${PWD}/META-INF/native-image/reflect-config.json"
	OPTIONS="${OPTIONS} -H:DynamicProxyConfigurationFiles=${PWD}/META-INF/native-image/proxy-config.json"
	OPTIONS="${OPTIONS} -H:ResourceConfigurationFiles=${PWD}/META-INF/native-image/resource-config.json"
	OPTIONS="${OPTIONS} -H:JNIConfigurationFiles=${PWD}/META-INF/native-image/jni-config.json"

	if [[ "${SHOW_STACK_TRACES}" = "true" ]]; then
	   OPTIONS="${OPTIONS} -H:+ReportExceptionStackTraces"
	fi

	performChecks
}

performChecks() {
	checkForJava
	checkForGraalVM
	checkForGu
	checkForNativeImage
}

buildUberJar() {
	PROJECT_ROOT_FOLDER=$(pwd)

	cd ${PROJECT_ROOT_FOLDER}/shared

	if [[ -d "grakn" ]]; then
		cd ${PROJECT_ROOT_FOLDER}/shared/grakn
		git pull origin master
	else
	    git clone https://github.com/graknlabs/grakn
	    cd ${PROJECT_ROOT_FOLDER}/shared/grakn
	fi

	git fetch --all --tags

	echo "Switching to tag ${GRAKN_VERSION} to be able to apply the batch (to build uberjar via bazel)"
	git checkout ${GRAKN_VERSION} 
	git checkout -b v${GRAKN_VERSION}-branch

	git config --local user.name "Mani Sarkar"
	git config --local user.email "sadhak001@gmail.com"
	git am -3 < ${PROJECT_ROOT_FOLDER}/0001-Build-a-distribution-with-uber-jars.patch

	bazel build //:assemble-linux-deploy-targz
}

extractMetaInfo() {
	mkdir -p "META-INF/native-image"
	CURRENT_DIR=$(pwd)
	nativeImageMetaInfFolder="${CURRENT_DIR}/META-INF/native-image"
	echo ""
	echo "~~~~ Running ${JARFILE} using the tracing agent to gather the necessary configuration info for building native-image"
	java -agentlib:native-image-agent=config-merge-dir=${nativeImageMetaInfFolder} \
	     -jar ${JARFILE} || true
	echo "~~~~ Finished running tracing agent on the ${JARFILE}"
	echo "Now native-image can be run on ${JARFILE} to generate ${IMAGE_NAME} (using the --buildNativeImage parameter)."
}

buildNativeImage() {
	echo ""
	echo "~~~~ ${IMAGE_NAME}: Building native-image from ${JARFILE} which may take a bit of time"
	rm -f ${IMAGE_NAME} && echo "Deleting existing ${IMAGE_NAME}"
	native-image ${OPTIONS} -jar ${JARFILE} ${IMAGE_NAME} &> build.logs
	echo "~~~~ Finished building native-image '${IMAGE_NAME}' from ${JARFILE}."
}

testNativeImage() {
	echo ""
	echo "~~~~ Testing built binary ${IMAGE_NAME}"
	${IMAGE_NAME} 
	echo "~~~~ Finished testing built binary ${IMAGE_NAME}"
}

while [[ "$#" -gt 0 ]]; do case $1 in
  --help)              showUsageText; exit 0;;
  --buildUberJar)      buildUberJar; exit 0;; 
  --extract)           JARFILE="${2:-}"; setupVariables; extractMetaInfo; exit 0;;
  --buildNativeImage)  JARFILE="${2:-}"; setupVariables; buildNativeImage;  exit 0;;
  --test)              IMAGE_NAME="${2:-}"; testNativeImage;  exit 0;;
  *) echo "Unknown parameter passed: $1"; exit 1;;
esac; shift; done

checkForJarFileParam