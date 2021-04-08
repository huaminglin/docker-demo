#!/usr/bin/env bash

mysql -h server -u demo -pdemo demo << EOF
truncate t_isolation;
insert into t_isolation values (0, 'name0');
EOF

mysql -h server -u demo -pdemo demo < /sql/non-repeatable-read-1.sql &
mysql -h server -u demo -pdemo demo < /sql/non-repeatable-read-2.sql &

echo sleep 10 seconds ...
sleep 10
