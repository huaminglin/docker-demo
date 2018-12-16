Default save points are:
ave 900 1
save 300 10
save 60 10000

Add a new save point: "--save", "10", "1"

## redis-cli
docker-compose exec server bash
redis-cli hset set1 item1 value1
redis-cli keys "*"
1) "set1"

b. Restart and check whether the old data is still there
docker-compose stop
docker-compose start
docker-compose exec server bash
redis-cli keys "*"
1) "set1"

c. Check server for the persistence data file
docker-compose exec server bash
find / -iname "*.rdb"
/data/dump.rdb

find / -iname "*.aof"
/data/appendonly.aof

Conclusion: By default Redis asynchronously dumps the dataset on disk.

## redis-cli INFO|grep rdb
rdb_changes_since_last_save:4
rdb_bgsave_in_progress:0
rdb_last_save_time:1544958750
rdb_last_bgsave_status:ok
rdb_last_bgsave_time_sec:-1
rdb_current_bgsave_time_sec:-1
rdb_last_cow_size:0

## redis-cli INFO|grep aof
mem_aof_buffer:140
aof_enabled:1
aof_rewrite_in_progress:0
aof_rewrite_scheduled:0
aof_last_rewrite_time_sec:-1
aof_current_rewrite_time_sec:-1
aof_last_bgrewrite_status:ok
aof_last_write_status:ok
aof_last_cow_size:0
aof_current_size:234
aof_base_size:70
aof_pending_rewrite:0
aof_buffer_length:0
aof_rewrite_buffer_length:0
aof_pending_bio_fsync:0
aof_delayed_fsync:0
