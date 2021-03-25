#!/usr/bin/env bash

cd $(dirname $0)

perfdata="-XX:+UsePerfData"
# perfdata="-XX:-UsePerfData"

docker stop demoperf
docker rm demoperf
docker create --name demoperf -e JAVA_OPTS="$perfdata" -v /tmp/demooql:/tmp/demoperf -p 18030:8080 tomcat:9.0.43
docker start demoperf
