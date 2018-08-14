#!/usr/bin/env bash

cd $(dirname $0)

docker stop democreation
docker rm democreation
docker create --name democreation --privileged -v $PWD/xstat.sh:/root/xstat.sh -t --entrypoint /bin/sh ubuntu:18.04
docker start democreation

