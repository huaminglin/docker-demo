SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
select sleep(0.5); -- make sure this transaction starts after the first transaction.
start transaction;
select 'sql 2', t.* from t_isolation t;
select 'sql 2: sleeping 1 seconds ...';
select sleep(1);
select 'sql 2 first read: before txn-1 update', t.* from t_isolation t where id=0;
select 'sql 2: sleeping 2 seconds ...';
select sleep(2);
select 'sql 2 second read: when txn-1 is runing update', t.* from t_isolation t where id=0;
select 'sql 2: sleeping 5 seconds ...';
select sleep(5);
select 'sql 2 third read: after txn-1 update', t.* from t_isolation t where id=0;

select 'sql 2 third read: all rows', t.* from t_isolation t;

update t_isolation set name='txn2' where id=0;
select 'sql2 updated';

select 'sql 2: commit';
commit;

select 'sql 2 last read: all rows', t.* from t_isolation t;
