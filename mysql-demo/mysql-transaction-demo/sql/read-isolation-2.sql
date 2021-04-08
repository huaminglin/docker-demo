start transaction;
select 'sql 2: sleeping 2 seconds ...';
select sleep(2);
select 'sql 2', t.* from t_test_committed t;
select 'sql 2: commit';
commit;
