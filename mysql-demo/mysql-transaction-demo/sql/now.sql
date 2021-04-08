select now(6), now(6), UNIX_TIMESTAMP(6), UNIX_TIMESTAMP(6);

start transaction;
select now(6);
select now(6);
commit;
select now(6);
