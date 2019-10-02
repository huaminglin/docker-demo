#!/usr/bin/env bash

cd $(dirname $0)

docker-compose down
docker-compose up --no-start
docker-compose start

