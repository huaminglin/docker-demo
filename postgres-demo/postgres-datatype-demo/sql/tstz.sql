begin;
set timezone to 'Asia/Shanghai';
select 'Asia/Shanghai', now();
select timestamptz '2020-06-08 04:05:06', timestamptz '2020-06-08 04:05:06+02';
insert into tstz values(now(), now());

set timezone to 'Europe/London';
select 'Europe/London', now();
select timestamptz '2020-06-08 04:05:06', timestamptz '2020-06-08 04:05:06+02';
insert into tstz values(now(), now());

set timezone to 'Asia/Shanghai';
select 'Asia/Shanghai', now();

table tstz;

set timezone to 'Europe/London';
select 'Europe/London', now();
table tstz;

rollback;

begin;
insert into tstz values('2020-06-08 04:05:06+02', '2020-06-08 04:05:06+02');
insert into tstz values('2020-06-08 04:05:06+08', '2020-06-08 04:05:06+08');

table tstz;
rollback;
