## character_set_results different from character_set_client
a. Input latin1 but output utf8
Set Terminal > Preferences > Unnamed > Compatibility > Encoding: Western - ISO-8859-1

docker-compose exec server bash -c "mysql --default-character-set=latin1 -pdemo mysql < /sql/query-connection-latin1.sql"

_latin1 X'a5'	_utf8 X'c2a5'	Â¥
Â¥	Â¥	Â¥

b. Input utf8 but output latin1
Set Terminal > Preferences > Unnamed > Compatibility > Encoding: Western - Unicode - UTF-8

docker-compose exec server bash -c "mysql --default-character-set=utf8 -pdemo mysql < /sql/query-connection-utf8.sql"

_latin1 X'a5'	_utf8 X'c2a5'	�
�	�	�
