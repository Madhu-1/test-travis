#!/bin/bash

export VERSION="latest"
export DOCKER_REPO=madhupr001/multiarch
export DOCKER_CLI_EXPERIMENTAL=enabled
echo "${DOCKER_USERNAME}"
echo ${DOCKER_USERNAME}
docker login -u "${DOCKER_USERNAME}" -p "${DOCKER_PASSWORD}"
docker manifest inspect ${DOCKER_REPO}:${VERSION} >/dev/null && echo "Version ${VERSION} is already exists" && exit 0
for ARCH_TYPE in amd64 arm64 arm; do
    if [ "$ARCH_TYPE" == "amd64" ]; then
        export ARCH=amd64
    elif [ "$ARCH_TYPE" == "arm" ]; then
        export ARCH=arm
    elif [ "$ARCH_TYPE" == "arm64" ]; then
        export ARCH=arm64
    else
        echo "unsupported architecture type"
        return 1
    fi

    # Push image
    docker push ${DOCKER_REPO}:${VERSION}-${ARCH}

done

docker manifest create --amend \
    ${DOCKER_REPO}:${VERSION} \
    ${DOCKER_REPO}:${VERSION}-amd64 \
    ${DOCKER_REPO}:${VERSION}-arm64 \
    ${DOCKER_REPO}:${VERSION}-arm

for OS_ARCH in linux_amd64 linux_arm64; do
    ARCH=${OS_ARCH#*_}
    OS=${OS_ARCH%%_*}

    docker manifest annotate \
        ${DOCKER_REPO}:${VERSION} \
        ${DOCKER_REPO}:${VERSION}-${ARCH} \
        --os ${OS} --arch ${ARCH}

done

docker manifest annotate \
    ${DOCKER_REPO}:${VERSION} \
    ${DOCKER_REPO}:${VERSION}-arm \
    --os linux --arch arm --variant v7

docker manifest push ${DOCKER_REPO}:${VERSION}
