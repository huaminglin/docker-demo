http://127.0.0.1:18030/examples/encoding.jsp

## update.sh
Data posted/got to this form was:
GET
中文
mymethod=GET&mydata=%E4%B8%AD%E6%96%87

Data posted/got to this form was:
POST
中文
null

## update-strict.sh
Data posted/got to this form was:
GET
ä¸­æ
mymethod=GET&mydata=%E4%B8%AD%E6%96%87

Data posted/got to this form was:
POST
中文
null

## Conclusion: Tomcat <Connector> URIEncoding default to UTF-8
If not specified, UTF-8 will be used unless the org.apache.catalina.STRICT_SERVLET_COMPLIANCE system property is set to true in which case ISO-8859-1 will be used.
