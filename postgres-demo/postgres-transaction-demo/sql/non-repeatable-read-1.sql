begin;
select 'sql 1: sleep 2 second';
select pg_sleep(2);
update t_isolation set name='txn1' where id=0 returning 'sql1 updated', *;
select 'sql 1: sleep 5 seconds ...';
select pg_sleep(5);

select 'sql 1', * from t_isolation where id=0;
select 'sql 1: commit';
commit;

