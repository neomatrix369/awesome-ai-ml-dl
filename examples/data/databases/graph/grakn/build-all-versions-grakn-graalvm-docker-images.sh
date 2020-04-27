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

runBuildsParallel() {
	jobsToRun="$(nproc --all)"
    availableThreads="${jobsToRun}"
    cappedThreads="$(( ${availableThreads} - (${availableThreads} * 1 / 2) ))"
    if [[ -z "${jobsToRun}" ]] || [[  "${jobsToRun}" -ge "${cappedThreads}" ]]; then
        jobsToRun="${cappedThreads}"
    fi
    echo "*** Running process in parallel mode..."
    echo "*** Jobs to run (CPUs, not cores): ${jobsToRun}"
    mkdir -p tmp
    set -x
    cat "grakn-graalvm-version-matrix.txt" \
        | parallel \
            --keep-order \
            --compress \
            --jobs ${jobsToRun} \
            --timeout 900 \
            --bar \
            --use-cpus-instead-of-cores \
            --tmpdir tmp \
            -- {} {} ./grakn-runner.sh --buildDockerImage
    set +x 
}

runBuildsSerial() {
	GRAALVM_VERSIONS="19.0.0 19.1.0 19.2.0 19.3.0"
	GRAALVM_JDK_VERSIONS="java8" # java11 is not supported by Grakn
	GRAKN_VERSIONS="1.4.3 1.5.2 1.5.7 1.6.0 1.6.2"

	for GRAKN_VERSION in ${GRAKN_VERSIONS[@]}
	do
		for GRAALVM_VERSION in ${GRAALVM_VERSIONS[@]}
		do
			if [[ "$(isVersionGreaterThanOrEqualTo "${GRAALVM_VERSION}" "19.3.0")" = "true" ]]; then
				for GRAALVM_JDK_VERSION in ${GRAALVM_JDK_VERSIONS[@]}
				do
					set -x
					GRAALVM_VERSION=${GRAALVM_VERSION}         \
					GRAALVM_JDK_VERSION=${GRAALVM_JDK_VERSION} \
					GRAKN_VERSION=${GRAKN_VERSION}             \
					     ./grakn-runner.sh --buildDockerImage
					set +x
				done
			else
				set -x
				GRAALVM_VERSION=${GRAALVM_VERSION} \
				GRAKN_VERSION=${GRAKN_VERSION}     \
				     ./grakn-runner.sh --buildDockerImage
				set +x
	        fi
		done
	done
	# GRAALVM_VERSION="19.0.0" GRAKN_VERSION=1.4.3 ./grakn-runner.sh --buildDockerImage
	# GRAALVM_VERSION="19.1.0" GRAKN_VERSION=1.4.3 ./grakn-runner.sh --buildDockerImage
	# GRAALVM_VERSION="19.2.0" GRAKN_VERSION=1.4.3 ./grakn-runner.sh --buildDockerImage
	# GRAALVM_VERSION="19.3.0" GRAALVM_JDK_VERSION=java8 GRAKN_VERSION=1.4.3 ./grakn-runner.sh --buildDockerImage

	# GRAALVM_VERSION="19.0.0" GRAKN_VERSION=1.5.2 ./grakn-runner.sh --buildDockerImage
	# GRAALVM_VERSION="19.1.0" GRAKN_VERSION=1.5.2 ./grakn-runner.sh --buildDockerImage
	# GRAALVM_VERSION="19.2.0" GRAKN_VERSION=1.5.2 ./grakn-runner.sh --buildDockerImage
	# GRAALVM_VERSION="19.3.0" GRAALVM_JDK_VERSION=java8 GRAKN_VERSION=1.5.2 ./grakn-runner.sh --buildDockerImage

	# GRAALVM_VERSION="19.0.0" GRAKN_VERSION=1.5.7 ./grakn-runner.sh --buildDockerImage
	# GRAALVM_VERSION="19.1.0" GRAKN_VERSION=1.5.7 ./grakn-runner.sh --buildDockerImage
	# GRAALVM_VERSION="19.2.0" GRAKN_VERSION=1.5.7 ./grakn-runner.sh --buildDockerImage
	# GRAALVM_VERSION="19.3.0" GRAALVM_JDK_VERSION=java8 GRAKN_VERSION=1.5.7 ./grakn-runner.sh --buildDockerImage

	# GRAALVM_VERSION="19.0.0" GRAKN_VERSION=1.6.0 ./grakn-runner.sh --buildDockerImage
	# GRAALVM_VERSION="19.1.0" GRAKN_VERSION=1.6.0 ./grakn-runner.sh --buildDockerImage
	# GRAALVM_VERSION="19.2.0" GRAKN_VERSION=1.6.0 ./grakn-runner.sh --buildDockerImage
	# GRAALVM_VERSION="19.3.0" GRAALVM_JDK_VERSION=java8  GRAKN_VERSION=1.6.0 ./grakn-runner.sh --buildDockerImage

	# GRAALVM_VERSION="19.0.0" GRAKN_VERSION=1.6.2 ./grakn-runner.sh --buildDockerImage
	# GRAALVM_VERSION="19.1.0" GRAKN_VERSION=1.6.2 ./grakn-runner.sh --buildDockerImage
	# GRAALVM_VERSION="19.2.0" GRAKN_VERSION=1.6.2 ./grakn-runner.sh --buildDockerImage
	# GRAALVM_VERSION="19.3.0" GRAALVM_JDK_VERSION=java8  GRAKN_VERSION=1.6.2 ./grakn-runner.sh --buildDockerImage
}


FOUND_PARALLEL="$(which parallel | grep -v "not found" || true)"
if [ -z "${FOUND_PARALLEL}" ]; then
  echo "*** Parallel not installed on this box, run the below: \n sudo apt-get install parallel or see https://www.gnu.org/software/parallel/."
  runBuildsSerial
else
  echo "*** GNU Parallel found, proceeding with script..."
  runBuildsParallel
fi