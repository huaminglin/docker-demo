#!/usr/bin/env bash

cd $(dirname $0)

docker stop demomysql
docker rm demomysql
docker create --name demomysql -e MYSQL_ROOT_PASSWORD=demo -p 6603:3306 mysql/mysql-server:5.7  --character-set-server=utf8 --collation-server=utf8_general_ci
docker cp my.cnf.origin demomysql:/etc/my.cnf
docker restart demomysql
