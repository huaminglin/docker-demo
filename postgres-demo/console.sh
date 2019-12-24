#!/usr/bin/env bash

cd $(dirname $0)

if ! docker ps | grep mypostgres; then
    docker start mypostgres
fi

docker exec -it mypostgres bash

