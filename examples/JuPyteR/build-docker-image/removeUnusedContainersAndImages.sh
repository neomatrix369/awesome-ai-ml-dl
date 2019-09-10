#!/usr/bin/env bash

set -e
set -u
set -o pipefail

containersToRemove=$(docker ps --quiet --filter "status=exited")
[ ! -z "${containersToRemove}" ] && \
    echo "Remove any stopped container from the local registry" && \
    docker rm ${containersToRemove} || true

imagesToRemove=$(docker images --quiet --filter "dangling=true")
[ ! -z "${imagesToRemove}" ] && \
    echo "Remove any dangling images from the local registry" && \
    docker rmi -f ${imagesToRemove} || true
