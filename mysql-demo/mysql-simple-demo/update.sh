#!/usr/bin/env bash

cd $(dirname $0)

docker stop demomysql
docker rm demomysql
docker create --name=demomysql -e MYSQL_ROOT_PASSWORD=123456 mysql:8.0
docker start demomysql
