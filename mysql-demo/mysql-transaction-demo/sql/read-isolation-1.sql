start transaction;
select 'sql 1: sleep 1 second';
select SLEEP(1);
update t_test_committed set id = id + 1;
select 'sql 1: sleep 5 seconds after 0 -> 1 ...';
select SLEEP(5);

select 'sql 1', t.* from t_test_committed t;
select 'sql 1: commit';
commit;

