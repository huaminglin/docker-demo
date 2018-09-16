#!/usr/bin/env bash

cd $(dirname $0)
docker stop demologstash
docker rm demologstash

docker create --name demologstash --link demoelasticsearch:elasticsearch -p 5044:5044 -p 31311:31311 -v $PWD/logstash.conf:/usr/share/logstash/pipeline/logstash.conf  docker.elastic.co/logstash/logstash:6.4.0

docker start demologstash
