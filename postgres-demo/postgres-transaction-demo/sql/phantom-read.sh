echo -e "truncate t_isolation; \n insert into t_isolation values (0, 'name0')" | PGPASSWORD=123456 psql -U pgdemo -h server
PGPASSWORD=123456 psql -U pgdemo -h server -f /sql/phantom-read-1.sql pgdemo &
PGPASSWORD=123456 psql -U pgdemo -h server -f /sql/phantom-read-2.sql pgdemo &

echo sleep 10 seconds ...
sleep 10

