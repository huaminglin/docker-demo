#!/usr/bin/env bash

cd $(dirname $0)

sudo docker exec -it postgres-vacuum-demo_client_1 bash -c "PGPASSWORD=123456 psql -U pgdemo -h server pgdemo"

