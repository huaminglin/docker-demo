begin;
select 'sql 2: sleeping 2 seconds ...';
select pg_sleep(2);
update t_test_committed set id = id + 1 returning 'sql2 updated', *;
select 'sql 2', * from t_test_committed;
select 'sql 2: commit';
commit;
