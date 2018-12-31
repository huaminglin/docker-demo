insert into t1(col1, col2) VALUES('aaa¥bbb', 'aaaa¥bbbb');
select id, col1, col2, length(col1), length(col2) from t1 order by id;
