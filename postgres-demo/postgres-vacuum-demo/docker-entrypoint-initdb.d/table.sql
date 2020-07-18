CREATE TABLE t_test (id int) WITH (autovacuum_enabled = off);
INSERT INTO t_test SELECT * FROM generate_series(1, 100000);
