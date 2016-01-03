#!/bin/bash

DOCKER_IMAGE_VERSION=10.0.0.CR5
DOCKER_IMAGE_NAME=pfrandsen/wildfly-10
DOCKER_IMAGE_TAGNAME=${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}

for i in "$@"
do
case $i in
    push)
        docker push $DOCKER_IMAGE_NAME
        ;;
    cleanup)
        docker ps -a | grep Exited | cut -c -12 | xargs --no-run-if-empty docker rm
        ;;
    remove)
        echo "removing image $DOCKER_IMAGE_NAME"
        read -p "are you sure you want to remove it? [YES] " response
        if [[ $response == "YES" ]]; then
            docker rmi -f $DOCKER_IMAGE_NAME
        fi
        ;;
    build)
        docker build -t $DOCKER_IMAGE_TAGNAME .
        docker tag -f $DOCKER_IMAGE_TAGNAME ${DOCKER_IMAGE_NAME}
        ;;
    *)
        echo "ignoring option: $i"
esac
done

