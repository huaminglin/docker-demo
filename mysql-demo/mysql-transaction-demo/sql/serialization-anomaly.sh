#!/usr/bin/env bash

mysql -h server -u demo -pdemo demo < /sql/serialization-anomaly-1.sql &
mysql -h server -u demo -pdemo demo < /sql/serialization-anomaly-2.sql &

echo sleep 10 seconds ...
sleep 10
