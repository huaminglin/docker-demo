#!/usr/bin/env bash

cd $(dirname $0)

docker cp /home/myname/Downloads/elasticsearch-analysis-ik-6.4.0.zip demoelasticsearch:/tmp

docker start demoelasticsearch
docker exec -it demoelasticsearch /usr/share/elasticsearch/bin/elasticsearch-plugin install file:///tmp/elasticsearch-analysis-ik-6.4.0.zip

docker restart demoelasticsearch
