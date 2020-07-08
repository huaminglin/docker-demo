PGPASSWORD=123456 psql -U pgdemo -h server -f /sql/deadlock.sql pgdemo &
PGPASSWORD=123456 psql -U pgdemo -h server -f /sql/deadlock-2.sql pgdemo &

echo sleep 10 seconds ...
sleep 10
