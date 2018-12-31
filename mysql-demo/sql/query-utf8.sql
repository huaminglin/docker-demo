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
select 'latin1 connection', length(_utf8'¥');

set character_set_connection='utf8';
select 'utf8 connection', length(_utf8'¥');

select HEX(BINARY CONVERT('¥' using utf8)), HEX(BINARY CONVERT('¥' using latin1)), CONVERT('¥' using utf8) = CONVERT('¥' using latin1), BINARY CONVERT('¥' using utf8) = BINARY CONVERT('¥' using latin1);
