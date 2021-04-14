# MySQL gap lock demo

## Delete from an empty table: (-infinite, +infinite)

docker exec -it mysql-lock-gap-demo_client_1 /sql/delete-empty.sh


"delete from mytab;":
```
sql 2: sleep 1 seconds ...
sql 2: sleep 1 seconds ...
sql1: delete from mytab
sql1: delete from mytab
sql 1: sleep 5 seconds ...
sql 1: sleep 5 seconds ...
sql 2   sleep(1)
sql 2   0
ENGINE  ENGINE_LOCK_ID  ENGINE_TRANSACTION_ID   THREAD_ID       EVENT_ID        OBJECT_SCHEMA   OBJECT_NAME     PARTITION_NAME  SUBPARTITION_NAME       INDEX_NAME      OBJECT_INSTANCE_BEGIN   LOCK_TYPE       LOCK_MODE       LOCK_STATUS     LOCK_DATA
INNODB  139982241004952:1069:139982245279888    2237    64      5       demo    mytab   NULL    NULL    NULL    139982245279888 TABLE   IX      GRANTED NULL
INNODB  139982241004952:8:4:1:139982245276976   2237    64      5       demo    mytab   NULL    NULL    GEN_CLUST_INDEX 139982245276976 RECORD  X       GRANTED supremum pseudo-record
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

"delete from mytab where value > 20"

```
sql 2: sleep 1 seconds ...
sql 2: sleep 1 seconds ...
sql1: delete from mytab where value > 20
sql1: delete from mytab where value > 20
sql 1: sleep 5 seconds ...
sql 1: sleep 5 seconds ...
sql 2   sleep(1)
sql 2   0
ENGINE  ENGINE_LOCK_ID  ENGINE_TRANSACTION_ID   THREAD_ID       EVENT_ID        OBJECT_SCHEMA   OBJECT_NAME     PARTITION_NAME  SUBPARTITION_NAME       INDEX_NAME      OBJECT_INSTANCE_BEGIN   LOCK_TYPE       LOCK_MODE       LOCK_STATUS     LOCK_DATA
INNODB  139982241004952:1072:139982245279888    2297    73      5       demo    mytab   NULL    NULL    NULL    139982245279888 TABLE   IX      GRANTED NULL
INNODB  139982241004952:11:5:1:139982245276976  2297    73      5       demo    mytab   NULL    NULL    mytable_value_index     139982245276976 RECORD  X       GRANTED supremum pseudo-record
sql 2: insert into mytab(id, value) values(5, 19)
sql 2: insert into mytab(id, value) values(5, 19)
sql 1   sleep(5)
sql 1   0
sql 1: commit
sql 1: commit
sql 2: commit
sql 2: commit
```

## Update an existing item

docker exec -it mysql-lock-gap-demo_client_1 /sql/update-item.sh

```
sql 2: sleep 1 seconds ...
sql 2: sleep 1 seconds ...
sql1: UPDATE mytab set value = value + 1 WHERE value > 20
sql1: UPDATE mytab set value = value + 1 WHERE value > 20
sql 1: sleep 5 seconds ...
sql 1: sleep 5 seconds ...
sql 2   sleep(1)
sql 2   0
ENGINE  ENGINE_LOCK_ID  ENGINE_TRANSACTION_ID   THREAD_ID       EVENT_ID        OBJECT_SCHEMA   OBJECT_NAME     PARTITION_NAME  SUBPARTITION_NAME       INDEX_NAME      OBJECT_INSTANCE_BEGIN   LOCK_TYPE       LOCK_MODE       LOCK_STATUS     LOCK_DATA
INNODB  139982241004952:1068:139982245279888    2213    61      5       demo    mytab   NULL    NULL    NULL    139982245279888 TABLE   IX      GRANTED NULL
INNODB  139982241004952:7:5:1:139982245276976   2213    61      5       demo    mytab   NULL    NULL    mytable_value_index     139982245276976 RECORD  X       GRANTED supremum pseudo-record
sql 2: insert into mytab(id, value) values(5, 19)
sql 2: insert into mytab(id, value) values(5, 19)
sql 2: commit
sql 2: commit
sql 1   sleep(5)
sql 1   0
sql 1: commit
sql 1: commit
```

Note: The insert in the sql 2 is not blocked. This is different from the previous demo, but they have similar lock info. Weird.

```
sql1: UPDATE mytab set value = value + 1 WHERE value > 18
sql1: UPDATE mytab set value = value + 1 WHERE value > 18
sql 1: sleep 5 seconds ...
sql 1: sleep 5 seconds ...
sql 2: sleep 1 seconds ...
sql 2: sleep 1 seconds ...
sql 2   sleep(1)
sql 2   0
ENGINE  ENGINE_LOCK_ID  ENGINE_TRANSACTION_ID   THREAD_ID       EVENT_ID        OBJECT_SCHEMA   OBJECT_NAME     PARTITION_NAME  SUBPARTITION_NAME       INDEX_NAME      OBJECT_INSTANCE_BEGIN   LOCK_TYPE       LOCK_MODE       LOCK_STATUS     LOCK_DATA
INNODB  139982241004952:1067:139982245279888    2180    58      5       demo    mytab   NULL    NULL    NULL    139982245279888 TABLE   IX      GRANTED NULL
INNODB  139982241004952:6:5:1:139982245276976   2180    58      5       demo    mytab   NULL    NULL    mytable_value_index     139982245276976 RECORD  X       GRANTED supremum pseudo-record
INNODB  139982241004952:6:5:5:139982245276976   2180    58      5       demo    mytab   NULL    NULL    mytable_value_index     139982245276976 RECORD  X       GRANTED 20, 0x000000000211
INNODB  139982241004952:6:4:5:139982245277320   2180    58      5       demo    mytab   NULL    NULL    GEN_CLUST_INDEX 139982245277320 RECORD  X,REC_NOT_GAP   GRANTED 0x000000000211
INNODB  139982241004952:6:5:6:139982245277664   2180    58      5       demo    mytab   NULL    NULL    mytable_value_index     139982245277664 RECORD  X,GAP   GRANTED 21, 0x000000000211
sql 2: insert into mytab(id, value) values(5, 19)
sql 2: insert into mytab(id, value) values(5, 19)
sql 1   sleep(5)
sql 1   0
sql 1: commit
sql 1: commit
sql 2: commit
sql 2: commit
```

```
sql 2: sleep 1 seconds ...
sql 2: sleep 1 seconds ...
sql1: UPDATE mytab set value = value + 1 WHERE value = 20
sql1: UPDATE mytab set value = value + 1 WHERE value = 20
sql 1: sleep 5 seconds ...
sql 1: sleep 5 seconds ...
sql 2   sleep(1)
sql 2   0
ENGINE  ENGINE_LOCK_ID  ENGINE_TRANSACTION_ID   THREAD_ID       EVENT_ID        OBJECT_SCHEMA   OBJECT_NAME     PARTITION_NAME  SUBPARTITION_NAME       INDEX_NAME      OBJECT_INSTANCE_BEGIN   LOCK_TYPE       LOCK_MODE       LOCK_STATUS     LOCK_DATA
INNODB  139982241004952:1074:139982245279888    2356    79      6       demo    mytab   NULL    NULL    NULL    139982245279888 TABLE   IX      GRANTED NULL
INNODB  139982241004952:13:5:1:139982245276976  2356    79      6       demo    mytab   NULL    NULL    mytable_value_index     139982245276976 RECORD  X       GRANTED supremum pseudo-record
INNODB  139982241004952:13:5:5:139982245276976  2356    79      6       demo    mytab   NULL    NULL    mytable_value_index     139982245276976 RECORD  X       GRANTED 20, 0x000000000224
INNODB  139982241004952:13:4:5:139982245277320  2356    79      6       demo    mytab   NULL    NULL    GEN_CLUST_INDEX 139982245277320 RECORD  X,REC_NOT_GAP   GRANTED 0x000000000224
INNODB  139982241004952:13:5:6:139982245277664  2356    79      6       demo    mytab   NULL    NULL    mytable_value_index     139982245277664 RECORD  X,GAP   GRANTED 21, 0x000000000224
sql 2: insert into mytab(id, value) values(5, 19)
sql 2: insert into mytab(id, value) values(5, 19)
sql 1   sleep(5)
sql 1   0
sql 1: commit
sql 1: commit
sql 2: commit
sql 2: commit
```

```
sql1: UPDATE mytab set value = value + 1 WHERE value = 20
sql1: UPDATE mytab set value = value + 1 WHERE value = 20
sql 1: sleep 5 seconds ...
sql 1: sleep 5 seconds ...
sql 2: sleep 1 seconds ...
sql 2: sleep 1 seconds ...
sql 2   sleep(1)
sql 2   0
ENGINE  ENGINE_LOCK_ID  ENGINE_TRANSACTION_ID   THREAD_ID       EVENT_ID        OBJECT_SCHEMA   OBJECT_NAME     PARTITION_NAME  SUBPARTITION_NAME       INDEX_NAME      OBJECT_INSTANCE_BEGIN   LOCK_TYPE       LOCK_MODE       LOCK_STATUS     LOCK_DATA
INNODB  139982241004952:1077:139982245279888    2455    88      6       demo    mytab   NULL    NULL    NULL    139982245279888 TABLE   IX      GRANTED NULL
INNODB  139982241004952:16:5:1:139982245276976  2455    88      6       demo    mytab   NULL    NULL    mytable_value_index     139982245276976 RECORD  X       GRANTED supremum pseudo-record
INNODB  139982241004952:16:5:5:139982245276976  2455    88      6       demo    mytab   NULL    NULL    mytable_value_index     139982245276976 RECORD  X       GRANTED 20, 0x000000000233
INNODB  139982241004952:16:4:5:139982245277320  2455    88      6       demo    mytab   NULL    NULL    GEN_CLUST_INDEX 139982245277320 RECORD  X,REC_NOT_GAP   GRANTED 0x000000000233
INNODB  139982241004952:16:5:6:139982245277664  2455    88      6       demo    mytab   NULL    NULL    mytable_value_index     139982245277664 RECORD  X,GAP   GRANTED 21, 0x000000000233
sql 2: insert into mytab(id, value) values(5, 13)
sql 2: insert into mytab(id, value) values(5, 13)
sql 1   sleep(5)
sql 1   0
sql 1: commit
sql 1: commit
sql 2: commit
sql 2: commit
```

```
sql 2: sleep 1 seconds ...
sql 2: sleep 1 seconds ...
sql1: UPDATE mytab set value = value + 1 WHERE value = 20
sql1: UPDATE mytab set value = value + 1 WHERE value = 20
sql 1: sleep 5 seconds ...
sql 1: sleep 5 seconds ...
sql 2   sleep(1)
sql 2   0
ENGINE  ENGINE_LOCK_ID  ENGINE_TRANSACTION_ID   THREAD_ID       EVENT_ID        OBJECT_SCHEMA   OBJECT_NAME     PARTITION_NAME  SUBPARTITION_NAME       INDEX_NAME      OBJECT_INSTANCE_BEGIN   LOCK_TYPE       LOCK_MODE       LOCK_STATUS     LOCK_DATA
INNODB  139982241004952:1076:139982245279888    2422    85      6       demo    mytab   NULL    NULL    NULL    139982245279888 TABLE   IX      GRANTED NULL
INNODB  139982241004952:15:5:1:139982245276976  2422    85      6       demo    mytab   NULL    NULL    mytable_value_index     139982245276976 RECORD  X       GRANTED supremum pseudo-record
INNODB  139982241004952:15:5:5:139982245276976  2422    85      6       demo    mytab   NULL    NULL    mytable_value_index     139982245276976 RECORD  X       GRANTED 20, 0x00000000022E
INNODB  139982241004952:15:4:5:139982245277320  2422    85      6       demo    mytab   NULL    NULL    GEN_CLUST_INDEX 139982245277320 RECORD  X,REC_NOT_GAP   GRANTED 0x00000000022E
INNODB  139982241004952:15:5:6:139982245277664  2422    85      6       demo    mytab   NULL    NULL    mytable_value_index     139982245277664 RECORD  X,GAP   GRANTED 21, 0x00000000022E
sql 2: insert into mytab(id, value) values(5, 12)
sql 2: insert into mytab(id, value) values(5, 12)
sql 2: commit
sql 2: commit
sql 1   sleep(5)
sql 1   0
sql 1: commit
sql 1: commit
```

Note: Insert 12 is not blocked; How to interpret the data in performance_schema.data_locks?
