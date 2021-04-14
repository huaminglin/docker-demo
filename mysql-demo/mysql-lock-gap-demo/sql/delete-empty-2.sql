select 'sql 2: sleep 1 seconds ...';
select 'sql 2', sleep(1);

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
start transaction;
select * from performance_schema.data_locks;
select 'sql 2: insert into mytab(id, value) values(5, 19)';
insert into mytab(id, value) values(5, 19);
select 'sql 2: commit';
commit;
