## redis-cli
docker-compose exec client bash
redis-cli -h master info
redis-cli -h slave info

redis-cli -h master hset login key value
redis-cli -h slave  hget login key

redis-cli -h slave hset login key value2
(error) READONLY You can't write against a read only replica.

redis-cli -h master INFO replication
redis-cli -h master ROLE

redis-cli -h slave INFO replication
redis-cli -h slave ROLE
