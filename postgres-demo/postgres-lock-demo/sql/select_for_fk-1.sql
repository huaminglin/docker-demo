begin;
select 'sql 1', * from t_account where id = 1 for update;
select 'sql 1: sleep 5 seconds ...';
select pg_sleep(5);

select 'sql 1: commit';
commit;
