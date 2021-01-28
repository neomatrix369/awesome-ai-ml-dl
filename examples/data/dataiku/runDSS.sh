#!/bin/bash

#
# Copyright 2019, 2020 Mani Sarkar
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

if [[ "${JDK_TO_USE}" = "GRAALVM" ]]; then	
	GRAALVM_HOME="/usr/lib/jvm/graalvm-ce-${GRAALVM_VERSION}"
	JAVA_HOME=${GRAALVM_HOME}
	echo "JAVA_HOME=${JAVA_HOME}"
	PATH=${GRAALVM_HOME}/bin:${PATH}
	echo "PATH=${PATH}"

	java -version
fi

echo "Current working directory: $(pwd)"
echo "DSS_VERSION=${DSS_VERSION}"
./run.sh