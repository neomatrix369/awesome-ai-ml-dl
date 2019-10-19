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

IMAGE_NAME=${IMAGE_NAME:-zeppelin}
IMAGE_VERSION=${IMAGE_VERSION:-$(cat version.txt)}
DOCKER_USER_NAME=${DOCKER_USER_NAME:-"neomatrix369"}
DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

mkdir -p logs notebook
chown ${USER}:${GROUP} logs 
chown ${USER}:${GROUP} notebook

echo "Please wait till the log messages stop moving, it will be a sign that the service is ready! (about a minute or so)"
echo "Once the service is ready, go to http://localhost:8080 to open the Apache Zeppelin homepage"
time docker run --rm                               \
           -it                                     \
           -p 8080:8080	                           \
           -v ${PWD}/logs:/logs                    \
           -v ${PWD}/notebook:/notebook            \
           -e ZEPPELIN_NOTEBOOK_DIR='/notebook'    \
           -e ZEPPELIN_LOG_DIR='/logs'             \
           ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}

