#!/usr/bin/env bash

cd $(dirname $0)

export myenv2=xyz
sudo docker-compose down
sudo --preserve-env=myenv2 docker-compose up --no-start
sudo docker-compose start

sudo docker exec -it docker-compose-variable-demo_client_1 bash -c 'echo $MY_ENV; echo $MY_ENV_02; '
