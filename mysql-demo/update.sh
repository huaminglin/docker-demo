#!/usr/bin/env bash

cd $(dirname $0)

docker stop demomysql
docker rm demomysql
docker create --name demomysql -e MYSQL_ROOT_PASSWORD=demo -p 6603:3306 mysql/mysql-server:5.7  --character-set-server=utf8 --collation-server=utf8_general_ci


if [ -z $DOCKER_MYSQL_CONFIG ]; then
    DOCKER_MYSQL_CONFIG="$*"
fi

if [ -z $DOCKER_MYSQL_CONFIG ]; then
    DOCKER_MYSQL_CONFIG=my.cnf.origin
fi

echo DOCKER_MYSQL_CONFIG: $DOCKER_MYSQL_CONFIG
docker cp $DOCKER_MYSQL_CONFIG demomysql:/etc/my.cnf
docker start demomysql
docker exec demomysql touch /var/log/mysql.general.log
docker exec demomysql chown mysql.mysql /var/log/mysql.general.log
docker restart demomysql
