#!/usr/bin/env bash

set -e

SHA=($(shasum Dockerfile))

if (docker inspect hello-world 2>/dev/null 1>/dev/null);
then
    docker container rm -f -v hello-world 1>/dev/null
    echo "hello-world stopped"
fi

if [ "$1" == "stop" ];
then
    exit
fi

# Rebuild only if Dockerfile changed or the related image is missing
if ! (docker inspect systemd-in-d:$SHA 2>/dev/null 1>/dev/null);
then
    DOCKER_BUILDKIT=1 docker build -t systemd-in-d:$SHA .
fi

docker run -it -d \
    --privileged \
    --cgroupns=host \
    -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
    --name hello-world \
    --hostname systemd-in-d \
    -p 80:80 \
    systemd-in-d:$SHA 1>/dev/null

echo "hello-world started and is reachable using http://localhost/"
