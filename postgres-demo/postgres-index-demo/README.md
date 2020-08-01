# Demo PostgreSQL Index

## Parallel Seq Scan

```
select name, count(*) from t_test group by 1;
 name |  count  
------+---------
 hans | 2000000
 paul | 2000000
```

```
\timing
Timing is on.

select * from t_test where id = 432332;
   id   | name 
--------+------
 432332 | hans
(1 row)

Time: 128.380 ms
```

```
explain select * from t_test where id=432332;
                               QUERY PLAN                                
-------------------------------------------------------------------------
 Gather  (cost=1000.00..43455.43 rows=1 width=9)
   Workers Planned: 2
   ->  Parallel Seq Scan on t_test  (cost=0.00..42455.33 rows=1 width=9)
         Filter: (id = 432332)
(4 rows)
```

## max_parallel_workers_per_gather

```
SET max_parallel_workers_per_gather to 0;

select * from t_test where id = 432332;
   id   | name 
--------+------
 432332 | hans
(1 row)

Time: 242.295 ms
```

```
explain select * from t_test where id=432332;
                        QUERY PLAN                        
----------------------------------------------------------
 Seq Scan on t_test  (cost=0.00..71622.00 rows=1 width=9)
   Filter: (id = 432332)
(2 rows)
```

## How does PostgreSQL get 71622

```
select pg_relation_size('t_test')/1000000;
 ?column? 
----------
      177
(1 row)
```

Pages:

```
select pg_relation_size('t_test')/8192;
 ?column? 
----------
    21622
(1 row)
```

```
select 21622*1 + 4000000*0.01 + 4000000*0.0025;
  ?column?  
------------
 71622.0000
(1 row)
```

## Create index

```
create index idx_id ON t_test (id);
CREATE INDEX
Time: 1324.762 ms (00:01.325)
```

```
select * from t_test where id = 432332;
   id   | name 
--------+------
 432332 | hans
(1 row)

Time: 1.502 ms
```

```
\di+
                        List of relations
 Schema |  Name  | Type  | Owner  | Table  | Size  | Description 
--------+--------+-------+--------+--------+-------+-------------
 public | idx_id | index | pgdemo | t_test | 86 MB | 
(1 row)
```

```
explain select * from t_test where id=432332;
                             QUERY PLAN                              
---------------------------------------------------------------------
 Index Scan using idx_id on t_test  (cost=0.43..8.45 rows=1 width=9)
   Index Cond: (id = 432332)
(2 rows)
```

## Index and Sort

```
select * from t_test order by id desc limit 10;
   id    | name 
---------+------
 4000000 | paul
 3999999 | paul
 3999998 | paul
 3999997 | paul
 3999996 | paul
 3999995 | paul
 3999994 | paul
 3999993 | paul
 3999992 | paul
 3999991 | paul
(10 rows)

Time: 0.733 ms
```

```
explain select * from t_test order by id desc limit 10;
                                          QUERY PLAN                                           
-----------------------------------------------------------------------------------------------
 Limit  (cost=0.43..0.74 rows=10 width=9)
   ->  Index Scan Backward using idx_id on t_test  (cost=0.43..125505.43 rows=4000000 width=9)
(2 rows)
```

## Index and min max

```
 min |   max   
-----+---------
   1 | 4000000
(1 row)

Time: 1.287 ms
```

```
explain select min(id), max(id)  from t_test;
                                                     QUERY PLAN                                                      
---------------------------------------------------------------------------------------------------------------------
 Result  (cost=0.93..0.94 rows=1 width=8)
   InitPlan 1 (returns $0)
     ->  Limit  (cost=0.43..0.46 rows=1 width=4)
           ->  Index Only Scan using idx_id on t_test  (cost=0.43..135505.43 rows=4000000 width=4)
                 Index Cond: (id IS NOT NULL)
   InitPlan 2 (returns $1)
     ->  Limit  (cost=0.43..0.46 rows=1 width=4)
           ->  Index Only Scan Backward using idx_id on t_test t_test_1  (cost=0.43..135505.43 rows=4000000 width=4)
                 Index Cond: (id IS NOT NULL)
(9 rows)
```

## Bitmap Index Scan

```
select * from t_test where id = 30 or id = 50;
 id | name 
----+------
 30 | hans
 50 | hans
(2 rows)

Time: 0.779 ms
```

```
explain select * from t_test where id = 30 or id = 50;
                                QUERY PLAN                                 
---------------------------------------------------------------------------
 Bitmap Heap Scan on t_test  (cost=8.88..16.85 rows=2 width=9)
   Recheck Cond: ((id = 30) OR (id = 50))
   ->  BitmapOr  (cost=8.88..8.88 rows=2 width=0)
         ->  Bitmap Index Scan on idx_id  (cost=0.00..4.44 rows=1 width=0)
               Index Cond: (id = 30)
         ->  Bitmap Index Scan on idx_id  (cost=0.00..4.44 rows=1 width=0)
               Index Cond: (id = 50)
(7 rows)
```


