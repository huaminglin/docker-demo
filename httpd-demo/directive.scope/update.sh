#!/usr/bin/env bash

cd $(dirname $0)

docker stop demohttpd
docker rm demohttpd
docker create --name demohttpd -p 18020:80 -v $PWD/httpd.conf:/usr/local/apache2/conf/httpd.conf -v $PWD/htdocs:/usr/local/apache2/htdocs/ httpd:2.4
docker start demohttpd

