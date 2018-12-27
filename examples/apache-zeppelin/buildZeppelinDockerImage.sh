#!/bin/bash

set -e
set -u
set -o pipefail

docker build -t zeppelin -f Zeppelin-Dockerfile .