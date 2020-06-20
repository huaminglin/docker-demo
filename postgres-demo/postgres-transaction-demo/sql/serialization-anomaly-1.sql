BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
insert into mytab(class, value) select 2, SUM(value) FROM mytab WHERE class = 1;

select pg_sleep(2);
select 'sql 1: commit';
commit;
