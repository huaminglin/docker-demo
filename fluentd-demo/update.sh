#!/usr/bin/env bash

cd $(dirname $0)

docker stop demofluentd
docker rm demofluentd
docker create --name demofluentd -p 24224:24224 -p 24224:24224/udp -p 24280:24280 -v /data:/fluentd/log -v $PWD/fluent.conf:/fluentd/etc/fluent.conf  fluent/fluentd

docker start demofluentd
