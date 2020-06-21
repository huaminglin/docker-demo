select pg_sleep(0.1); -- make sure this transaction starts after the first transaction.
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
select 'sql 2', txid_current();
insert into mytab(class, value) select 1, SUM(value) FROM mytab WHERE class = 2;
select 'sql 2', * from pg_locks;

select pg_sleep(2);
select 'sql 2: commit';
commit;

