#!/bin/bash

#
# Copyright 2020 Mani Sarkar
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

       Usage: $0 --jarfile      [/path/to/JAR file]
                 --buildUberJar
                 --extract
                 --build
                 --help

       --build-tool        [built tool name]             name of build tool to use, 
                                                         options: mvn or gradle, default: mvn
       --jarfile           [/path/to/JAR file]           path to jar file inside Tribuo Home or elsewhere
       --buildUberJar                                    (command) build the Uber jar before building 
                                                         the native image
       --extract                                         (command) extract the Jar file configuration 
                                                         information and save into the META-INF folder
       --pgo                                             use profile guided optimisation when building a native-image
                                                         the generated native-image filename contains a '-pgo' as suffix
                                                         (works with GraalVM EE jdk only)
       --buildNativeImage                                (command) build the native image from the Jar
                                                         file provided

       --help                                            shows the script usage help text

HEREDOC
}

JARFILE=""
BUILD_TOOL="mvn"
JARFILE_LOCATION="target"
IMAGE_NAME=""
USE_PGO="false"
SHOW_STACK_TRACES=${SHOW_STACK_TRACES:-}
OPTIONS=""

TRIBUO_VERSION=${TRIBUO_VERSION:-$(cat ./docker-image/version.txt)}

checkForJarFileParam() {
	if [[ -z "${JARFILE:-}" ]]; then
		JARFILE=$(ls ${JARFILE_LOCATION}/*dependencies*.jar || true)
		echo "WARNING: Jar file (with full path) not provided as argument to script, assuming jar file: \n   ${JARFILE}."
	fi
}

setupVariables() {
	checkForJarFileParam

	IMAGE_NAME=$(basename ${JARFILE%.*})
	OPTIONS="${2:-} --no-fallback --no-fallback --report-unsupported-elements-at-runtime --allow-incomplete-classpath"
	OPTIONS="${OPTIONS} -H:ReflectionConfigurationFiles=./META-INF/native-image/reflect-config.json"
	OPTIONS="${OPTIONS} -H:DynamicProxyConfigurationFiles=./META-INF/native-image/proxy-config.json"
	OPTIONS="${OPTIONS} -H:ResourceConfigurationFiles=./META-INF/native-image/resource-config.json"
	OPTIONS="${OPTIONS} -H:JNIConfigurationFiles=./META-INF/native-image/jni-config.json"

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
	JARFILE_LOCATION="target"
	if [[ "${BUILD_TOOL}" == "gradle" ]]; then
		./gradlew clean build --info
		echo "Built JARs"
		JARFILE_LOCATION="build/libs"
		ls -lash ${JARFILE_LOCATION}
	else
		mvn clean package
		echo "Built JARs"
		ls -lash ${JARFILE_LOCATION}/*.jar
	fi
}

extractMetaInfo() {
	mkdir -p "./META-INF/native-image"
	nativeImageMetaInfFolder="./META-INF/native-image"
	checkForJarFileParam
	
	echo ""; echo "~~~~ Running ${JARFILE} using the tracing agent to gather the necessary configuration info for building native-image"
	
	set -x
	java -agentlib:native-image-agent=config-merge-dir=./META-INF/native-image -jar ${JARFILE} -cp ${JARFILE_LOCATION} --classification
	java -agentlib:native-image-agent=config-merge-dir=./META-INF/native-image -jar ${JARFILE} -cp ${JARFILE_LOCATION} --regression
    set +x

	echo ""; echo "~~~~ Finished running tracing agent on the ${JARFILE}"
	echo "Now native-image can be run on ${JARFILE} to generate ${IMAGE_NAME} (using the --buildNativeImage parameter)."
	echo ""
}

buildNativeImage() {
	echo ""
	echo "~~~~ ${IMAGE_NAME}: Building native-image from ${JARFILE} which may take a bit of time"
	rm -f ./${IMAGE_NAME} && echo "Deleting existing ${IMAGE_NAME}"
	NATIVE_IMAGE_BUILD_LOG="$(pwd)/outputs/native-image-build-output.log"
	echo ""; echo "You can follow the build process by doing this:"
	echo ""
	echo "       $ tail -f ${NATIVE_IMAGE_BUILD_LOG}"
	echo ""
	echo "native-image version $(native-image --version)"
	echo ""
	if [[ "$(isGraalVMEE)" == "true" ]]; then
       echo "Current SDK on the JDK_HOME/PATH path is a GraalVM EE JDK"
	else
       echo "Current SDK on the JDK_HOME/PATH path is NOT a GraalVM EE JDK"
       if [[ "${USE_PGO}" == "true" ]]; then
          echo "--pgo is not available for this version of the JDK. Falling back to default behaviour."
       fi
       USE_PGO="false"
	fi
	echo ""

	# See usage docs: https://github.com/oracle/graal/blob/master/substratevm/PGOEnterprise.md
	if [[ "${USE_PGO}" == "true" ]]; then
		echo "Instrumenting the native-image and recording profile information"
		echo ""
		set -x
		time native-image --pgo-instrument ${OPTIONS} \
		     -jar ${JARFILE} ./${IMAGE_NAME}-instrumented &> "${NATIVE_IMAGE_BUILD_LOG}"
		set +x
		
		echo "Running the instrumented native-image to generate "
		./${IMAGE_NAME}-instrumented --classification
		mv default.iprof classification.iprof 
		./${IMAGE_NAME}-instrumented --regression
		mv default.iprof regression.iprof 
		echo "Building the final native-image using the generated instrumented profile"
		echo ""
		IMAGE_NAME="${IMAGE_NAME}-pgo"
		set -x
		time native-image --pgo=classification.iprof,regression.iprof \
		     ${OPTIONS} -jar ${JARFILE} ./${IMAGE_NAME} &> "${NATIVE_IMAGE_BUILD_LOG}"
		set +x
	else
		echo "Building native-image from the Jar file provided"
		set -x
		time native-image ${OPTIONS} -jar ${JARFILE} \
		     ./${IMAGE_NAME} &> "${NATIVE_IMAGE_BUILD_LOG}"
		set +x
	fi
	echo "~~~~ Finished building native-image '${IMAGE_NAME}' from ${JARFILE}"
	echo ""
	echo "Run the native-image by calling it:"
	echo "    ./${IMAGE_NAME}"
}

while [[ "$#" -gt 0 ]]; do case $1 in
  --help)              showUsageText; exit 0;;
  --build-tool)        BUILD_TOOL=${2:-"mvn"}; shift;;
  --jarfile)           JARFILE="${2:-}"; shift;;
  --buildUberJar)      buildUberJar; exit 0;;
  --extract)           extractMetaInfo; exit 0;;
  --pgo)               USE_PGO="true"; ;;
  --buildNativeImage)  setupVariables; buildNativeImage; exit 0;;
  *) echo "Unknown parameter passed: $1"; exit 1;;
esac; shift; done

checkForJarFileParam

if [[ "$#" -eq 0 ]]; then
	echo "No params passed."
	showUsageText
fi