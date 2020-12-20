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

checkForJava() {
	echo ""
	echo "~~~~ Checking for Java"
	JAVA_FOUND=$(which java || true)

	if [[ -z "${JAVA_FOUND}" ]]; then
		echo "No JDK installed or available in this environment."
		exit -1
	fi
	echo "~~~~ Java found"
}

checkForGraalVM() {
	echo ""
	echo "~~~~ Checking for GraalVM JDK"
	OUTPUT="java_version.txt"
	java -version &> ${OUTPUT} || true
	GRAALVM_FOUND=$(grep -i "jvmci" ${OUTPUT} || true)

	if [[ -z "${GRAALVM_FOUND}" ]]; then
		echo "The JDK currently installed (or currently pointing to) is not a GraalVM JDK."
		echo "Please make sure you have GraalVM installed and the JAVA_HOME and PATH are set to point to that and JAVA_HOME/bin folders respectively."
		echo "You can download the latest version of GraalVM binary from https://github.com/oracle/graal/releases."
		exit -1
	fi
	echo "Deleting existing ${OUTPUT}" && rm -f ${OUTPUT}
	echo "~~~~ GraalVM JDK found"
}

checkForGu() {
	echo ""
	echo "~~~~ Checking for 'gu' updater tool"
	GU_FOUND=$(which gu || true)
	if [[ -z "${GU_FOUND}" ]]; then
		echo "gu is not found, please check if this present in the ${JAVA_HOME}/bin folder of the installed GraalVM JDK."
		exit -1
	fi
	echo "~~~~ 'gu' updater tool found"
}

checkForNativeImage() {
	echo ""
	echo "~~~~ Checking for 'native-image' tool"
	NATIVE_IMAGE_FOUND=$(which native-image || true)
	if [[ -z "${NATIVE_IMAGE_FOUND}" ]]; then
		echo "native-image is not found, will try to download and install it using the 'gu' tool."
		gu native-image -v
		echo "native-image has been installed".
	else
		echo "~~~~ 'native-image' tool found"
	fi
}

isVersionGreaterThanOrEqualTo() {
  result="true"        ### assuming first version is greater than second
  if [[ "$1" = "$2" ]]; then
  	result="true"      ### if they are equal
  else
  	lesser_version="$(echo "$@" | tr " " "\n" | sort -V | head -n 1)"
  	if [[ "${lesser_version}" = "$1" ]]; then 
  		result="false" ### the first version is smaller than the second
    fi
  fi
  echo "${result}"
}

isGraalVMEE() {
	result="false"
	OUTPUT="java_version.txt"
	java -version &> ${OUTPUT} || true
	GRAALVM_EE_FOUND=$(grep -i "GraalVM EE" ${OUTPUT})
	rm -f "${OUTPUT}"

	if [[ ! -z "${GRAALVM_EE_FOUND}" ]]; then
		result="true"
	fi
	echo "${result}"
}