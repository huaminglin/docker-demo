CREATE TABLE t_test (id serial, name text);

INSERT INTO t_test (name) SELECT 'hans' FROM generate_series(1, 2000000);

INSERT INTO t_test (name) SELECT 'paul' FROM generate_series(1, 2000000);
