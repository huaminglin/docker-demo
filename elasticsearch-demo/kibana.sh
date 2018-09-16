#!/usr/bin/env bash

cd $(dirname $0)

docker create --link demoelasticsearch:elastic-url -e "ELASTICSEARCH_URL=http://elastic-url:9200" -p 5601:5601 --name demokibana docker.elastic.co/kibana/kibana:6.4.0

docker start demokibana
