## redis-cli
docker-compose exec client bash
redis-cli -h master info
redis-cli -h slave info

redis-cli -h master hset login key value
redis-cli -h slave  hget login key
