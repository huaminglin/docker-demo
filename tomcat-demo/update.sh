#!/usr/bin/env bash

cd $(dirname $0)

docker stop demotomcat
docker rm demotomcat
docker create --name demotomcat -p 18030:8080 tomcat:8.5
docker start demotomcat

