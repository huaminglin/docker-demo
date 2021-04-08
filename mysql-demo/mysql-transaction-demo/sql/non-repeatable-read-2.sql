SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
start transaction;
select 'sql 2: sleeping 1 seconds ...';
select sleep(1);
select 'sql 2 first read: before txn-1 update', t.* from t_isolation t where id=0;
select 'sql 2: sleeping 2 seconds ...';
select sleep(2);
select 'sql 2 second read: when txn-1 is runing update', t.* from t_isolation t where id=0;
select 'sql 2: sleeping 5 seconds ...';
select sleep(5);
select 'sql 2 third read: after txn-1 update', t.* from t_isolation t where id=0;

select 'sql 2: commit';
commit;
