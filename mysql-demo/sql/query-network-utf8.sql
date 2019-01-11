SET character_set_connection='latin1';
SET character_set_results='latin1';
SELECT _latin1 X'e698af', _utf8 X'e698af', '是';

SET character_set_connection='utf8';
SET character_set_results='latin1';
SELECT _latin1 X'e698af', _utf8 X'e698af', '是';

SET character_set_connection='latin1';
SET character_set_results='utf8';
SELECT _latin1 X'e698af', _utf8 X'e698af', '是';

SET character_set_connection='utf8';
SET character_set_results='utf8';
SELECT _latin1 X'e698af', _utf8 X'e698af', '是';
