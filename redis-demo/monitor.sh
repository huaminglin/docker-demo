#!/usr/bin/env bash

cd $(dirname $0)

sudo docker exec redis-demo_client_1 redis-cli -h server monitor

