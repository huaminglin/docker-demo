#!/usr/bin/env bash

cd $(dirname $0)

if [ ! -f $PWD/server.xml ]; then
    echo $PWD/server.xml should be a file.
    exit 1
fi

docker stop demotomcat
docker rm demotomcat
docker create --name demotomcat -e CATALINA_OPTS="-Dcatalina.config=file:///myhome/catalina.properties" -v $PWD/catalina.properties:/myhome/catalina.properties -p 10080:18080 -p 10443:8443 -v $PWD/server.xml:/usr/local/tomcat/conf/server.xml tomcat:9.0.30
docker start demotomcat
