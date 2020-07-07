#!/usr/bin/env bash

cd $(dirname $0)

sudo docker stop mypostgres
sudo docker rm mypostgres
sudo docker create -e POSTGRES_DB=pgdb -e POSTGRES_USER=pgdemo -e POSTGRES_PASSWORD=123456 -p 5432:5432 --name mypostgres postgres:12.1
sudo docker start mypostgres

