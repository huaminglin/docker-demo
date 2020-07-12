# Demo PostgreSQL Datatype

## Available time zones

SELECT name, abbrev, utc_offset, is_dst FROM pg_timezone_names;

## pg_typeof: "timestamp without time zone" and "timestamp with time zone"

```
select pg_typeof(now());
        pg_typeof         
--------------------------
 timestamp with time zone
```

```
select pg_typeof(current_timestamp);
        pg_typeof         
--------------------------
 timestamp with time zone
```

```
select pg_typeof(localtimestamp);
          pg_typeof          
-----------------------------
 timestamp without time zone
```

```
select pg_typeof(timestamp '2020-06-08 04:05:06'), pg_typeof(timestamptz '2020-06-08 04:05:06');
          pg_typeof          |        pg_typeof         
-----------------------------+--------------------------
 timestamp without time zone | timestamp with time zone
```

```
select pg_typeof(ts), pg_typeof(tz) from tstz limit 1;
          pg_typeof          |        pg_typeof         
-----------------------------+--------------------------
 timestamp without time zone | timestamp with time zone
```

```
SELECT TIMESTAMP '2020-06-08 04:05:06' AT TIME ZONE 'Asia/Shanghai', pg_typeof(TIMESTAMP '2020-06-08 04:05:06' AT TIME ZONE 'Asia/Shanghai');
        timezone        |        pg_typeof         
------------------------+--------------------------
 2020-06-07 20:05:06+00 | timestamp with time zone
```

```
SELECT TIMESTAMP WITH TIME ZONE '2020-06-08 04:05:06+00' AT TIME ZONE 'Asia/Shanghai', pg_typeof(TIMESTAMP WITH TIME ZONE '2020-06-08 04:05:06+00' AT TIME ZONE 'Asia/Shanghai');
      timezone       |          pg_typeof          
---------------------+-----------------------------
 2020-06-08 12:05:06 | timestamp without time zone
```

## ts timestamp and tstz timestamptz

sudo docker exec postgres-datatype-demo_client_1 bash -c /sql/tstz.sh

Conclusion: timestamptz has the same data size as timestamp without time zone, and has the same precision.

It seems to me timestamptz is just a special timestamp with automatical conversion between UTC and the session timezone.

timestamp [ (p) ] [ without time zone ] 8 bytes both date and time (no time zone)

timestamp [ (p) ] with time zone 8 bytes both date and time, with time zone


## Use timestamptz when a timestamp is expected

Drop the timezone info before use timestamptz as timestamp.
