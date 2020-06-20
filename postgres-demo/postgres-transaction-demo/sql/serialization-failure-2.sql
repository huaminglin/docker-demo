BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
select 'sql 2: sleeping 1 seconds ...';
select pg_sleep(1);
select 'sql 2 first read: before txn-1 update', * from t_isolation where id=0;
select 'sql 2: sleeping 2 seconds ...';
select pg_sleep(2);
select 'sql 2 second read: when txn-1 is runing update', * from t_isolation where id=0;
select 'sql 2: sleeping 5 seconds ...';
select pg_sleep(5);
select 'sql 2 third read: after txn-1 update', * from t_isolation where id=0;

select 'sql 2 third read: all rows', * from t_isolation;

update t_isolation set name='txn2' where id=0 returning 'sql2 updated', *;

select 'sql 2: commit';
commit;

