#!/usr/bin/env bash

cd $(dirname $0)

docker stop demoptrace
docker rm demoptrace
# docker create --name demoptrace -p 18030:8080 tomcat:9.0.43
docker create --name demoptrace --cap-add=SYS_PTRACE -p 18030:8080 tomcat:9.0.43
docker start demoptrace
