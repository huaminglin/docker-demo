## Character set of connection
docker-compose exec server mysql -pdemo mysql -e "SHOW SESSION VARIABLES LIKE 'character\_set\_%'"
+--------------------------+--------+
| Variable_name            | Value  |
+--------------------------+--------+
| character_set_client     | latin1 |
| character_set_connection | latin1 |
| character_set_database   | utf8   |
| character_set_filesystem | binary |
| character_set_results    | latin1 |
| character_set_server     | utf8   |
| character_set_system     | utf8   |
+--------------------------+--------+

docker-compose exec server mysql -pdemo mysql -e "SHOW SESSION VARIABLES LIKE 'collation\_%'"
+----------------------+-------------------+
| Variable_name        | Value             |
+----------------------+-------------------+
| collation_connection | latin1_swedish_ci |
| collation_database   | utf8_general_ci   |
| collation_server     | utf8_general_ci   |
+----------------------+-------------------+

## Insert Non-ascill data into MySQL MYISAM table
a. Create table
docker-compose exec server bash -c "mysql --default-character-set=latin1 -pdemo mysql < /sql/table.sql"

b. docker-compose doesn't support non-ascill character in command
docker-compose exec server mysql -pdemo mysql -e "insert into t1 VALUES('¥', '¥')";
Traceback (most recent call last):
  File "/usr/local/bin/docker-compose", line 11, in <module>
    sys.exit(main())
  File "/usr/local/lib/python2.7/dist-packages/compose/cli/main.py", line 71, in main
    command()
  File "/usr/local/lib/python2.7/dist-packages/compose/cli/main.py", line 127, in perform_command
    handler(command, command_options)
  File "/usr/local/lib/python2.7/dist-packages/compose/cli/main.py", line 491, in exec_command
    self.toplevel_options)
  File "/usr/local/lib/python2.7/dist-packages/compose/cli/main.py", line 1427, in call_docker
    log.debug(" ".join(map(pipes.quote, args)))
UnicodeDecodeError: 'ascii' codec can't decode byte 0xa5 in position 28: ordinal not in range(128)
Conclusion: docker-compose doesn't support non-ascii well

c. Insert non-ascii data
docker-compose exec server bash
mysql -pdemo mysql --default-character-set=latin1 -e "insert into t1 VALUES('aaa¥bbb', 'aaaa¥bbbb')";
docker-compose exec server mysql -pdemo mysql --default-character-set=latin1 -e "select * from t1"

d. Check MYISAM data file
docker cp mysql-demo_server_1:/var/lib/mysql/mysql/t1.MYD /tmp
chown 1000:1000 /tmp/t1.MYD

hexdump /tmp/t1.MYD
0000000 0003 0014 07fc 6161 a561 6262 0a62 6161
0000010 6161 a5c2 6262 6262                    
0000018

hexdump -C /tmp/t1.MYD
00000000  03 00 14 00 fc 07 61 61  61 a5 62 62 62 0a 61 61  |......aaa.bbb.aa|
00000010  61 61 c2 a5 62 62 62 62                           |aa..bbbb|
00000018

od -tx1 /tmp/t1.MYD
0000000 03 00 14 00 fc 07 61 61 61 a5 62 62 62 0a 61 61
0000020 61 61 c2 a5 62 62 62 62
0000030

Open /tmp/t1.MYD  with VSCode

e. Reset database and dump t1.MYD with data-utf8.sql and data-latin1.sql
docker-compose exec server bash -c "mysql --default-character-set=latin1 -pdemo mysql < /sql/table.sql"

docker-compose exec server bash -c "mysql --default-character-set=latin1 -pdemo mysql < /sql/data-utf8.sql"
docker-compose exec server bash -c "mysql --default-character-set=latin1 -pdemo mysql < /sql/data-latin1.sql"
docker-compose exec server bash -c "mysql --default-character-set=utf8mb4 -pdemo mysql < /sql/data-utf8.sql"
mysql: [Warning] Using a password on the command line interface can be insecure.
id	col1	col2	length(col1)	length(col2)
1	aaaÂ¥bbb	aaaaÂ¥bbbb	8	12
2	aaa¥bbb	aaaa¥bbbb	7	10
3	aaa¥bbb	aaaa¥bbbb	7	10
Conclusion: In row 1, "¥" in ut8.sql is encoded as two bytes "Â¥";

