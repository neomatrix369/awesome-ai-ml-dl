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

GRAALVM_VERSION=19.0.0 GRAKN_VERSION=1.4.3 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.1.0 GRAKN_VERSION=1.4.3 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.2.0 GRAKN_VERSION=1.4.3 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.3.0 GRAALVM_JDK_VERSION=jdk8 GRAKN_VERSION=1.4.3 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.3.0 GRAALVM_JDK_VERSION=jdk11 GRAKN_VERSION=1.4.3 ./grakn-runner.sh --buildDockerImage

GRAALVM_VERSION=19.0.0 GRAKN_VERSION=1.5.2 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.1.0 GRAKN_VERSION=1.5.2 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.2.0 GRAKN_VERSION=1.5.2 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.3.0 GRAALVM_JDK_VERSION=jdk8 GRAKN_VERSION=1.5.2 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.3.0 GRAALVM_JDK_VERSION=jdk11 GRAKN_VERSION=1.5.2 ./grakn-runner.sh --buildDockerImage

GRAALVM_VERSION=19.0.0 GRAKN_VERSION=1.5.7 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.1.0 GRAKN_VERSION=1.5.7 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.2.0 GRAKN_VERSION=1.5.7 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.3.0 GRAALVM_JDK_VERSION=jdk8 GRAKN_VERSION=1.5.7 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.3.0 GRAALVM_JDK_VERSION=jdk11 GRAKN_VERSION=1.5.7 ./grakn-runner.sh --buildDockerImage

GRAALVM_VERSION=19.0.0 GRAKN_VERSION=1.6.0 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.1.0 GRAKN_VERSION=1.6.0 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.2.0 GRAKN_VERSION=1.6.0 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.3.0 GRAALVM_JDK_VERSION=jdk8  GRAKN_VERSION=1.6.0 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.3.0 GRAALVM_JDK_VERSION=jdk11 GRAKN_VERSION=1.6.0 ./grakn-runner.sh --buildDockerImage

GRAALVM_VERSION=19.0.0 GRAKN_VERSION=1.6.2 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.1.0 GRAKN_VERSION=1.6.2 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.2.0 GRAKN_VERSION=1.6.2 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.3.0 GRAALVM_JDK_VERSION=jdk8  GRAKN_VERSION=1.6.2 ./grakn-runner.sh --buildDockerImage
GRAALVM_VERSION=19.3.0 GRAALVM_JDK_VERSION=jdk11 GRAKN_VERSION=1.6.2 ./grakn-runner.sh --buildDockerImage