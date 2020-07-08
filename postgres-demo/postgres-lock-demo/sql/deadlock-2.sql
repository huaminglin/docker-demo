begin;
select 'sql 2: sleep 1 seconds ...', pg_sleep(1); -- wait for txn1
UPDATE t_deadlock SET id=id*10 where id = 2; -- lock row 2
UPDATE t_deadlock SET id=id*10 where id = 1; -- try to lock row 1 which has been locked by txn1

select 'sql 2: commit';
commit;
