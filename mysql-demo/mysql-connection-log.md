## Successful Connection log from MySQL CLI
docker-compose exec server bash -c "tail -f /var/log/mysql.general.log /var/log/mysqld.log"
docker-compose exec client mysql -pdemo -h server
2018-12-27T11:07:19.431815Z	   31 Connect	root@172.30.0.3 on  using SSL/TLS
2018-12-27T11:07:19.439901Z	   31 Query	select @@version_comment limit 1

## Successful Connection log from MySQL Workbench 8.0
docker-compose exec server bash -c "tail -f /var/log/mysql.general.log /var/log/mysqld.log"
2018-12-27T07:40:52.013881Z	   16 Connect	root@<xxx> on  using SSL/TLS
2018-12-27T07:40:52.014804Z	   16 Query	set autocommit=1
2018-12-27T07:40:52.015654Z	   16 Query	SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ
2018-12-27T07:40:52.016588Z	   16 Query	SHOW SESSION VARIABLES LIKE 'lower_case_table_names'
2018-12-27T07:40:52.019857Z	   16 Query	SELECT current_user()
2018-12-27T07:40:52.020448Z	   16 Query	SET CHARACTER SET utf8
2018-12-27T07:40:52.021011Z	   16 Query	SET NAMES utf8
2018-12-27T07:40:52.021406Z	   16 Query	SET SQL_SAFE_UPDATES=1
2018-12-27T07:40:52.021819Z	   16 Query	SELECT CONNECTION_ID()
2018-12-27T07:40:52.022289Z	   16 Query	set character_set_client = utf8mb4
2018-12-27T07:40:52.022885Z	   16 Query	set character_set_connection = utf8mb4
2018-12-27T07:40:52.023351Z	   16 Query	set character_set_results = utf8mb4
2018-12-27T07:40:52.023955Z	   16 Query	SHOW SESSION STATUS LIKE 'Ssl_cipher'
2018-12-27T07:40:52.027344Z	   16 Query	set autocommit=1
2018-12-27T07:40:52.035376Z	   16 Query	use mysql
2018-12-27T07:40:52.035878Z	   16 Query	SELECT DATABASE()
2018-12-27T07:40:52.044675Z	   16 Query	show tables

## Connection failure without password from host which has config in user table: ERROR 1045
docker-compose exec server bash -c "tail -f /var/log/mysql.general.log /var/log/mysqld.log"
docker-compose exec client mysql -h server
ERROR 1045 (28000): Access denied for user 'root'@'mysql-demo_client_1.mysql-demo_mysql' (using password: NO)
==> /var/log/mysql.general.log <==
2018-12-30T10:56:32.657093Z	  115 Connect	root@mysql-demo_client_1.mysql-demo_mysql on  using SSL/TLS
2018-12-30T10:56:32.657215Z	  115 Connect	Access denied for user 'root'@'mysql-demo_client_1.mysql-demo_mysql' (using password: NO)

==> /var/log/mysqld.log <==
2018-12-30T10:56:32.657241Z 115 [Note] [MY-010926] [Server] Access denied for user 'root'@'mysql-demo_client_1.mysql-demo_mysql' (using password: NO)

## Connection failure without password from a unknown user and a host which has config in user table: ERROR 1045
docker-compose exec server bash -c "tail -f /var/log/mysql.general.log /var/log/mysqld.log"
docker-compose exec client mysql -h server -u newuser
ERROR 1045 (28000): Access denied for user 'newuser'@'mysql-demo_client_1.mysql-demo_mysql' (using password: NO)

==> /var/log/mysql.general.log <==
2018-12-30T11:03:32.184678Z	  131 Connect	newuser@mysql-demo_client_1.mysql-demo_mysql on  using SSL/TLS
2018-12-30T11:03:32.184772Z	  131 Connect	Access denied for user 'newuser'@'mysql-demo_client_1.mysql-demo_mysql' (using password: NO)

==> /var/log/mysqld.log <==
2018-12-30T11:03:32.184793Z 131 [Note] [MY-010926] [Server] Access denied for user 'newuser'@'mysql-demo_client_1.mysql-demo_mysql' (using password: NO)

## Connection failure from host which has no config in user table: Error Code: 1130
docker-compose exec server bash -c "tail -f /var/log/mysql.general.log /var/log/mysqld.log"
docker-compose exec client2 mysql -h server
ERROR 1130 (HY000): Host 'mysql-demo_client2_1.mysql-demo_mysql' is not allowed to connect to this MySQL server

No log is written to /var/log/mysql.general.log or /var/log/mysqld.log.

## Conclusion: "ERROR 1045 (28000)" vs "Error Code: 1130"
"ERROR 1045 (28000)" is written to error log, but "Error Code: 1130" is not.
"ERROR 1045" is for connection from host in user table, and "ERROR 1130" is for host not in user table.