docker-compose exec server bash -c "mysql --default-character-set=utf8mb4 -pdemo mysql < /sql/data-latin1.sql"
mysql: [Warning] Using a password on the command line interface can be insecure.
ERROR 1366 (HY000) at line 1: Incorrect string value: '\xA5bbb' for column 'col1' at row 1
Conclusion: data-latin1.sql is parsed as utf8mb4 but '\xA5' this byte is not recongnizable.

docker cp mysql-demo_server_1:/var/lib/mysql/mysql/t1.MYD /tmp/t1-multiple.MYD
chown 1000:1000 /tmp/t1-multiple.MYD
od -tx1 t1-multiple.MYD
0000000 03 00 1c 00 00 fc 01 00 00 00 08 61 61 61 c2 a5
0000020 62 62 62 0c 61 61 61 61 c3 82 c2 a5 62 62 62 62
0000040 01 00 19 00 fc 02 00 00 00 07 61 61 61 a5 62 62
0000060 62 0a 61 61 61 61 c2 a5 62 62 62 62 01 00 19 00
0000100 fc 03 00 00 00 07 61 61 61 a5 62 62 62 0a 61 61
0000120 61 61 c2 a5 62 62 62 62
0000130

## Select SQL
a. length() and column character set
Set Terminal > Preferences > Unnamed > Compatibility > Encoding: Western - ISO-8859-1
docker-compose exec server mysql -pdemo mysql --default-character-set=latin1 -e "select col1,col2,length(col1),length(col2) from t1";
mysql: [Warning] Using a password on the command line interface can be insecure.
+----------+------------+--------------+--------------+
| col1     | col2       | length(col1) | length(col2) |
+----------+------------+--------------+--------------+
| aaaÂ¥bbb | aaaaÂ¥bbbb |            8 |           12 |
| aaa¥bbb  | aaaa¥bbbb  |            7 |           10 |
| aaa¥bbb  | aaaa¥bbbb  |            7 |           10 |
+----------+------------+--------------+--------------+
Conclusion: "¥" has different length in col1 and col2 since the columns have different character_set;

b. length() and character_set_connection with ISO-8859-1 terminal
Set Terminal > Preferences > Unnamed > Compatibility > Encoding: Western - ISO-8859-1
docker-compose exec server bash -c "mysql --default-character-set=latin1 -pdemo mysql < /sql/query-latin1.sql"
mysql: [Warning] Using a password on the command line interface can be insecure.
id	col1	col2	length(col1)	length(col2)
1	aaaÂ¥bbb	aaaaÂ¥bbbb	8	12
2	aaa¥bbb	aaaa¥bbbb	7	10
3	aaa¥bbb	aaaa¥bbbb	7	10
utf8 connection ¥	length('¥')
¥	2
latin1 connection ¥	length('¥')
¥	1

docker-compose exec server bash -c "mysql --default-character-set=latin1 -pdemo mysql < /sql/query-utf8.sql"
mysql: [Warning] Using a password on the command line interface can be insecure.
id	col1	col2	length(col1)	length(col2)
1	aaaÂ¥bbb	aaaaÂ¥bbbb	8	12
2	aaa¥bbb	aaaa¥bbbb	7	10
3	aaa¥bbb	aaaa¥bbbb	7	10
utf8 connection Â¥	length('Â¥')
Â¥	4
latin1 connection Â¥	length('Â¥')
Â¥	2

docker-compose exec server bash -c "mysql --default-character-set=utf8mb4 -pdemo mysql < /sql/query-latin1.sql"
mysql: [Warning] Using a password on the command line interface can be insecure.
id	col1	col2	length(col1)	length(col2)
1	aaaÃÂ¥bbb	aaaaÃÂ¥bbbb	8	12
2	aaaÂ¥bbb	aaaaÂ¥bbbb	7	10
3	aaaÂ¥bbb	aaaaÂ¥bbbb	7	10
utf8 connection ?	length('?')
?	1
latin1 connection ?	length('?')
?	1
Conclusion: '\xA5' this byte is not recongnizable and "utf8 connection ?" has length 1.

docker-compose exec server bash -c "mysql --default-character-set=utf8mb4 -pdemo mysql < /sql/query-utf8.sql"
mysql: [Warning] Using a password on the command line interface can be insecure.
id	col1	col2	length(col1)	length(col2)
1	aaaÃÂ¥bbb	aaaaÃÂ¥bbbb	8	12
2	aaaÂ¥bbb	aaaaÂ¥bbbb	7	10
3	aaaÂ¥bbb	aaaaÂ¥bbbb	7	10
utf8 connection Â¥	length('Â¥')
Â¥	2
latin1 connection Â¥	length('Â¥')
Â¥	1

