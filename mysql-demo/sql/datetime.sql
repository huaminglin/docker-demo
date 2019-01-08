SELECT @@global.time_zone, @@session.time_zone;
SELECT TIMEDIFF(NOW(), UTC_TIMESTAMP);

-- 946684800 is Unix Timestamp for Human time (GMT): Saturday, January 1, 2000 12:00:00 AM
SELECT FROM_UNIXTIME(946684800);

-- Datetime literal is parsed as @@session.time_zone
SELECT UNIX_TIMESTAMP("2000-01-01 00:00:00");

CREATE TABLE IF NOT EXISTS t3(
    ID int PRIMARY KEY,
    d DATE,
    t TIME,
    dt DATETIME,
    ts TIMESTAMP,
    y YEAR
) ENGINE = MYISAM;
TRUNCATE t3;

INSERT INTO t3(id, d, t, dt, ts, y) VALUES(1, '2000-01-01', '00:00:00', FROM_UNIXTIME(946684800), FROM_UNIXTIME(946684800), 2000) ON DUPLICATE KEY UPDATE ID=1;

INSERT INTO t3(id, d, t, dt, ts, y) VALUES(2, '2000-01-01', '00:00:00', "2000-01-01 00:00:00", "2000-01-01 00:00:00", 2000) ON DUPLICATE KEY UPDATE ID=2;

SELECT t3.*, UNIX_TIMESTAMP(d), UNIX_TIMESTAMP(dt), UNIX_TIMESTAMP(ts) FROM t3 ORDER BY ID;

-- Demo that Datetime column write/read by different @@session.time_zone
SET time_zone="UTC";
SELECT @@global.time_zone, @@session.time_zone;
SELECT TIMEDIFF(NOW(), UTC_TIMESTAMP);
SELECT t3.*, UNIX_TIMESTAMP(d), UNIX_TIMESTAMP(dt), UNIX_TIMESTAMP(ts) FROM t3 ORDER BY ID;

## Summary
MySQL Datetime Literal are parsed with @@session.time_zone;
FROM_UNIXTIME can be used to input a date time at UTC timezone;
UNIX_TIMESTAMP can be used to output a date time at UTC timezone.
