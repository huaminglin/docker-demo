#!/usr/bin/env bash

mysql -h server -u demo -pdemo demo << EOF
truncate mytab;
insert into mytab(id, value) values(1, 10);
insert into mytab(id, value) values(2, 11);
insert into mytab(id, value) values(3, 13);
insert into mytab(id, value) values(4, 20);
EOF

mysql -h server -u demo -pdemo demo << EOF &
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
start transaction;
-- UPDATE mytab set value = value + 1 WHERE value > 20;
-- UPDATE mytab set value = value + 1 WHERE value > 18;
UPDATE mytab set value = value + 1 WHERE value = 20;
select 'sql1: UPDATE mytab set value = value + 1 WHERE value = 20';
select 'sql 1: sleep 5 seconds ...';
select 'sql 1', sleep(5);
select 'sql 1: commit';
commit;
EOF

# ERROR 1142 (42000) at line 4: SELECT command denied to user 'demo'@'172.26.0.3' for table 'data_locks'
mysql -h server -u root -pdemo demo  << EOF &
select 'sql 2: sleep 1 seconds ...';
select 'sql 2', sleep(1);

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
start transaction;
select * from performance_schema.data_locks;
select 'sql 2: insert into mytab(id, value) values(5, 13)';
# insert into mytab(id, value) values(5, 19);
insert into mytab(id, value) values(5, 13);
select 'sql 2: commit';
commit;
EOF

echo sleep 10 seconds ...
sleep 10
