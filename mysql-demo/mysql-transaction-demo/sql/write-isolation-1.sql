start transaction;
select 'sql 1', @amount := value from mywrite where id=1;
select 'sql 1: sleep 1 second', now();
select 'sql 1', now(), sleep(1);
update mywrite set value = @amount - 1 where id=1;
select 'sql 1: sleep 5 seconds ...', now();
select 'sql 1', now(), sleep(5);

select 'sql 1', now(), t.* from mywrite t where id=1;
select 'sql 1: commit';
commit;
select 'sql 1', now(), t.* from mywrite t where id=1;
