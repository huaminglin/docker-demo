#!/usr/bin/env bash

if [ -f "$HOME/work/mydocker/bin/activate" ]; then
    source $HOME/work/mydocker/bin/activate
fi

docker-compose -v

cd $(dirname $0)

DOCKER_HOST_IP=$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')

echo "DOCKER_HOST_IP=${DOCKER_HOST_IP}" > /tmp/.env
docker-compose down

# docker-compose up --no-start
# docker-compose start
#

docker-compose --env-file /tmp/.env up
