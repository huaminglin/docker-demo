#!/usr/bin/env bash

cd $(dirname $0)

if [ ! -f $PWD/server.xml ]; then
    echo $PWD/server.xml should be a file.
    exit 1
fi

docker stop demotomcat
docker rm demotomcat
docker create --name demotomcat -p 10080:8080 -p 10443:8443 -v $PWD/../manager/tomcat-users.xml:/usr/local/tomcat/conf/tomcat-users.xml -v $PWD/../manager/manager/context.xml:/usr/local/tomcat/webapps.dist/manager/META-INF/context.xml -v $PWD//server.xml:/usr/local/tomcat/conf/server.xml -v $PWD/../ssl/tomcat.jks:/usr/local/tomcat/conf/localhost-rsa.jks  -v $PWD/web.xml:/usr/local/tomcat/conf/web.xml -v $PWD/context.xml:/usr/local/tomcat/conf/context.xml tomcat:9.0.30
docker start demotomcat

