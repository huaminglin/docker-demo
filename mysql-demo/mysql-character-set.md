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
docker-compose exec server mysql -pdemo mysql -e "CREATE TABLE t1(col1 VARCHAR(100)  CHARACTER SET latin1 COLLATE latin1_german1_ci, col2 VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci) ENGINE = MYISAM;"

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
chmod 777 /tmp/t1.MYD 

hexdump /tmp/t1.MYD
0000000 0003 0014 07fc 6161 a561 6262 0a62 6161
0000010 6161 a5c2 6262 6262                    
0000018

od -tx1 /tmp/t1.MYD
0000000 03 00 14 00 fc 07 61 61 61 a5 62 62 62 0a 61 61
0000020 61 61 c2 a5 62 62 62 62
0000030

Open chmod 777 /tmp/t1.MYD  with VSCode

