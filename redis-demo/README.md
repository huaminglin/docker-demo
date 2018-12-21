## redis-cli
docker-compose exec client bash
redis-cli -h server info

## Check keys when the server starts for the first time
redis-cli -h server keys "*"
(empty list or set)

## Set a hset
a. Save a data
docker-compose exec client bash
redis-cli -h server hset set1 item1 value1
redis-cli -h server keys "*"
1) "set1"

b. Check the data is saved to disk after 90 seconds
docker-compose exec server bash
(1) check for the first time
date
Mon Dec 17 05:10:20 UTC 2018
root@935369f9133f:/data# redis-cli info | grep rdb
rdb_changes_since_last_save:1
rdb_bgsave_in_progress:0
rdb_last_save_time:1545023141
rdb_last_bgsave_status:ok
rdb_last_bgsave_time_sec:-1
rdb_current_bgsave_time_sec:-1
rdb_last_cow_size:0
find / -iname "*.rdb"
(2) check /data/dump.rdb creation time
ls -al /data/dump.rdb
-rw-r--r-- 1 redis redis 130 Dec 17 06:05 /data/dump.rdb
GMT: Monday, December 17, 2018 5:05:41 AM

c. Restart and check whether the old data is still there
docker-compose stop
docker-compose start
docker-compose exec client bash
redis-cli -h server keys "*"
1) "set1"

Conclusion: By default Redis asynchronously dumps the dataset on disk.
