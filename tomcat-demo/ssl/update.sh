#!/usr/bin/env bash

cd $(dirname $0)

if [ ! -f $PWD/server.xml ]; then
    echo $PWD/server.xml should be a file.
    exit 1
fi

if [ ! -f $PWD/tomcat.jks ]; then
    echo $PWD/tomcat.jks should be a file.
    exit 1
fi

docker stop demotomcat
docker rm demotomcat
docker create --name demotomcat -p 10080:8080 -p 10443:8443 -v $PWD/server.xml:/usr/local/tomcat/conf/server.xml -v $PWD/tomcat.jks:/usr/local/tomcat/conf/localhost-rsa.jks tomcat:8.5
docker start demotomcat

