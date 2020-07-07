begin;
select 'sql 1', * from t_currency where id = 1 for update;
select 'sql 1: sleep 5 seconds ...';
select 'sql1', pg_sleep(5);

select 'sql 1: commit';
commit;
