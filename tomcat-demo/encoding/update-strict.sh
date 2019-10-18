#!/usr/bin/env bash

cd $(dirname $0)

docker stop demotomcat
docker rm demotomcat
docker create --name demotomcat -e _JAVA_OPTIONS="-Dorg.apache.catalina.STRICT_SERVLET_COMPLIANCE=true" -v $PWD/encoding.jsp:/usr/local/tomcat/webapps/examples/encoding.jsp -p 18030:8080 tomcat:8.5
docker start demotomcat
