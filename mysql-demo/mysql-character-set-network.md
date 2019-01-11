What kind of bytes are sent over the MySQL protocol?
The input bytes are treated as character_set_client by MySQL server.
MySQL server converts result string from their character set to character_set_results bytes.

## Terminal Encoding Settings
Set Terminal > Preferences > Unnamed > Compatibility > Encoding: Western - ISO-8859-1
Prefer latin1 to utf8 since latin1 can show every byte but utf8 show unknow bytes as "?".
At least latin1 always shows how many bytes the resutl has.

## Intput latin1 string
docker run -it --rm --net=container:mysql-demo_server_1 -v /var/tmp:/capture itsthenetwork/alpine-tcpdump:latest -v -i eth0 -w /capture/mysql-demo_server_1-query-network-latin1.sql.pcap

docker-compose exec server bash -c "tail -f /var/log/mysql.general.log /var/log/mysqld.log"
The data in the log is the bytes received from the network.

a. --default-character-set=latin1 and SET character_set_client='latin1'
docker-compose exec client bash -c "echo \"SET character_set_client='latin1';\" | cat - /sql/query-network-latin1.sql | mysql --default-character-set=latin1 --ssl-mode=DISABLED --get-server-public-key -h server -pdemo mysql"

_latin1 X'a5'	_utf8 X'c2a5'	¥
¥	¥	¥
_latin1 X'a5'	_utf8 X'c2a5'	¥
¥	¥	¥
_latin1 X'a5'	_utf8 X'c2a5'	Â¥
Â¥	Â¥	Â¥
_latin1 X'a5'	_utf8 X'c2a5'	Â¥
Â¥	Â¥	Â¥

Note: character_set_client and source sql file are both latin1, so no unknown bytes.

b. --default-character-set=utf8 and SET character_set_client='latin1'
docker-compose exec client bash -c "echo \"SET character_set_client='latin1';\" | cat - /sql/query-network-latin1.sql | mysql --default-character-set=utf8 --ssl-mode=DISABLED --get-server-public-key -h server -pdemo mysql"

_latin1 X'a5'	_utf8 X'c2a5'	¥
¥	¥	¥
_latin1 X'a5'	_utf8 X'c2a5'	¥
¥	¥	¥
_latin1 X'a5'	_utf8 X'c2a5'	Â¥
Â¥	Â¥	Â¥
_latin1 X'a5'	_utf8 X'c2a5'	Â¥
Â¥	Â¥	Â¥

Note: character_set_client and source sql file are both latin1, so no unknown bytes.

c. --default-character-set=latin1 and SET character_set_client='utf8': how unknow 'a5' byte in utf8 is processed inside mysql
docker-compose exec client bash -c "echo \"SET character_set_client='utf8';\" | cat - /sql/query-network-latin1.sql | mysql --default-character-set=latin1 --ssl-mode=DISABLED --get-server-public-key -h server -pdemo mysql"

_latin1 X'a5'	_utf8 X'c2a5'	?
¥	¥	?
_latin1 X'a5'	_utf8 X'c2a5'	?
¥	¥	?
_latin1 X'a5'	_utf8 X'c2a5'	?
Â¥	Â¥	?
_latin1 X'a5'	_utf8 X'c2a5'	¥
Â¥	Â¥	¥

Note: character_set_client utf8 is different from source sql file latin1, then there is a unknow byte a5 in the source file. And the unknown byte is converted to '?' by MySQL server.

sql source file -> character_set_client -> character_set_connection -> character_set_results
single byte "a5" -> utf8 -> latin1 -> latin1
single byte "a5" -> utf8 -> utf8 -> latin1
single byte "a5" -> utf8 -> latin1 -> utf8
single byte "a5" -> utf8 -> utf8 -> utf8
The first 3 rows need to convert the single byte "a5" from utf8 to latin1, and "?" is generated since there is no mapping for "a5" in utf8 character set.
The last row need no conversion since utf8 is the only character set. so the single byte "a5" is output to the response.

d. --default-character-set=utf8 and SET character_set_client='utf8': how unknow 'a5' byte in utf8 is processed inside mysql
docker-compose exec client bash -c "echo \"SET character_set_client='utf8';\" | cat - /sql/query-network-latin1.sql | mysql --default-character-set=utf8 --ssl-mode=DISABLED --get-server-public-key -h server -pdemo mysql"

_latin1 X'a5'	_utf8 X'c2a5'	?
¥	¥	?
_latin1 X'a5'	_utf8 X'c2a5'	?
¥	¥	?
_latin1 X'a5'	_utf8 X'c2a5'	?
Â¥	Â¥	?
_latin1 X'a5'	_utf8 X'c2a5'	¥
Â¥	Â¥	¥


