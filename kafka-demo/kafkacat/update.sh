#!/usr/bin/env bash

cd $(dirname $0)

echo MY_HOST_IP: $MY_HOST_IP

sudo docker stop kafkacat
sudo docker rm kafkacat
sudo docker create -it --name kafkacat -e MY_HOST_IP=$MY_HOST_IP confluentinc/cp-kafkacat:5.5.2 /bin/bash
sudo docker start kafkacat
