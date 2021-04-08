#!/usr/bin/env bash

mysql -h server -u demo -pdemo demo << EOF
truncate t_test_committed;
insert into t_test_committed values (0);
EOF

mysql -h server -u demo -pdemo demo < /sql/read-isolation-1.sql &
mysql -h server -u demo -pdemo demo < /sql/read-isolation-2.sql &

echo sleep 10 seconds ...
sleep 10
