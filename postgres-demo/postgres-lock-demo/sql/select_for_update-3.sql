select 'sql 3', pg_sleep(0.1); -- make sure this transaction starts after the first transaction.
begin;
update t_currency set description = 'new' where id = 1;
select 'sql 3', * from t_currency where id = 1;
update t_currency set name = 'new' where id = 1;
select 'sql 3: commit';
commit;
