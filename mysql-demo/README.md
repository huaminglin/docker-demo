## my.cnf
docker-compose exec server bash
find / -iname "*.cnf"
/var/lib/mysql/auto.cnf
/etc/pki/tls/openssl.cnf
/etc/my.cnf
/healthcheck.cnf

docker cp mysql-demo_server_1:/etc/my.cnf /tmp

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

