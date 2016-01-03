#!/bin/bash

DOCKER_IMAGE_VERSION=jre-1.8.0
DOCKER_IMAGE_NAME=pfrandsen/openjdk-jre8
DOCKER_IMAGE_TAGNAME=${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}

for i in "$@"
do
case $i in
    -u=*|--update=*)
        # append JRE update version to docker image tagname
        DOCKER_IMAGE_VERSION="jre-1.8.0u${i#*=}"
        DOCKER_IMAGE_TAGNAME=${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}
        echo "setting image tagname to: ${DOCKER_IMAGE_TAGNAME}"
        ;;
    test)
        docker run --rm $DOCKER_IMAGE_TAGNAME /bin/echo "hello from Bash"
        docker run --rm $DOCKER_IMAGE_TAGNAME java -version
        ;;
    version)
        docker run --rm $DOCKER_IMAGE_TAGNAME java -version
        ;;
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

