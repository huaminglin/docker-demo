create table t_test_committed (id int);

create table t_isolation(id int, name varchar(8));

create table mytab(class int, value int);
insert into mytab(class, value) values(1, 10);
insert into mytab(class, value) values(1, 20);
insert into mytab(class, value) values(2, 100);
insert into mytab(class, value) values(2, 200);
