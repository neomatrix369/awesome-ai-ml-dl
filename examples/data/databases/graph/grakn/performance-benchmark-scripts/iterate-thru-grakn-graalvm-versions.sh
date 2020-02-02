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

### Old combinations tested on ########
#######################################
# Grakn version, GraalVM Version
#         1.4.3, graalvm-ce-1.0.0-rc14
#         1.4.3, graalvm-ce-1.0.0-rc14
#         1.5.2, 1.0.0-rc15, 
#         1.5.2, 19.1.0
#         1.5.7, 19.1.0
#         1.5.7, 19.1.1
#         1.5.7, 19.3.1
#######################################

### GraalVM versions since 1.0.x-rc15
#   19.0.0    <=== first production ready release!
#   19.0.2
#   19.1.0    <=== Major release
#   19.1.1
#   19.2.0    <=== Major release
#   19.2.0.1
#   19.2.1
#   19.3.0    <=== Java 11 support (GraalVM suite)
#   19.3.0.2
#   19.3.1

GRAALVM_VERSION=19.0.0 GRAKN_VERSION=1.4.3 ./measureTradVersusGraalVMStartupTime.sh
GRAALVM_VERSION=19.1.0 GRAKN_VERSION=1.4.3 ./measureTradVersusGraalVMStartupTime.sh
GRAALVM_VERSION=19.2.0 GRAKN_VERSION=1.4.3 ./measureTradVersusGraalVMStartupTime.sh
GRAALVM_VERSION=19.3.0 GRAKN_VERSION=1.4.3 ./measureTradVersusGraalVMStartupTime.sh

GRAALVM_VERSION=19.0.0 GRAKN_VERSION=1.5.2 ./measureTradVersusGraalVMStartupTime.sh
GRAALVM_VERSION=19.1.0 GRAKN_VERSION=1.5.2 ./measureTradVersusGraalVMStartupTime.sh
GRAALVM_VERSION=19.2.0 GRAKN_VERSION=1.5.2 ./measureTradVersusGraalVMStartupTime.sh
GRAALVM_VERSION=19.3.0 GRAKN_VERSION=1.5.2 ./measureTradVersusGraalVMStartupTime.sh

GRAALVM_VERSION=19.0.0 GRAKN_VERSION=1.5.7 ./measureTradVersusGraalVMStartupTime.sh
GRAALVM_VERSION=19.1.0 GRAKN_VERSION=1.5.7 ./measureTradVersusGraalVMStartupTime.sh
GRAALVM_VERSION=19.2.0 GRAKN_VERSION=1.5.7 ./measureTradVersusGraalVMStartupTime.sh
GRAALVM_VERSION=19.3.0 GRAKN_VERSION=1.5.7 ./measureTradVersusGraalVMStartupTime.sh

GRAALVM_VERSION=19.0.0 GRAKN_VERSION=1.6.0 ./measureTradVersusGraalVMStartupTime.sh
GRAALVM_VERSION=19.1.0 GRAKN_VERSION=1.6.0 ./measureTradVersusGraalVMStartupTime.sh
GRAALVM_VERSION=19.2.0 GRAKN_VERSION=1.6.0 ./measureTradVersusGraalVMStartupTime.sh
GRAALVM_VERSION=19.3.0 GRAKN_VERSION=1.6.0 ./measureTradVersusGraalVMStartupTime.sh

GRAALVM_VERSION=19.0.0 GRAKN_VERSION=1.6.2 ./measureTradVersusGraalVMStartupTime.sh
GRAALVM_VERSION=19.1.0 GRAKN_VERSION=1.6.2 ./measureTradVersusGraalVMStartupTime.sh
GRAALVM_VERSION=19.2.0 GRAKN_VERSION=1.6.2 ./measureTradVersusGraalVMStartupTime.sh
GRAALVM_VERSION=19.3.0 GRAKN_VERSION=1.6.2 ./measureTradVersusGraalVMStartupTime.sh