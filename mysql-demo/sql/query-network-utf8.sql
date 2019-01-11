SET character_set_connection='latin1';
SET character_set_results='latin1';
SELECT _latin1 X'a5', _utf8 X'c2a5', '¥';

SET character_set_connection='utf8';
SET character_set_results='latin1';
SELECT _latin1 X'a5', _utf8 X'c2a5', '¥';

SET character_set_connection='latin1';
SET character_set_results='utf8';
SELECT _latin1 X'a5', _utf8 X'c2a5', '¥';

SET character_set_connection='utf8';
SET character_set_results='utf8';
SELECT _latin1 X'a5', _utf8 X'c2a5', '¥';
