#!/usr/bin/env bash

cd $(dirname $0)

docker stop mypostgres
docker rm mypostgres
docker create -p 5432:5432 --name mypostgres postgres:12.1
docker start mypostgres

