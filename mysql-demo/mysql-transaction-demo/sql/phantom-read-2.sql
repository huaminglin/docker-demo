SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
select sleep(0.1); -- make sure this transaction starts after the first transaction.
start transaction;
select 'sql 2', t.* from t_isolation t;
select 'sql 2: sleeping 1 seconds ...';
select sleep(1);
select 'sql 2 first read: before txn-1 insert', t.* from t_isolation t;
select 'sql 2: sleeping 2 seconds ...';
select sleep(2);
select 'sql 2 second read: when txn-1 is runing insert', t.* from t_isolation t;
select 'sql 2: sleeping 5 seconds ...';
select sleep(5);
select 'sql 2 third read: after txn-1 insert', t.* from t_isolation t;

select 'sql 2: commit';
commit;
