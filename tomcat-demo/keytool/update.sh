#!/usr/bin/env bash

cd $(dirname $0)

docker stop demotomcat
docker rm demotomcat
docker create --name demotomcat tomcat:8.5
docker start demotomcat

docker exec -it demotomcat keytool -genkey -alias tomcata -keyalg RSA -keystore /root/tomcat.jks -storetype pkcs12 -storepass changeit -dname "CN=127.0.0.1, OU=myunit, O=myorg, L=mycity, ST=mystate, C=cn"
docker exec -it demotomcat keytool -genkey -alias tomcatb -keyalg RSA -keystore /root/tomcat.jks -storetype pkcs12 -storepass changeit -dname "CN=myfirst2 mylast2, OU=myunit2, O=myorg2, L=mycity2, ST=mystate2, C=cn"
docker exec demotomcat keytool -exportcert -alias tomcata -storepass changeit -keystore /root/tomcat.jks -rfc -file /root/tomcata.pem
docker exec demotomcat keytool -exportcert -alias tomcatb -storepass changeit -keystore /root/tomcat.jks -rfc -file /root/tomcatb.pem

docker cp demotomcat:/root/tomcat.jks tomcat.jks
docker cp demotomcat:/root/tomcata.pem tomcata.pem
docker cp demotomcat:/root/tomcatb.pem tomcatb.pem

