SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
start transaction;
-- delete from mytab;
-- select 'sql1: delete from mytab';
delete from mytab where value > 20;
select 'sql1: delete from mytab where value > 20';
select 'sql 1: sleep 5 seconds ...';
select 'sql 1', sleep(5);
select 'sql 1: commit';
commit;