e. Conclusion
hexdump -v -e '/1 "%x-"' /home/user1/workspace/docker-demo/mysql-demo/data/mysql-demo_server_1-query-network-latin1.sql.pcap | grep -F -o "`hexdump -v -e '/1 "%x-"' mysql-demo/data/query-network-latin1.bytes`" | wc -l
16

Check the request 'SELECT _latin1 X'a5', _utf8 X'c2a5', '¥';' in mysql-demo_server_1-query-network-latin1.sql.pcap occur 16 times and always is ''. This means that the sql file is sent as its original bytes by mysql client to mysql server.


## Intput utf8 string
docker run -it --rm --net=container:mysql-demo_server_1 -v /var/tmp:/capture itsthenetwork/alpine-tcpdump:latest -v -i eth0 -w /capture/mysql-demo_server_1-query-network-utf8.sql.pcap

a. --default-character-set=latin1 and SET character_set_client='latin1'
docker-compose exec client bash -c "echo \"SET character_set_client='latin1';\" | cat - /sql/query-network-utf8.sql | mysql --default-character-set=latin1 --ssl-mode=DISABLED --get-server-public-key -h server -pdemo mysql"

_latin1 X'a5'	_utf8 X'c2a5'	Â¥
¥	¥	Â¥
_latin1 X'a5'	_utf8 X'c2a5'	Â¥
¥	¥	Â¥
_latin1 X'a5'	_utf8 X'c2a5'	ÃÂ¥
Â¥	Â¥	ÃÂ¥
_latin1 X'a5'	_utf8 X'c2a5'	ÃÂ¥
Â¥	Â¥	ÃÂ¥


b. --default-character-set=utf8 and SET character_set_client='latin1'
docker-compose exec client bash -c "echo \"SET character_set_client='latin1';\" | cat - /sql/query-network-utf8.sql | mysql --default-character-set=utf8 --ssl-mode=DISABLED --get-server-public-key -h server -pdemo mysql"

_latin1 X'a5'	_utf8 X'c2a5'	Â¥
¥	¥	Â¥
_latin1 X'a5'	_utf8 X'c2a5'	Â¥
¥	¥	Â¥
_latin1 X'a5'	_utf8 X'c2a5'	ÃÂ¥
Â¥	Â¥	ÃÂ¥
_latin1 X'a5'	_utf8 X'c2a5'	ÃÂ¥
Â¥	Â¥	ÃÂ¥


c. --default-character-set=latin1 and SET character_set_client='utf8'
docker-compose exec client bash -c "echo \"SET character_set_client='utf8';\" | cat - /sql/query-network-utf8.sql | mysql --default-character-set=latin1 --ssl-mode=DISABLED --get-server-public-key -h server -pdemo mysql"

_latin1 X'a5'	_utf8 X'c2a5'	¥
¥	¥	¥
_latin1 X'a5'	_utf8 X'c2a5'	¥
¥	¥	¥
_latin1 X'a5'	_utf8 X'c2a5'	Â¥
Â¥	Â¥	Â¥
_latin1 X'a5'	_utf8 X'c2a5'	Â¥
Â¥	Â¥	Â¥


d. --default-character-set=utf8 and SET character_set_client='utf8'
docker-compose exec client bash -c "echo \"SET character_set_client='utf8';\" | cat - /sql/query-network-utf8.sql | mysql --default-character-set=utf8 --ssl-mode=DISABLED --get-server-public-key -h server -pdemo mysql"

_latin1 X'a5'	_utf8 X'c2a5'	¥
¥	¥	¥
_latin1 X'a5'	_utf8 X'c2a5'	¥
¥	¥	¥
_latin1 X'a5'	_utf8 X'c2a5'	Â¥
Â¥	Â¥	Â¥
_latin1 X'a5'	_utf8 X'c2a5'	Â¥
Â¥	Â¥	Â¥

e. Conclusion
hexdump -v -e '/1 "%x-"' /home/user1/workspace/docker-demo/mysql-demo/data/mysql-demo_server_1-query-network-utf8.sql.pcap | grep -F -o "`hexdump -v -e '/1 "%x-"' mysql-demo/data/query-network-utf8.bytes`" | wc -l
16
The above can show mysql CLI sends the original sql bytes to mysql server.

## Conclusion
1) mysql CLI sends the original sql bytes to mysql server.
2) MySQL server log the original bytes to log file.
3) After MySQL server receives bytes from mysql CLI, it converts the bytes from character_set_client to character_set_connection.
4) When MySQL server writes a string to response, it convert the string from its character set to character_set_results.
5) sql source file --> network -> from character_set_client to character_set_connection -> sql process -> from CHARSET() to character_set_results --> network -> Client Terminal

## Questions: 
1) "select col1 from t3", does mysql server convert the column data from its character set to character_set_connection and finally to character_set_results?

2) What happens if two character set have no mapping?
A utf8 character is not in latin1.
