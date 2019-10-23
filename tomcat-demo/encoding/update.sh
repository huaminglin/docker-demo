#!/usr/bin/env bash

cd $(dirname $0)

docker stop demotomcat
docker rm demotomcat
docker create --name demotomcat -v $PWD/jsp:/usr/local/tomcat/webapps/examples/jsp -p 18030:8080 tomcat:8.5
docker start demotomcat

