SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
select sleep(0.5); -- make sure this transaction starts after the first transaction.
start transaction;
select 'sql 2: sleeping 2 seconds ...';
select 'sql 2', sleep(2);
update t_isolation set name='txn2' where id=0;
select 'sql2 updated';

select 'sql 2: commit';
commit;

select 'sql 2 last read: all rows', t.* from t_isolation t;
