#!/usr/bin/env bash

cd $(dirname $0)

docker stop demoopenjdk8
docker rm demoopenjdk8
docker create --name demoopenjdk8 -t openjdk:8-jdk
docker start demoopenjdk8

