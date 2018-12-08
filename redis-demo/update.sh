#!/usr/bin/env bash

cd $(dirname $0)

docker stop demoredis
docker rm demoredis
docker create --name demoredis -p 6379:6379 -v /tmp/data:/data redis:5.0 redis-server --appendonly yes

docker start demoredis

docker exec -it demoredis redis-cli info
