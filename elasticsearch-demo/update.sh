#!/usr/bin/env bash

cd $(dirname $0)

docker stop demoelasticsearch
docker rm demoelasticsearch
docker create --name demoelasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.4.0

docker start demoelasticsearch
