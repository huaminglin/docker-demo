#!/usr/bin/env bash

cd $(dirname $0)

docker cp /home/myname/Downloads/elasticsearch-analysis-ik-6.4.0.zip elasticsearch-demo_elasticsearch_1:/tmp

docker start elasticsearch-demo_elasticsearch_1
docker exec -it elasticsearch-demo_elasticsearch_1 /usr/share/elasticsearch/bin/elasticsearch-plugin install file:///tmp/elasticsearch-analysis-ik-6.4.0.zip

docker restart elasticsearch-demo_elasticsearch_1
