
## Server SSL configuration
have_ssl
docker-compose exec server mysql -pdemo mysql -e "show variables like \"%ssl%\""
mysql: [Warning] Using a password on the command line interface can be insecure.
+--------------------+-----------------+
| Variable_name      | Value           |
+--------------------+-----------------+
| have_openssl       | YES             |
| have_ssl           | YES             |
| mysqlx_ssl_ca      |                 |
| mysqlx_ssl_capath  |                 |
| mysqlx_ssl_cert    |                 |
| mysqlx_ssl_cipher  |                 |
| mysqlx_ssl_crl     |                 |
| mysqlx_ssl_crlpath |                 |
| mysqlx_ssl_key     |                 |
| ssl_ca             | ca.pem          |
| ssl_capath         |                 |
| ssl_cert           | server-cert.pem |
| ssl_cipher         |                 |
| ssl_crl            |                 |
| ssl_crlpath        |                 |
| ssl_fips_mode      | OFF             |
| ssl_key            | server-key.pem  |
+--------------------+-----------------+

require_secure_transport
docker-compose exec server mysql -pdemo mysql -e "show variables like \"%secure%\""
mysql: [Warning] Using a password on the command line interface can be insecure.
+--------------------------+-----------------------+
| Variable_name            | Value                 |
+--------------------------+-----------------------+
| require_secure_transport | OFF                   |
| secure_file_priv         | /var/lib/mysql-files/ |
+--------------------------+-----------------------+

## Connection status from localhost
docker-compose exec server mysql -pdemo mysql -e "status"
mysql: [Warning] Using a password on the command line interface can be insecure.
--------------
mysql  Ver 8.0.13 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:		45
Current database:	mysql
Current user:		root@localhost
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		8.0.13 MySQL Community Server - GPL
Protocol version:	10
Connection:		Localhost via UNIX socket
Server characterset:	utf8
Db     characterset:	utf8
Client characterset:	latin1
Conn.  characterset:	latin1
UNIX socket:		/var/lib/mysql/mysql.sock
Uptime:			13 min 29 sec

Threads: 2  Questions: 100  Slow queries: 0  Opens: 141  Flush tables: 2  Open tables: 117  Queries per second avg: 0.123

## Connection status from another host (Use SSL by default)
docker-compose exec client mysql -pdemo -h server mysql -e "status"
mysql: [Warning] Using a password on the command line interface can be insecure.
--------------
mysql  Ver 8.0.13 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:		39
Current database:	mysql
Current user:		root@172.21.0.3
SSL:			Cipher in use is DHE-RSA-AES128-GCM-SHA256
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		8.0.13 MySQL Community Server - GPL
Protocol version:	10
Connection:		server via TCP/IP
Server characterset:	utf8
Db     characterset:	utf8
Client characterset:	latin1
Conn.  characterset:	latin1
TCP port:		3306
Uptime:			11 min 51 sec

Threads: 2  Questions: 82  Slow queries: 0  Opens: 141  Flush tables: 2  Open tables: 117  Queries per second avg: 0.115
--------------

## Connection status from another host (Disable SSL)
docker-compose exec client mysql -pdemo -h server --ssl-mode=DISABLED  mysql -e "status"
mysql: [Warning] Using a password on the command line interface can be insecure.
--------------
mysql  Ver 8.0.13 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:		54
Current database:	mysql
Current user:		root@172.21.0.3
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		8.0.13 MySQL Community Server - GPL
Protocol version:	10
Connection:		server via TCP/IP
Server characterset:	utf8
Db     characterset:	utf8
Client characterset:	latin1
Conn.  characterset:	latin1
TCP port:		3306
Uptime:			17 min 25 sec

Threads: 2  Questions: 124  Slow queries: 0  Opens: 141  Flush tables: 2  Open tables: 117  Queries per second avg: 0.118
--------------
