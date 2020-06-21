select pg_sleep(0.1); -- make sure this transaction starts after the first transaction.
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
select 'sql 2: sleeping 2 seconds ...';
select pg_sleep(2);
update t_isolation set name='txn2' where id=0 returning 'sql2 updated', *;

select 'sql 2: commit';
commit;
