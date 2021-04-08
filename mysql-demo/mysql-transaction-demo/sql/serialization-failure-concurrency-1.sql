SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
start transaction;
select 'sql 1: sleep 1 second';
select 'sql 1', sleep(1);
update t_isolation set name='txn1' where id=0;
select 'sql1 updated';
select 'sql 1: sleep 5 seconds ...';
select 'sql 1', sleep(5);

select 'sql 1: commit';
commit;
