# Demo what is transaction in PostgreSQL

## now() call in one transaction always returns the same value

now.sql
now.log


## How to fix postgres error: current transaction is aborted, commands ignored until end of transaction block

By executing that wrong SQL-statement, postgreSQL will not terminate the execution by itself so you need to rollback manually.

error.sql
error.log

## MVCC update: read and write

A transaction doesn't read the uncommitted data from another transaction.
A writing transaction doesn't block a reading transaction.

sudo docker exec postgres-transaction-demo_client_1 bash -c /sql/read-isolation.sh

## MVCC update: write and write

A writing transaction blocks another writing transaction.

sudo docker exec postgres-transaction-demo_client_1 bash -c /sql/write-isolation.sh
