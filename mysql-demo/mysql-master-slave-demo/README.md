# mysql-master-slave-demo

## Setup user 'root'@'%'

sudo docker-compose exec master mysql -ppassword mysql -e "CREATE USER 'root'@'%' IDENTIFIED BY 'password';"
sudo docker-compose exec master mysql -ppassword mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';FLUSH PRIVILEGES;"


sudo docker-compose exec master mysql -ppassword mysql -e "CREATE USER 'root'@'localhost' IDENTIFIED BY 'password';"
sudo docker-compose exec master mysql -ppassword mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost';FLUSH PRIVILEGES;"


sudo docker-compose exec slave mysql -ppassword mysql -e "CREATE USER 'root'@'%' IDENTIFIED BY 'password';"
sudo docker-compose exec slave mysql -ppassword mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';FLUSH PRIVILEGES;"

## mysql-master-slave-demo_master_1

docker exec -it mysql-master-slave-demo_master_1 mysql -u root -ppassword

show databases;

use test;

show tables;

create table mytab(id int, value int);

GRANT ALL PRIVILEGES ON test.* TO 'root'@'%';

## mysql-master-slave-demo_slave_1

sudo docker exec -it mysql-master-slave-demo_slave_1 mysql -e 'show slave status\G'

The expected Slave_IO_State should be Waiting for master to send event.

sudo docker exec -it mysql-master-slave-demo_slave_1 mysql -u root -ppassword


## Connection from slave to master

docker exec -it mysql-master-slave-demo_slave_1 mysql -h master -u root -ppassword

##

STOP SLAVE;

mysql> START SLAVE;
ERROR 1200 (HY000): The server is not configured as slave; fix in config file or with CHANGE MASTER TO
