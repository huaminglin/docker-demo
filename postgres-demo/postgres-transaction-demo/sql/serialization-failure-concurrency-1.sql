BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
select 'sql 1: sleep 1 second';
select pg_sleep(1);
update t_isolation set name='txn1' where id=0 returning 'sql1 updated', *;
select 'sql 1: sleep 5 seconds ...';
select pg_sleep(5);

select 'sql 1: commit';
--abort; -- if aborted, the second transaction can update successfully.
commit;
