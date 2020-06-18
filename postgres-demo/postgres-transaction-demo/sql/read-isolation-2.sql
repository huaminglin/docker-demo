begin;
select 'sql 2: sleeping 2 seconds ...';
select pg_sleep(2);
select 'sql 2', * from t_test_committed;
select 'sql 2: commit';
commit;

