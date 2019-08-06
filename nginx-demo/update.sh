#!/usr/bin/env bash

cd $(dirname $0)

docker stop demonginx
docker rm demonginx
docker create --name demonginx -p 18020:80 -v $PWD/myhttp:/usr/share/nginx/myhttp -v $PWD/myhttp.conf:/etc/nginx/conf.d/default.conf nginx:1.17.2
docker start demonginx

