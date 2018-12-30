## MySQL and DNS
docker-compose exec server mysql -pdemo mysql -e "show variables like \"%host%\"" 
mysql: [Warning] Using a password on the command line interface can be insecure.
+-------------------------------+--------------+
| Variable_name                 | Value        |
+-------------------------------+--------------+
| host_cache_size               | 279          |
| hostname                      | 37e2d8ee3098 |
| performance_schema_hosts_size | -1           |
| report_host                   |              |
+-------------------------------+--------------+

docker-compose exec server mysql -pdemo mysql -e "show variables like \"%resolve%\"" 
mysql: [Warning] Using a password on the command line interface can be insecure.
+-------------------+-------+
| Variable_name     | Value |
+-------------------+-------+
| skip_name_resolve | ON    |
+-------------------+-------+

Note: skip_name_resolve is on by default for mysql/mysql-server:8.0 image.

## MySQL: remove skip_name_resolve and skip-host-cache from my-log.cnf
docker-compose exec client mysql -h server -pdemo mysql -e "show tables"

docker-compose exec server mysql -pdemo performance_schema -e "select IP, HOST from host_cache"
mysql: [Warning] Using a password on the command line interface can be insecure.
+------------+--------------------------------------+
| IP         | HOST                                 |
+------------+--------------------------------------+
| 172.30.0.4 | mysql-demo_client_1.mysql-demo_mysql |
+------------+--------------------------------------+

docker-compose exec server mysql -pdemo performance_schema -e "select * from hosts"
mysql: [Warning] Using a password on the command line interface can be insecure.
+--------------------------------------+---------------------+-------------------+
| HOST                                 | CURRENT_CONNECTIONS | TOTAL_CONNECTIONS |
+--------------------------------------+---------------------+-------------------+
| NULL                                 |                  41 |                46 |
| localhost                            |                   1 |                11 |
| mysql-demo_client_1.mysql-demo_mysql |                   0 |                 2 |
+--------------------------------------+---------------------+-------------------+
