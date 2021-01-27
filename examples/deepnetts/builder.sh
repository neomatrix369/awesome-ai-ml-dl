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

      Usage: $0  [--build-tool      [built tool name]]
                           --jarfile         [/path/to/JAR file]
                           --uber-jar

                           or

              $0  --extract

                           or

              $0  [--build-tool      [built tool name]]
                           [--compress-image  [level]]
                           [--pgo]
                           --native-image

      Other options:

       --build-tool        [built tool name]             
	   
         build the uber-jar or native-image corresponding to the build-tool of choice.
         options: mvn or gradle, default: mvn

       --jarfile           [/path/to/JAR file]

         path to jar file inside DeepNetts Home or elsewhere

       --uber-jar                                        

         (command) build the Uber jar before building the native image

       --extract                                         

         (command) extract the Jar file configuration 
         information and save into the META-INF folder

       --pgo

         use profile guided optimisation when building a native-image
         the generated native-image filename contains a '-pgo' as suffix
         (works with GraalVM EE jdk only, see https://www.oracle.com/java/graalvm/ for further details)

       --native-image
	   
         (command) build the native image from the Jar file provided

       --compress-image    [level]
	   
         compress the final executable image built, after running native-image with a level of necessary compression 
         (using faster to better compress levels). 
         This feature is supported by UPX, see https://upx.github.io on further details on how to install it.
         options: 1 to 9 (1: faster compression ... 9: compress better)

       --help
	   
         shows the script usage help text

HEREDOC
}

JARFILE=""
BUILD_TOOL="mvn"
JARFILE_LOCATION="target"
IMAGE_NAME=""
USE_PGO="false"
SHOW_STACK_TRACES=${SHOW_STACK_TRACES:-}
OPTIONS=""

