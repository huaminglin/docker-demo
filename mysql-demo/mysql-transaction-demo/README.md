# Demo what is transaction in MySQL

## now() call in one transaction doesn't always returns the same value (Different with PostgreSQL)

docker exec -it mysql-transaction-demo_client_1 /sql/now.sh

## "1/0" return null in MySQL (PostgreSQL treat it as an error)

docker exec -it mysql-transaction-demo_client_1 /sql/error.sh

"ERROR 1054 (42S22)" aborts the sql execution.

## MVCC update: read and write

A transaction doesn't read the uncommitted data from another transaction.
A writing transaction doesn't block a reading transaction.

docker exec -it mysql-transaction-demo_client_1 /sql/read-isolation.sh

## MVCC update: write and write

A writing transaction blocks another writing transaction.

docker exec -it mysql-transaction-demo_client_1 /sql/write-isolation.sh

write-isolation.log
```
sql 2   now()   id      value
sql 2   2021-04-08 09:55:50     1       100
sql 2: commit
sql 2: commit
sql 2   now()   id      value
sql 2   2021-04-08 09:55:50     1       99
```

Issue 1:
The "sql 2   2021-04-08 09:55:50     1       100" is very weird.
Still have no idea where does 100 come from.

Issue 2: write loss issue
The two transactions decrease the value of id 1 at the same time. The result is 99, which means someone lose its write.
Maybe "select 'sql 1', @amount := value from mywrite where id=1 for update;" can handle it.

## MVCC update: Read Committed Isolation Level(Nonrepeatable Read)

docker exec -it mysql-transaction-demo_client_1 /sql/non-repeatable-read.sh

In the second txn, "select * from t_isolation where id=0" return different values.

By default, PostgreSQL uses "Read Committed Isolation Level".
Dirty Read is not possible, but Nonrepeatable Read is possible.

## MVCC update: Read Committed Isolation Level(Phantom Read)

docker exec -it mysql-transaction-demo_client_1 /sql/phantom-read.sh

Phantom read is not possible in the default isolation level.

Phantom read happens at the "ISOLATION LEVEL READ COMMITTED".

## MVCC update: Repeatable Read Isolation Level(serialization failures)

docker exec -it mysql-transaction-demo_client_1 /sql/serialization-failure.sh

"could not serialize access due to concurrent update" doesn't happen for MySQL, which is different from PostgreSQL.


## MVCC update: Repeatable Read Isolation Level(serialization failures)(Two transactions update a same row)

docker exec -it mysql-transaction-demo_client_1 /sql/serialization-failure-concurrency.sh

The two sql files have no select on t_isolation, so the block comes from the udpate statement.

The second transaction is blocked until the first transaction commit/abort its update.

"could not serialize access due to concurrent update" doesn't happen for MySQL, which is different from PostgreSQL.

## serialization anomaly

docker exec -it mysql-transaction-demo_client_1 /sql/serialization-anomaly.sh

"ERROR:  could not serialize access due to read/write dependencies among transactions"

"serialization anomaly" doesn't happen for MySQL.
