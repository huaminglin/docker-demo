#!/usr/bin/env bash

cd $(dirname $0)

docker stop demohttpd
docker rm demohttpd
docker create --name demohttpd -p 18020:80 httpd:2.4
docker start demohttpd

