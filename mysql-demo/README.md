## my.cnf
docker-compose exec server bash
find / -iname "*.cnf"
/var/lib/mysql/auto.cnf
/etc/pki/tls/openssl.cnf
/etc/my.cnf
/healthcheck.cnf

docker cp mysql-demo_server_1:/etc/my.cnf /tmp

docker-compose exec server bash -c "mysqld --verbose --help > /sql/mysqld.help"

docker-compose exec server bash -c "mysqladmin -pdemo variables > /sql/mysqladmin.variables"
