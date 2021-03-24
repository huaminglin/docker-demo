#!/usr/bin/env bash

cd $(dirname $0)

docker stop demooql
docker rm demooql
docker create --name demooql -v /tmp/demooql:/tmp/demooql -p 18030:8080 tomcat:9.0.43
docker start demooql
