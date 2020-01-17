#!/usr/bin/env bash

cd $(dirname $0)

if [ ! -f $PWD/tomcat-users.xml ]; then
    echo $PWD/tomcat-users.xml should be a file.
    exit 1
fi

if [ ! -f $PWD/manager/context.xml ]; then
    echo $PWD/manager/context.xml should be a file.
    exit 1
fi

docker stop demotomcat
docker rm demotomcat
docker create --name demotomcat -p 10080:8080 -p 10443:8443 -v $PWD/tomcat-users.xml:/usr/local/tomcat/conf/tomcat-users.xml -v $PWD/manager/context.xml:/usr/local/tomcat/webapps/manager/META-INF/context.xml tomcat:8.5
docker start demotomcat

