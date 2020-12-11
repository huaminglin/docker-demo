#!/usr/bin/env bash

cd $(dirname $0)

docker stop demohttpd
docker rm demohttpd
docker create --name demohttpd -e REDIRECT_TARGET=e1 -e REDIRECT_TARGET2="" -e REDIRECT_TARGET3=e3 -e CUSTOMIZED_CONF_HOME=/myhome/customized02.conf -p 18020:80 -v $PWD/cgi-bin:/usr/local/apache2/cgi-bin/my -v $PWD/httpd.conf:/usr/local/apache2/conf/httpd.conf -v $PWD/customized.conf:/myhome/customized.conf -v $PWD/customized02.conf:/myhome/customized02.conf -v $PWD/htdocs:/usr/local/apache2/htdocs/ httpd:2.4 httpd-foreground -D REDIRECT_TARGET4
docker start demohttpd
