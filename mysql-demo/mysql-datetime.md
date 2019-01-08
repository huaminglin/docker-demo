docker-compose exec server bash -c "mysql --default-character-set=latin1 -pdemo mysql -e 'show variables'"|grep zone
| session_track_system_variables                           | time_zone,autocommit,character_set_client,character_set_results,character_set_connection                                                                            
| system_time_zone                                         | UTC                                                          | time_zone                                                | SYSTEM


docker-compose exec server bash -c 'ls -al /usr/share/zoneinfo/America'

## Asia/Shanghai
docker-compose exec server bash -c "echo \"SET time_zone='Asia/Shanghai';\" | cat - /sql/datetime.sql | mysql -pdemo mysql"

@@global.time_zone	@@session.time_zone
SYSTEM	Asia/Shanghai
TIMEDIFF(NOW(), UTC_TIMESTAMP)
08:00:00
FROM_UNIXTIME(946684800)
2000-01-01 08:00:00
UNIX_TIMESTAMP("2000-01-01 00:00:00")
946656000
ID	d	t	dt	ts	y	UNIX_TIMESTAMP(d)	UNIX_TIMESTAMP(dt)	UNIX_TIMESTAMP(ts)
1	2000-01-01	00:00:00	2000-01-01 08:00:00	2000-01-01 08:00:00	2000	946656000	946684800	946684800
2	2000-01-01	00:00:00	2000-01-01 00:00:00	2000-01-01 00:00:00	2000	946656000	946656000	946656000
@@global.time_zone	@@session.time_zone
SYSTEM	UTC
TIMEDIFF(NOW(), UTC_TIMESTAMP)
00:00:00
ID	d	t	dt	ts	y	UNIX_TIMESTAMP(d)	UNIX_TIMESTAMP(dt)	UNIX_TIMESTAMP(ts)
1	2000-01-01	00:00:00	2000-01-01 08:00:00	2000-01-01 00:00:00	2000	946684800	946713600	946684800
2	2000-01-01	00:00:00	2000-01-01 00:00:00	1999-12-31 16:00:00	2000	946684800	946684800	946656000

## America/Chicago
docker-compose exec server bash -c "echo \"SET time_zone='America/Chicago';\" | cat - /sql/datetime.sql | mysql -pdemo mysql"

@@global.time_zone	@@session.time_zone
SYSTEM	America/Chicago
TIMEDIFF(NOW(), UTC_TIMESTAMP)
-06:00:00
FROM_UNIXTIME(946684800)
1999-12-31 18:00:00
UNIX_TIMESTAMP("2000-01-01 00:00:00")
946706400
ID	d	t	dt	ts	y	UNIX_TIMESTAMP(d)	UNIX_TIMESTAMP(dt)	UNIX_TIMESTAMP(ts)
1	2000-01-01	00:00:00	1999-12-31 18:00:00	1999-12-31 18:00:00	2000	946706400	946684800	946684800
2	2000-01-01	00:00:00	2000-01-01 00:00:00	2000-01-01 00:00:00	2000	946706400	946706400	946706400
@@global.time_zone	@@session.time_zone
SYSTEM	UTC
TIMEDIFF(NOW(), UTC_TIMESTAMP)
00:00:00
ID	d	t	dt	ts	y	UNIX_TIMESTAMP(d)	UNIX_TIMESTAMP(dt)	UNIX_TIMESTAMP(ts)
1	2000-01-01	00:00:00	1999-12-31 18:00:00	2000-01-01 00:00:00	2000	946684800	946663200	946684800
2	2000-01-01	00:00:00	2000-01-01 00:00:00	2000-01-01 06:00:00	2000	946684800	946684800	946706400
