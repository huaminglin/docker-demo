#!/usr/bin/env bash

cd $(dirname $0)
echo MY_HOST_IP: $MY_HOST_IP

sudo --preserve-env=MY_HOST_IP docker-compose down
sudo --preserve-env=MY_HOST_IP docker-compose up --no-start
sudo --preserve-env=MY_HOST_IP docker-compose start
