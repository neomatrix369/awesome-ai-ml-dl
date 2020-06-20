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

       Usage: $0 --grakn-home   [/path/to/grak/home]
                 --jarfile      [/path/to/JAR file]
                 --buildUberJar                 
                 --extract   
                 --build     
                 --test         [/path/to/native-image file]
                 --help

       --grakn-home        [/path/to/grak/home]          where the grakn scripts, jar file and 
                                                         other executables can be found
       --jarfile           [/path/to/JAR file]           path to jar file inside Grakn Home or elsewhere
       --buildUberJar                                    (command) build the Uber jar before building 
                                                         the native image
       --extract                                         (command) extract the Jar file configuration 
                                                         information and save into the META-INF folder
       --buildNativeImage                                (command) build the native image from the Jar
                                                         file provided
       --test              [/path/to/native-image file]  test the native image
       --help                                            shows the script usage help text

HEREDOC
}

IMAGE_NAME=""
SHOW_STACK_TRACES=${SHOW_STACK_TRACES:-}
OPTIONS=""

GRAKN_VERSION=${GRAKN_VERSION:-$(cat grakn_version.txt)}

checkForJarFileParam() {
	if [[ -z "${PATH_TO_GRAKN_HOME:-}" ]]; then
		echo "Path to Grakn home not provided as argument to script, please see usage text below."		
		showUsageText
		exit -1
	fi

	if [[ -z "${JARFILE:-}" ]]; then
		JARFILE=(${PATH_TO_GRAKN_HOME}/server/services/lib/*server*.jar)
		echo "WARNING: Jar file (with full path) not provided as argument to script, assuming jar file ${JARFILE}."
	fi
}

setupVariables() {
	checkForJarFileParam

	IMAGE_NAME=$(basename ${JARFILE%.*})
	OPTIONS="${2:-} --no-fallback --no-fallback --report-unsupported-elements-at-runtime --allow-incomplete-classpath"
	OPTIONS="${OPTIONS} -H:ReflectionConfigurationFiles=${PATH_TO_GRAKN_HOME}/META-INF/native-image/reflect-config.json"
	OPTIONS="${OPTIONS} -H:DynamicProxyConfigurationFiles=${PATH_TO_GRAKN_HOME}/META-INF/native-image/proxy-config.json"
	OPTIONS="${OPTIONS} -H:ResourceConfigurationFiles=${PATH_TO_GRAKN_HOME}/META-INF/native-image/resource-config.json"
	OPTIONS="${OPTIONS} -H:JNIConfigurationFiles=${PATH_TO_GRAKN_HOME}/META-INF/native-image/jni-config.json"

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
	mkdir -p "${PATH_TO_GRAKN_HOME}/META-INF/native-image"
	nativeImageMetaInfFolder="${PATH_TO_GRAKN_HOME}/META-INF/native-image"
	
	JARFILE_FULL_PATH=""
	if [[ -z "${JARFILE:-}" ]]; then
		echo ""; echo "~~~~ Running server jar (from Grakn Home: ${PATH_TO_GRAKN_HOME}) using the tracing agent to gather the necessary configuration info for building native-image"
	else
		JARFILE_FULL_PATH=${PATH_TO_GRAKN_HOME}/server/services/lib/${JARFILE}
		echo ""; echo "~~~~ Running ${JARFILE} using the tracing agent to gather the necessary configuration info for building native-image"
	fi
	
	cp grakn-jar-runner.sh ${PATH_TO_GRAKN_HOME}
	(cd ${PATH_TO_GRAKN_HOME} && 
		nohup ./grakn-jar-runner.sh server start&)
	sleep 70
	(cd ${PATH_TO_GRAKN_HOME} && 
		./grakn-jar-runner.sh server stop || true)

	if [[ -z "${JARFILE:-}" ]]; then
		echo ""; echo "~~~~ Finished running tracing agent on the server jar"
		echo "Now native-image can be run on server jar to generate a native-image (using the --buildNativeImage parameter)."
	else
		echo ""; echo "~~~~ Finished running tracing agent on the ${JARFILE}"
		echo "Now native-image can be run on ${JARFILE} to generate ${IMAGE_NAME} (using the --buildNativeImage parameter)."
	fi
	echo ""
}

buildNativeImage() {
	echo ""
	echo "~~~~ ${IMAGE_NAME}: Building native-image from ${JARFILE} which may take a bit of time in ${PATH_TO_GRAKN_HOME}"
	rm -f ${PATH_TO_GRAKN_HOME}/${IMAGE_NAME} && echo "Deleting existing ${IMAGE_NAME}"
	NATIVE_IMAGE_BUILD_LOGS="${PATH_TO_GRAKN_HOME:-$(pwd)}/native-image-build-for-${IMAGE_NAME}.logs"
	echo ""; echo "You can follow the build process by doing this:"
	echo "       $ tail -f ${NATIVE_IMAGE_BUILD_LOGS}"
	echo "native-image version $(native-image --version)" 
	set -x
	time native-image ${OPTIONS} -jar ${JARFILE} ${PATH_TO_GRAKN_HOME}/${IMAGE_NAME} &> "${NATIVE_IMAGE_BUILD_LOGS}"
	set +x
	echo "~~~~ Finished building native-image '${IMAGE_NAME}' from ${JARFILE} in ${PATH_TO_GRAKN_HOME}."
}

testNativeImage() {
	echo ""
	echo "~~~~ Testing built binary ${IMAGE_NAME} in ${PATH_TO_GRAKN_HOME}"
	${PATH_TO_GRAKN_HOME}/${IMAGE_NAME} 
	echo "~~~~ Finished testing built binary ${IMAGE_NAME} in ${PATH_TO_GRAKN_HOME}"
}

while [[ "$#" -gt 0 ]]; do case $1 in
  --help)              showUsageText; exit 0;;
  --buildUberJar)      buildUberJar; exit 0;;
  --jarfile)           JARFILE="${2:-}"; shift;;
  --grakn-home)        PATH_TO_GRAKN_HOME="${2:-}"; shift;;
  --extract)           extractMetaInfo; exit 0;;
  --buildNativeImage)  setupVariables; buildNativeImage;  exit 0;;
  --test)              IMAGE_NAME="${2:-}"; testNativeImage;  exit 0;;
  *) echo "Unknown parameter passed: $1"; exit 1;;
esac; shift; done

checkForJarFileParam