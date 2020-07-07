select pg_sleep(0.1); -- make sure this transaction starts after the first transaction.
begin;
select 'sql 4', * from t_currency limit 1 for update skip locked;
select 'sql 4: commit';
commit;
