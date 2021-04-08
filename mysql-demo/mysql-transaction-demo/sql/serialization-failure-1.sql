SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
start transaction;
select 'sql 1', t.* from t_isolation t;
select 'sql 1: sleep 2 second';
select sleep(2);
update t_isolation set name='txn1' where id=0;
select 'sql1 updated';
select 'sql 1: sleep 5 seconds ...';
select sleep(5);

insert into t_isolation values (0, 'txn1');
select 'sql1 inserted';

select 'sql 1', t.* from t_isolation t;
select 'sql 1: commit';
commit;
