PGPASSWORD=123456 psql -U pgdemo -h server -f /sql/select_for_option-1.sql pgdemo &
PGPASSWORD=123456 psql -U pgdemo -h server -f /sql/select_for_option-2.sql pgdemo &
PGPASSWORD=123456 psql -U pgdemo -h server -f /sql/select_for_option-3.sql pgdemo &
PGPASSWORD=123456 psql -U pgdemo -h server -f /sql/select_for_option-4.sql pgdemo &

echo sleep 10 seconds ...
sleep 10
