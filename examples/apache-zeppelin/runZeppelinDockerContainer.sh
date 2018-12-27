#!/bin/bash

set -e
set -u
set -o pipefail

docker run --rm \
           -it \
           -p 8080:8080 zeppelin 