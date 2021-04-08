SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
select sleep(0.5); -- make sure this transaction starts after the first transaction.
start transaction;
insert into mytab(class, value) select 1, SUM(value) FROM mytab WHERE class = 2;
select 'sql 2', sleep(2);
select 'sql 2: commit';
commit;

