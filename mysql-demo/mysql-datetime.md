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
ROUND((UNIX_TIMESTAMP("2000-01-01 00:00:00") - 946684800)/3600)
-8
ID	d	t	dt	ts	y	ROUND((UNIX_TIMESTAMP(d) - 946684800)/3600)	ROUND((UNIX_TIMESTAMP(dt) - 946684800)/3600)	ROUND((UNIX_TIMESTAMP(ts) - 946684800)/3600)	CONVERT_TZ	CONVERT_TZ(dt,  @@session.time_zone, "UTC")	CONVERT_TZ(ts,  @@session.time_zone, "UTC")
1	2000-01-01	00:00:00	2000-01-01 00:00:00	2000-01-01 00:00:00	2000	-8	-8	-8	CONVERT_TZ	1999-12-31 16:00:00	1999-12-31 16:00:00
2	2000-01-01	00:00:00	2000-01-01 08:00:00	2000-01-01 08:00:00	2000	-8	0	0	CONVERT_TZ	2000-01-01 00:00:00	2000-01-01 00:00:00
3	2000-01-01	00:00:00	2000-01-01 08:00:00	2000-01-01 08:00:00	2000	-8	0	0	CONVERT_TZ	2000-01-01 00:00:00	2000-01-01 00:00:00
@@global.time_zone	@@session.time_zone
SYSTEM	UTC
TIMEDIFF(NOW(), UTC_TIMESTAMP)
00:00:00
ID	d	t	dt	ts	y	ROUND((UNIX_TIMESTAMP(d) - 946684800)/3600)	ROUND((UNIX_TIMESTAMP(dt) - 946684800)/3600)	ROUND((UNIX_TIMESTAMP(ts) - 946684800)/3600)
1	2000-01-01	00:00:00	2000-01-01 00:00:00	1999-12-31 16:00:00	2000	0	0	-8
2	2000-01-01	00:00:00	2000-01-01 08:00:00	2000-01-01 00:00:00	2000	0	8	0
3	2000-01-01	00:00:00	2000-01-01 08:00:00	2000-01-01 00:00:00	2000	0	8	0


## America/Chicago
docker-compose exec server bash -c "echo \"SET time_zone='America/Chicago';\" | cat - /sql/datetime.sql | mysql -pdemo mysql"

@@global.time_zone	@@session.time_zone
SYSTEM	America/Chicago
TIMEDIFF(NOW(), UTC_TIMESTAMP)
-06:00:00
FROM_UNIXTIME(946684800)
1999-12-31 18:00:00
ROUND((UNIX_TIMESTAMP("2000-01-01 00:00:00") - 946684800)/3600)
6
ID	d	t	dt	ts	y	ROUND((UNIX_TIMESTAMP(d) - 946684800)/3600)	ROUND((UNIX_TIMESTAMP(dt) - 946684800)/3600)	ROUND((UNIX_TIMESTAMP(ts) - 946684800)/3600)	CONVERT_TZ	CONVERT_TZ(dt,  @@session.time_zone, "UTC")	CONVERT_TZ(ts,  @@session.time_zone, "UTC")
1	2000-01-01	00:00:00	2000-01-01 00:00:00	2000-01-01 00:00:00	2000	6	6	6	CONVERT_TZ	2000-01-01 06:00:00	2000-01-01 06:00:00
2	2000-01-01	00:00:00	1999-12-31 18:00:00	1999-12-31 18:00:00	2000	6	0	0	CONVERT_TZ	2000-01-01 00:00:00	2000-01-01 00:00:00
3	2000-01-01	00:00:00	1999-12-31 18:00:00	1999-12-31 18:00:00	2000	6	0	0	CONVERT_TZ	2000-01-01 00:00:00	2000-01-01 00:00:00
@@global.time_zone	@@session.time_zone
SYSTEM	UTC
TIMEDIFF(NOW(), UTC_TIMESTAMP)
00:00:00
ID	d	t	dt	ts	y	ROUND((UNIX_TIMESTAMP(d) - 946684800)/3600)	ROUND((UNIX_TIMESTAMP(dt) - 946684800)/3600)	ROUND((UNIX_TIMESTAMP(ts) - 946684800)/3600)
1	2000-01-01	00:00:00	2000-01-01 00:00:00	2000-01-01 06:00:00	2000	0	0	6
2	2000-01-01	00:00:00	1999-12-31 18:00:00	2000-01-01 00:00:00	2000	0	-6	0
3	2000-01-01	00:00:00	1999-12-31 18:00:00	2000-01-01 00:00:00	2000	0	-6	0


## Summary
MySQL Datetime Literal are parsed with @@session.time_zone;
FROM_UNIXTIME can be used to input a date time at UTC timezone;
UNIX_TIMESTAMP can be used to output a date time at UTC timezone.
The write/read of dt column don't involve any timezone conversion, and the dt column has same value on different @@session.time_zone.
CONVERT_TZ('xxx',  @@session.time_zone, "UTC") can be used to output a date time with UTC timezone.
CONVERT_TZ('xxx',  "UTC", @@session.time_zone) can be used to input a date time literal with UTC timezone.
