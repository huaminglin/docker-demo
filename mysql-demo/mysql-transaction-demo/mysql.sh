#!/usr/bin/env bash

cd $(dirname $0)

docker exec -it mysql-transaction-demo_client_1 mysql -h server -u demo -pdemo demo
