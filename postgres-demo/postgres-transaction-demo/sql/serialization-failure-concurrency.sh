echo -e "truncate t_isolation; \n insert into t_isolation values (0, 'name0')" | PGPASSWORD=123456 psql -U pgdemo -h server
PGPASSWORD=123456 psql -U pgdemo -h server -f /sql/serialization-failure-concurrency-1.sql pgdemo &
PGPASSWORD=123456 psql -U pgdemo -h server -f /sql/serialization-failure-concurrency-2.sql pgdemo &

echo sleep 20 seconds ...
sleep 20

