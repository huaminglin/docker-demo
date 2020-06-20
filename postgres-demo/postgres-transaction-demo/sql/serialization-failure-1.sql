BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
select 'sql 1', xmin, xmax, txid_current(), * from t_isolation;
select 'sql 1: sleep 2 second';
select pg_sleep(2);
update t_isolation set name='txn1' where id=0 returning 'sql1 updated', *;
select 'sql 1: sleep 5 seconds ...';
select pg_sleep(5);

insert into t_isolation values (0, 'txn1') returning 'sql1 inserted', *;

select 'sql 1', xmin, xmax, txid_current(), * from t_isolation;
select 'sql 1: commit';
commit;

