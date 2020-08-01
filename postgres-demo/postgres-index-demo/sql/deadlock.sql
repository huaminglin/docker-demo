begin;
UPDATE t_deadlock SET id=id*10 where id = 1; -- lock row 1
select 'sql 1: sleep 2 seconds ...', pg_sleep(2); -- wait for txn2
UPDATE t_deadlock SET id=id*10 where id = 2; -- this row has been locked by txn 2

select 'sql 1: commit';
commit;
