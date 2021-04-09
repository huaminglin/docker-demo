start transaction;
select 'sql 2: sleep 1 seconds ...';
select 'sql 2', sleep(1);
select 'sql 2: insert into mytab(id, value) values(1, 100)';
insert into mytab(id, value) values(1, 100);
select 'sql 2: commit';
commit;
