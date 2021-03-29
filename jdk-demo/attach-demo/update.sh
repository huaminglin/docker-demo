#!/usr/bin/env bash

cd $(dirname $0)

# attachflag="-XX:+DisableAttachMechanism"
# attachflag="-XX:-DisableAttachMechanism"
attachflag="-XX:-UsePerfData"

docker stop demoattach
docker rm demoattach
docker create --name demoattach -v /tmp/demoattach:/tmp/demoattach -v $PWD/jstatd.policy:/jstatd.policy -p 10086:10086 openjdk:11.0.8-jdk jstatd -p 10086 -J-Djava.rmi.server.hostname=server01 -J$attachflag -J-Djava.rmi.server.logCalls=true -J-Djava.security.policy=/jstatd.policy
docker start demoattach
