#!/bin/bash

set -e
set -u
set -o pipefail

DOCKER_USER_NAME=${DOCKER_USER_NAME:-"neomatrix369"}

IMAGE_NAME=${IMAGE_NAME:-better-nlp}
IMAGE_VERSION=${IMAGE_VERSION:-$(cat version.txt)}
BETTER_NLP_DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

WORKDIR=better-nlp

if [[ "${DEBUG:-}" = "true" ]]; then
	docker run --rm                         \
	            --interactive --tty         \
		        --volume $(pwd):/better-nlp \
	        	-p 8888:8888                \
	        	--workdir /${WORKDIR}       \
	        	--entrypoint /bin/bash      \
	        	${BETTER_NLP_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}	
else
	time docker run --rm                        \
		            --interactive --tty         \
	   	         	--volume $(pwd):/better-nlp \
	            	-p 8888:8888                \
	            	--workdir /${WORKDIR}       \
	            	${BETTER_NLP_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}
fi