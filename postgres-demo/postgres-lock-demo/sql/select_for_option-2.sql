select pg_sleep(0.1); -- make sure this transaction starts after the first transaction.
begin;
select 'sql 2', * from t_currency where id = 1 for update NOWAIT;
select 'sql 2: commit';
commit;
