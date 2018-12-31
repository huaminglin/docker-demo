select id, col1, col2, length(col1), length(col2) from t1;

set character_set_connection='utf8';
select '¥' as 'utf8 connection ¥', length('¥');

set character_set_connection='latin1';
select '¥' as 'latin1 connection ¥', length('¥');

set character_set_connection='utf8';
select "character_set_connection='utf8'", INSTR(col1, '¥'),  INSTR(col2, '¥') from t1;

set character_set_connection='latin1';
select 'character_set_connection=latin1', INSTR(col1, '¥'),  INSTR(col2, '¥') from t1;

set character_set_connection='latin1';
SELECT 'latin1 connection', length(_utf8'¥');

set character_set_connection='utf8';
SELECT 'utf8 connection', length(_utf8'¥');
