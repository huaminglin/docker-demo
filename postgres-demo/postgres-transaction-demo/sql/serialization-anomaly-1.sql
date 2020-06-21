BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
select 'sql 1', txid_current();
insert into mytab(class, value) select 2, SUM(value) FROM mytab WHERE class = 1;
select 'sql 1', * from pg_locks;

select pg_sleep(1);
select 'sql 1: commit';
commit;
