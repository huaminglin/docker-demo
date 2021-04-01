#!/usr/bin/env bash

cd $(dirname $0)

docker stop demojfr
docker rm demojfr
docker create --name demojfr -v /tmp/demojfr:/jfr -p 18030:8080 tomcat:9.0.43
docker start demojfr
