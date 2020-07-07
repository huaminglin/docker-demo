select pg_sleep(0.1); -- make sure this transaction starts after the first transaction.
begin;
SET lock_timeout TO 1000;
select 'sql 3', * from t_currency where id = 1 for update;
select 'sql 3: commit';
commit;
