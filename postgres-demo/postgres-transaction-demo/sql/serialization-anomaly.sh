PGPASSWORD=123456 psql -U pgdemo -h server -f /sql/serialization-anomaly-1.sql pgdemo &
PGPASSWORD=123456 psql -U pgdemo -h server -f /sql/serialization-anomaly-2.sql pgdemo &

echo sleep 10 seconds ...
sleep 10
