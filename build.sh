#!/bin/bash

set -euo pipefail

export VERSION="latest"
export DOCKER_REPO=madhupr001/multiarch

for ARCH_TYPE in amd64 arm64 arm; do
    if [ "$ARCH_TYPE" == "amd64" ]; then
        export TARGET=amd64
        export ARCH=amd64
    elif [ "$ARCH_TYPE" == "arm" ]; then
        export TARGET=arm32v6
        export ARCH=arm
    elif [ "$ARCH_TYPE" == "arm64" ]; then
        export TARGET=arm64v8
        export ARCH=arm64
    else
        echo "unsupported architecture type"
        return 1
    fi

    # Build image
    docker build -t $DOCKER_REPO:${VERSION}-${ARCH} --build-arg target=${TARGET} --build-arg arch=${ARCH} .

done
