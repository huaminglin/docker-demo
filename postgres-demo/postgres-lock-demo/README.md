# Demo PostgreSQL Lock

## select for update

sudo docker exec postgres-lock-demo_client_1 bash -c /sql/select_for_update.sh

Conclusion:

"SELECT FOR UPDATE" doesn't block normal select

"SELECT FOR UPDATE" doesn't block "SELECT FOR UPDATE" on different row

"SELECT FOR UPDATE" does block "SELECT FOR UPDATE" on the same row
