CREATE TABLE t_currency (id int, name varchar(10), description text, PRIMARY KEY (id));
-- CREATE UNIQUE INDEX name ON t_currency (name);
INSERT INTO t_currency VALUES (1, 'EUR', '');
INSERT INTO t_currency VALUES (2, 'USD', '');

CREATE TABLE t_account (id int, currency_id int REFERENCES t_currency (id) , balance NUMERIC);
--ON UPDATE CASCADE ON DELETE CASCADE
INSERT INTO t_account VALUES (1, 1, 100);
INSERT INTO t_account VALUES (2, 1, 200);