checkForJarFileParam() {
	if [[ -z "${JARFILE:-}" ]]; then
		JARFILE=$(ls ${JARFILE_LOCATION}/*dependencies*.jar || true)
		echo "WARNING: Jar file (with full path) not provided as argument to script, assuming jar file: \n   ${JARFILE}."
	fi
}

setupVariables() {
	checkForJarFileParam

	IMAGE_NAME=$(basename ${JARFILE%.*})
	OPTIONS="${2:-} --no-fallback --report-unsupported-elements-at-runtime --allow-incomplete-classpath"
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
	echo "Now native-image can be run on ${JARFILE} to generate ${IMAGE_NAME} (using the --native-image parameter):"
	echo ""
	echo "    $0 --native-image"
	echo ""
	echo "See README.md for more such examples."
	echo ""
}

checkMetaInfIsPresent() {
	if [[ !	 -e "META-INF" ]]; then
	   echo "The 'META-INF' folder is missing, it's possible that the GraalVM tracing agent has not been run to extract meta information about the Jar file".
	   echo "Please run the below before trying to generate the native-image:"
	   echo ""
	   echo "     $0 --extract"
       echo "" 
	   echo "Please check out the usage text for further details, if needed."
	   exit -1
	fi
}

buildNativeImage() {
	echo ""

	checkMetaInfIsPresent

	echo "~~~~ ${IMAGE_NAME}: Building native-image from ${JARFILE} which may take a bit of time"
	rm -f ./${IMAGE_NAME} && echo "Deleting existing ${IMAGE_NAME}"
	NATIVE_IMAGE_BUILD_LOG="$(pwd)/outputs/native-image-build-output.log"
	echo ""; echo "You can follow the build process by doing this in the project root folder:"
	echo ""
	echo "       $ tail -f ${NATIVE_IMAGE_BUILD_LOG}"
	echo ""
	echo "native-image version $(native-image --version)"
	echo ""
	if [[ "$(isGraalVMEE)" == "true" ]]; then
       echo "Current SDK on the JDK_HOME/PATH path is a GraalVM EE JDK"
	else
       if [[ "${USE_PGO}" == "true" ]]; then
	      echo "Current SDK on the JDK_HOME/PATH path is NOT a GraalVM EE JDK"
          echo "--pgo is not available for this version of the JDK. Falling back to default behaviour."
       fi
       USE_PGO="false"
	fi
	echo ""

	# See usage docs: https://github.com/oracle/graal/blob/master/substratevm/PGOEnterprise.md
	if [[ "${USE_PGO}" == "true" ]]; then
        applyPGO
	else
		echo "Building native-image from the Jar file provided"
		set -x
		time native-image ${OPTIONS} -jar ${JARFILE} \
		     ./${IMAGE_NAME} &> "${NATIVE_IMAGE_BUILD_LOG}"
		set +x
	    echo "~~~~ You could improve performance of the native-image with the --pgo option, check out the usage text via the --help option."
	fi
	echo "~~~~ Finished building native-image '${IMAGE_NAME}' from ${JARFILE}"

	compressImage

	echo ""
	echo "Run the native-image by calling it:"
	echo "    ./${IMAGE_NAME}"
}

applyPGO() {
	echo "Instrumenting the native-image and recording profile information"
	echo ""
	set -x
	time native-image --pgo-instrument ${OPTIONS} \
			-jar ${JARFILE} ./${IMAGE_NAME}-instrumented &> "${NATIVE_IMAGE_BUILD_LOG}"
	set +x
	
	echo "Running the instrumented native-image to generate."
	set -x
	./${IMAGE_NAME}-instrumented --classification
	mv default.iprof classification.iprof
	./${IMAGE_NAME}-instrumented --regression
	mv default.iprof regression.iprof
	set +x		

	echo "Building the final native-image using the generated instrumented profile."
	echo ""
	IMAGE_NAME="${IMAGE_NAME}-pgo"
	set -x
	time native-image --pgo=classification.iprof,regression.iprof \
			${OPTIONS} -jar ${JARFILE} ./${IMAGE_NAME} &> "${NATIVE_IMAGE_BUILD_LOG}"
	set +x
}

compressImage() {
	if [[ ! -z "${COMPRESSION_LEVEL}" ]]; then
	   UPX_EXISTS=$(upx --help || true)
	   UPX_OUTPUT_FILE="${IMAGE_NAME}_compressed"
	   if [[ -z "${UPX_EXISTS}" ]]; then
           echo "~~~~ UPX was NOT found on the path, please install it in this environment and try again."
		   echo "See https://upx.github.io for further details."
	   else
	       echo "~~~~ Attempting to compress native-image '${IMAGE_NAME}' further (using compression level: ${COMPRESSION_LEVEL})"
	       upx -"${COMPRESSION_LEVEL}" -o "${UPX_OUTPUT_FILE}" "${IMAGE_NAME}"
		   echo "~~~~ Finished compressing native-image '${IMAGE_NAME}' into '${UPX_OUTPUT_FILE}'"
	   fi
	else
	   echo "~~~~ You could compress the native-image with the --compress-image option, check out the usage text via the --help option."
	fi
}

while [[ "$#" -gt 0 ]]; do case $1 in
  --help)              showUsageText; exit 0;;
  --build-tool)        BUILD_TOOL=${2:-"mvn"}; shift;;
  --jarfile)           JARFILE="${2:-}"; shift;;
  --uber-jar)          buildUberJar; exit 0;;
  --extract)           extractMetaInfo; exit 0;;
  --pgo)               USE_PGO="true"; ;;
  --compress-image)    COMPRESSION_LEVEL="${2}"; shift;;
  --native-image)      setupVariables; buildNativeImage; exit 0;;
  *) echo "Unknown parameter passed: $1"; exit 1;;
esac; shift; done

checkForJarFileParam

if [[ "$#" -eq 0 ]]; then
    echo ""
	echo "No params passed or one or more options used is missing an necessary flag."
	echo "Please check usage text using the --help option and try again."
	echo ""
fi