#!/usr/bin/env bash

mysql -h server -u demo -pdemo demo << EOF
truncate mytab;
EOF

mysql -h server -u demo -pdemo demo < /sql/delete-empty-1.sql &
mysql -h server -u root -pdemo demo < /sql/delete-empty-2.sql &

echo sleep 10 seconds ...
sleep 10
