begin;
select 'sql 1: sleep 1 second';
select pg_sleep(1);
update t_test_committed set id = id + 1 returning *;
select 'sql 1: sleep 5 seconds ...';
select pg_sleep(5);

select 'sql 1', * from t_test_committed;
select 'sql 1: commit';
commit;

