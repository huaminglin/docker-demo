#!/usr/bin/env bash

cd $(dirname $0)

docker-compose down
docker-compose up --no-start
docker-compose start

docker-compose exec server bash -c "touch /var/log/mysql.general.log; chown mysql:mysql /var/log/mysql.general.log"
# It seems that the above command is executed before mysql daemon starts and the general log is ON without restart server.

echo sleep 20 seconds
sleep 20

docker-compose exec server mysql -pdemo mysql -e "CREATE USER 'root'@'mysql-demo_client_1%' IDENTIFIED BY 'demo';"

docker-compose exec server mysql -pdemo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'mysql-demo_client_1%';FLUSH PRIVILEGES;"
docker-compose exec server mysql -pdemo mysql -e "show variables like \"%general%\""
