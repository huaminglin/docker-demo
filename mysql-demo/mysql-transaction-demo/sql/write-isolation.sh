#!/usr/bin/env bash

mysql -h server -u demo -pdemo demo << EOF
truncate mywrite;
insert into mywrite values(1, 100);
EOF

mysql -h server -u demo -pdemo demo < /sql/write-isolation-1.sql &
mysql -h server -u demo -pdemo demo < /sql/write-isolation-2.sql &

echo sleep 10 seconds ...
sleep 10
