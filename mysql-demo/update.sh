#!/usr/bin/env bash

cd $(dirname $0)

docker-compose down
docker-compose up --no-start
docker-compose start

docker-compose exec server bash -c "touch /var/log/mysql.general.log; chown mysql:mysql /var/log/mysql.general.log"
# It seems that the above command is executed before mysql daemon starts and the general log is ON without restart server.

echo sleep 15 seconds
sleep 15

docker-compose exec server mysql -pdemo mysql -e "CREATE USER 'root'@'172.%' IDENTIFIED BY 'demo';GRANT ALL PRIVILEGES ON *.* TO 'root'@'172.%';FLUSH PRIVILEGES;"
docker-compose exec server mysql -pdemo mysql -e "show variables like \"%general%\""
