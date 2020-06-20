begin;
select 'sql 2: sleeping 1 seconds ...';
select pg_sleep(1);
select 'sql 2 first read: before txn-1 insert', * from t_isolation;
select 'sql 2: sleeping 2 seconds ...';
select pg_sleep(2);
select 'sql 2 second read: when txn-1 is runing insert', * from t_isolation;
select 'sql 2: sleeping 5 seconds ...';
select pg_sleep(5);
select 'sql 2 third read: after txn-1 insert', * from t_isolation;

select 'sql 2: commit';
commit;
