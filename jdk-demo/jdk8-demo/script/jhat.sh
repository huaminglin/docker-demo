#!/usr/bin/env bash

cd $(dirname $0)

mypid=$(sudo docker exec -it jdk8-demo_server_1 jcmd | grep jdk.nashorn.tools.Shell | cut -d ' ' -f1)
echo $mypid

sudo docker exec -it jdk8-demo_server_1 jcmd $mypid GC.heap_dump /mounttmp/$mypid.dump

sudo docker exec -it jdk8-demo_server_1 jhat /mounttmp/$mypid.dump
