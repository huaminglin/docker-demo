#!/usr/bin/env bash

cd $(dirname $0)

minikube stop
minikube delete
minikube start --alsologtostderr --vm-driver=virtualbox --registry-mirror=https://registry.docker-cn.com --image-mirror-country=cn --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers

