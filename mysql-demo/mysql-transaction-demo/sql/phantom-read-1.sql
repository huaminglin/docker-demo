SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
start transaction;
select 'sql 1: sleep 2 second';
select sleep(2);
insert into t_isolation values (1, 'txn1');
select 'sql1 inserted';
select 'sql 1: sleep 5 seconds ...';
select sleep(5);

select 'sql 1: commit';
commit;
