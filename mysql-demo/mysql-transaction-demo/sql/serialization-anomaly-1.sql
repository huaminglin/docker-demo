SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
start transaction;
insert into mytab(class, value) select 2, SUM(value) FROM mytab WHERE class = 1;

select 'sql 1', sleep(1);
select 'sql 1: commit';
commit;