c. length() and character_set_connection with utf8 terminal
Set Terminal > Preferences > Unnamed > Compatibility > Encoding: Unicode - UTF-8
docker-compose exec server bash -c "mysql --default-character-set=latin1 -pdemo mysql < /sql/query-latin1.sql"
mysql: [Warning] Using a password on the command line interface can be insecure.
id	col1	col2	length(col1)	length(col2)
1	aaa¥bbb	aaaa¥bbbb	8	12
2	aaa�bbb	aaaa�bbbb	7	10
3	aaa�bbb	aaaa�bbbb	7	10
utf8 connection �	length('�')
�	2
latin1 connection �	length('�')
�	1

docker-compose exec server bash -c "mysql --default-character-set=latin1 -pdemo mysql < /sql/query-utf8.sql"
mysql: [Warning] Using a password on the command line interface can be insecure.
id	col1	col2	length(col1)	length(col2)
1	aaa¥bbb	aaaa¥bbbb	8	12
2	aaa�bbb	aaaa�bbbb	7	10
3	aaa�bbb	aaaa�bbbb	7	10
utf8 connection ¥	length('¥')
¥	4
latin1 connection ¥	length('¥')
¥	2

docker-compose exec server bash -c "mysql --default-character-set=utf8mb4 -pdemo mysql < /sql/query-latin1.sql"
mysql: [Warning] Using a password on the command line interface can be insecure.
id	col1	col2	length(col1)	length(col2)
1	aaaÂ¥bbb	aaaaÂ¥bbbb	8	12
2	aaa¥bbb	aaaa¥bbbb	7	10
3	aaa¥bbb	aaaa¥bbbb	7	10
utf8 connection ?	length('?')
?	1
latin1 connection ?	length('?')
?	1

docker-compose exec server bash -c "mysql --default-character-set=utf8mb4 -pdemo mysql < /sql/query-utf8.sql"
mysql: [Warning] Using a password on the command line interface can be insecure.
id	col1	col2	length(col1)	length(col2)
1	aaaÂ¥bbb	aaaaÂ¥bbbb	8	12
2	aaa¥bbb	aaaa¥bbbb	7	10
3	aaa¥bbb	aaaa¥bbbb	7	10
utf8 connection ¥	length('¥')
¥	2
latin1 connection ¥	length('¥')
¥	1

c. character_set_connection and table column filter
Set Terminal > Preferences > Unnamed > Compatibility > Encoding: Unicode - UTF-8

docker-compose exec server bash -c "mysql --default-character-set=utf8mb4 -pdemo mysql < /sql/query-utf8.sql"
character_set_connection='utf8'	INSTR(col1, '¥')	INSTR(col2, '¥')
character_set_connection='utf8'	5	6
character_set_connection='utf8'	4	5
character_set_connection='utf8'	4	5
character_set_connection=latin1	INSTR(col1, '¥')	INSTR(col2, '¥')
character_set_connection=latin1	5	6
character_set_connection=latin1	4	5
character_set_connection=latin1	4	5

docker-compose exec server bash -c "mysql --default-character-set=utf8mb4 -pdemo mysql < /sql/query-latin1.sql"
character_set_connection='utf8'	INSTR(col1, '?')	INSTR(col2, '?')
character_set_connection='utf8'	0	0
character_set_connection='utf8'	0	0
character_set_connection='utf8'	0	0
character_set_connection=latin1	INSTR(col1, '?')	INSTR(col2, '?')
character_set_connection=latin1	0	0
character_set_connection=latin1	0	0
character_set_connection=latin1	0	0

docker-compose exec server bash -c "mysql --default-character-set=latin1 -pdemo mysql < /sql/query-utf8.sql"
character_set_connection='utf8'	INSTR(col1, '¥')	INSTR(col2, '¥')
character_set_connection='utf8'	4	5
character_set_connection='utf8'	3	0
character_set_connection='utf8'	3	0
character_set_connection=latin1	INSTR(col1, '¥')	INSTR(col2, '¥')
character_set_connection=latin1	4	5
character_set_connection=latin1	3	0
character_set_connection=latin1	3	0

