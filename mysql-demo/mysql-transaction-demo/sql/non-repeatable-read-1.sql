SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
start transaction;
select 'sql 1: sleep 2 second';
select sleep(2);
update t_isolation set name='txn1' where id=0;
select 'sql1 updated';
select 'sql 1: sleep 5 seconds ...';
select sleep(5);

select 'sql 1', t.* from t_isolation t where id=0;
select 'sql 1: commit';
commit;
