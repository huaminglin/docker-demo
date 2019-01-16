## SET character_set_results=NULL;
Set Terminal > Preferences > Unnamed > Compatibility > Encoding: Western - ISO-8859-1
Prefer latin1 to utf8 since latin1 can show every byte but utf8 show unknow bytes as "?".

docker-compose exec client bash -c "cat /sql/character-set-result.sql | mysql --ssl-mode=DISABLED --get-server-public-key -h server -pdemo mysql"

col1	col2	col1 = col2
¥	Â¥	1

Conclusion: 
If character_set_results is NULL, MySQL String columns are written to the result as bytes in their own character set.
The same character in different character sets are seen equal to each other.