docker-compose exec server bash -c "mysql --default-character-set=latin1 -pdemo mysql < /sql/query-latin1.sql"
character_set_connection='utf8'	INSTR(col1, '�')	INSTR(col2, '�')
character_set_connection='utf8'	5	6
character_set_connection='utf8'	4	5
character_set_connection='utf8'	4	5
character_set_connection=latin1	INSTR(col1, '�')	INSTR(col2, '�')
character_set_connection=latin1	5	6
character_set_connection=latin1	4	5
character_set_connection=latin1	4	5

d. MySQL Character Set Introducers
Set Terminal > Preferences > Unnamed > Compatibility > Encoding: Unicode - UTF-8
docker-compose exec server bash -c "mysql --default-character-set=utf8mb4 -pdemo mysql < /sql/query-utf8.sql"
latin1 connection	length(_utf8'¥')
latin1 connection	2
utf8 connection	length(_utf8'¥')
utf8 connection	2

docker-compose exec server bash -c "mysql --default-character-set=utf8mb4 -pdemo mysql < /sql/query-latin1.sql"
latin1 connection	length(_utf8'?')
latin1 connection	1
utf8 connection	length(_utf8'?')
utf8 connection	1

docker-compose exec server bash -c "mysql --default-character-set=latin1 -pdemo mysql < /sql/query-utf8.sql"
latin1 connection	length(_utf8'¥')
latin1 connection	2
utf8 connection	length(_utf8'¥')
utf8 connection	2

docker-compose exec server bash -c "mysql --default-character-set=latin1 -pdemo mysql < /sql/query-latin1.sql"
latin1 connection	length(_utf8'�')
latin1 connection	1
utf8 connection	length(_utf8'�')
utf8 connection	1

Conclusion: Character Set Introducer has higher priority than character_set_connection. The String literal doesn't convert to character_set_connection. The String literal doesn't convert to Character Set Introducer either. It just keeps its byte value. The MySQL parser tries to convert the raw bytes into Character Set Introducer.

## character set and its binary value
select CONVERT('a' using utf8) = CONVERT('a' using latin1);
select CONVERT('¥' using utf8) = CONVERT('¥' using latin1);
Set Terminal > Preferences > Unnamed > Compatibility > Encoding: Western - ISO-8859-1

docker-compose exec server bash -c "mysql --default-character-set=latin1 -pdemo mysql < /sql/query-latin1.sql"
HEX(BINARY CONVERT('¥' using utf8))	HEX(BINARY CONVERT('¥' using latin1))	CONVERT('¥' using utf8) = CONVERT('¥' using latin1)	BINARY CONVERT('¥' using utf8) = BINARY CONVERT('¥' using latin1)
C2A5	A5	1	0

docker-compose exec server bash -c "mysql --default-character-set=utf8mb4 -pdemo mysql < /sql/query-latin1.sql"
HEX(BINARY CONVERT('?' using utf8))	HEX(BINARY CONVERT('?' using latin1))	CONVERT('?' using utf8) = CONVERT('?' using latin1)	BINARY CONVERT('?' using utf8) = BINARY CONVERT('?' using latin1)
3F	3F	1	1

docker-compose exec server bash -c "mysql --default-character-set=utf8mb4 -pdemo mysql < /sql/query-utf8.sql"
HEX(BINARY CONVERT('Â¥' using utf8))	HEX(BINARY CONVERT('Â¥' using latin1))	CONVERT('Â¥' using utf8) = CONVERT('Â¥' using latin1)	BINARY CONVERT('Â¥' using utf8) = BINARY CONVERT('Â¥' using latin1)
C2A5	A5	1	0

docker-compose exec server bash -c "mysql --default-character-set=latin1 -pdemo mysql < /sql/query-utf8.sql"
HEX(BINARY CONVERT('Â¥' using utf8))	HEX(BINARY CONVERT('Â¥' using latin1))	CONVERT('Â¥' using utf8) = CONVERT('Â¥' using latin1)	BINARY CONVERT('Â¥' using utf8) = BINARY CONVERT('Â¥' using latin1)
C382C2A5	C2A5	1	0

Conclusion: 
Each MySQL string belongs to a character set;
Strings in different character set can be equal as long as they are the same character sequence;
BINARY() and HEX() can be used to view a MySQL string in binary mode.

## Encoding conversions from MySQL CLI to MySQL server
Terminal Encoding Settings -> character_set_client -> character_set_connection -> The internal operation character set -> character_set_results

