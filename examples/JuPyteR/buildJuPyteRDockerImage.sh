#!/bin/bash

set -e
set -u
set -o pipefail

docker build -t jupyter-java -f JuPyteR-Dockerfile .