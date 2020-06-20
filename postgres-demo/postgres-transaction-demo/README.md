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

## MVCC update: Read Committed Isolation Level(Nonrepeatable Read)

sudo docker exec postgres-transaction-demo_client_1 bash -c /sql/non-repeatable-read.sh

In the second txn, "select * from t_isolation where id=0" return different values.

By default, PostgreSQL uses "Read Committed Isolation Level".
Dirty Read is not possible, but Nonrepeatable Read is possible.

## MVCC update: Read Committed Isolation Level(Phantom Read)

sudo docker exec postgres-transaction-demo_client_1 bash -c /sql/phantom-read.sh

## MVCC update: Repeatable Read Isolation Level(serialization failures)

sudo docker exec postgres-transaction-demo_client_1 bash -c /sql/serialization-failure.sh

The repeated reads keep the same during the second transaction.
"could not serialize access due to concurrent update" when the second txn tries to update a row which is updated(and committed) during the second txn.

Conclusion:
Repeatable Read Isolation Level works like a "Optimistic Locking", which detects the conflict as late as possible.
The "version" is got when a transaction is started for Repeatable Read Isolation Level.
