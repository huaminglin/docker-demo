## redis-cli
docker-compose exec client bash
redis-cli -h server info

## Check keys when the server starts for the first time
redis-cli -h server keys "*"
(empty list or set)

## Set a hset
docker-compose exec client bash
a. Save a data
redis-cli -h server hset set1 item1 value1
redis-cli -h server keys "*"
1) "set1"

b. Restart and check whether the old data is still there
docker-compose stop
docker-compose start
docker-compose exec client bash
redis-cli -h server keys "*"
1) "set1"

c. Check server for the persistence data file
docker-compose exec server bash
find / -iname "*.rdb"
/data/dump.rdb

Conclusion: By default Redis asynchronously dumps the dataset on disk.
