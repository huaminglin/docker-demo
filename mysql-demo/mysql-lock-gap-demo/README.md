# MySQL gap lock demo

## Delete from an empty table: (-infinite, +infinite)

docker exec -it mysql-lock-gap-demo_client_1 /sql/delete-empty.sh

```
sql 2: sleep 1 seconds ...
sql 2: sleep 1 seconds ...
sql1: delete from mytab
sql1: delete from mytab
sql 1: sleep 5 seconds ...
sql 1: sleep 5 seconds ...
sql 2   sleep(1)
sql 2   0
sql 2: insert into mytab(id, value) values(1, 100)
sql 2: insert into mytab(id, value) values(1, 100)
sql 1   sleep(5)
sql 1   0
sql 1: commit
sql 1: commit
sql 2: commit
sql 2: commit
```

When the transaction 1 (running delete) doesn't commit, the transaction 2 (running insert) waits.
The lock range is (-infinite, +infinite).

The lock is on the cluster index.
