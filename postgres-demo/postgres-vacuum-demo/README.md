# Demo PostgreSQL vacuum

## Check update operation cost

> **Check relation size**
```
SELECT pg_size_pretty(pg_relation_size('t_test'));
 pg_size_pretty 
----------------
 3544 kB
(1 row)
```

> **Update and Check relation size**

```
UPDATE t_test SET id = id + 1;

SELECT pg_size_pretty(pg_relation_size('t_test'));
 pg_size_pretty 
----------------
 7080 kB
(1 row)
```

> **Update and Check relation size again**

```
UPDATE t_test SET id = id + 1;

SELECT pg_size_pretty(pg_relation_size('t_test'));
 pg_size_pretty 
----------------
 10 MB
(1 row)
```

> **VACUUM t_test**

```
VACUUM t_test;
VACUUM
pgdemo=# SELECT pg_size_pretty(pg_relation_size('t_test'));
 pg_size_pretty 
----------------
 10 MB
(1 row
```

Note: It seems VACUUM doesn't reclain any storage.

> **vacuum full t_test**

```
vacuum full t_test;
VACUUM
pgdemo=# SELECT pg_size_pretty(pg_relation_size('t_test'));
 pg_size_pretty 
----------------
 3544 kB
(1 row)
```

Note: VACUUM doesn't change pg_relation_size result, but vacuum full does. Not sure why.


## Vacuum freeze t_test;

select txid_current(), xmin, xmax, cmin, cmax from t_test ORDER BY ctid DESC limit 10;

Note: "Vacuum freeze" doesn't update xmin to 2.

## Check table status by phisical storage

SELECT ctid, * FROM t_test ORDER BY ctid DESC;
