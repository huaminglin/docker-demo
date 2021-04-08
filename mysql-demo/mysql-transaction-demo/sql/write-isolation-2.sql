start transaction;
select 'sql 2', @amount := value from mywrite where id=1;
select 'sql 2: sleeping 2 seconds ...', now();
select 'sql 2', now(), sleep(2);
-- The update will blocks until the write-isolation-1.sql commits its transaction.
update mywrite set value = @amount - 1 where id=1;
select 'sql 2: sleeping 2 seconds ...', now(), @amount - 1;
select 'sql 2', now(), sleep(2);
select 'sql 2', now(), t.* from mywrite t where id=1;
select 'sql 2: commit';
commit;
select 'sql 2', now(), t.* from mywrite t where id=1;
