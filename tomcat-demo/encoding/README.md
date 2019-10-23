http://127.0.0.1:18030/examples/jsp/encoding.jsp

http://127.0.0.1:18030/examples/jsp/encoding-non.jsp

## How do GET method and encoding work?
1. update.sh and encoding.jsp
<pre>Query string: mymethod=GET&mydata=%E4%B8%AD%E6%96%87
Parameter mymethod: GET
Parameter mydata: 中文
Raw body:

Body decoded:

</pre>
document.characterSet: UTF-8
2. update.sh and encoding-non.jsp
<pre>Query string: mymethod=GET&mydata=%26%2320013%3B%26%2325991%3B
Parameter mymethod: GET
Parameter mydata: &#20013;&#25991;
Raw body:

Body decoded:

</pre>
document.characterSet: windows-1252

3. update-strict.sh and encoding.jsp
<pre>Query string: mymethod=GET&mydata=%E4%B8%AD%E6%96%87
Parameter mymethod: GET
Parameter mydata: ä¸­æ
Raw body:

Body decoded:

</pre>
document.characterSet: UTF-8

4. update-strict.sh and encoding-non.jsp
<p>Data posted/got to this form was:<pre>Query string: mymethod=GET&mydata=%26%2320013%3B%26%2325991%3B
Parameter mymethod: GET
Parameter mydata: &#20013;&#25991;
Raw body:

Body decoded:

</pre>
document.characterSet: windows-1252

5. Conclusion
1) Tomcat <Connector> URIEncoding default to UTF-8
If not specified, UTF-8 will be used unless the org.apache.catalina.STRICT_SERVLET_COMPLIANCE system property is set to true in which case ISO-8859-1 will be used.

request.getParameter() is handled by Tomcat container to decoding parameters from uri percent encoding.

2) When use <form> to generate GET request, the document character set is used to encoding parameters.
"windows-1252" uses "numeric character reference" to encode non-ascill character for query string parameters.

## How does browser address bar handle percent encoding?
1. update.sh and encoding.jsp
http://127.0.0.1:18030/examples/jsp/encoding.jsp?mymethod=GET&mydata=中文

<pre>Query string: mymethod=GET&mydata=%E4%B8%AD%E6%96%87
Parameter mymethod: GET
Parameter mydata: 中文
Raw body:

Body decoded:

</pre>
document.characterSet: UTF-8

2. update.sh and encoding-non.jsp
http://127.0.0.1:18030/examples/jsp/encoding-non.jsp?mymethod=GET&mydata=中文

<pre>Query string: mymethod=GET&mydata=%E4%B8%AD%E6%96%87
Parameter mymethod: GET
Parameter mydata: ??
Raw body:

Body decoded:

</pre>
document.characterSet: windows-1252

3. update-strict.sh and encoding.jsp
http://127.0.0.1:18030/examples/jsp/encoding.jsp?mymethod=GET&mydata=中文
<pre>Query string: mymethod=GET&mydata=%E4%B8%AD%E6%96%87
Parameter mymethod: GET
Parameter mydata: ä¸­æ
Raw body:

Body decoded:

</pre>
document.characterSet: UTF-8

4. update-strict.sh and encoding-non.jsp
http://127.0.0.1:18030/examples/jsp/encoding-non.jsp?mymethod=GET&mydata=中文
<pre>Query string: mymethod=GET&mydata=%E4%B8%AD%E6%96%87
Parameter mymethod: GET
Parameter mydata: ä¸­æ–‡
Raw body:

Body decoded:

</pre>
document.characterSet: windows-1252

5. Conclusion
The address bar of firefox on Ubuntu 18.04 always uses UTF-8 to encoding parameters into query string.

## How do POST method and encoding work?
1. update.sh and encoding.jsp
<pre>Query string: null
Raw body:
mymethod=POST&mydata=%E4%B8%AD%E6%96%87
Body decoded:
mymethod=POST&mydata=中文
</pre>
document.characterSet: UTF-8

2. update.sh and encoding-non.jsp
<pre>Query string: null
Raw body:
mymethod=POST&mydata=%26%2320013%3B%26%2325991%3B
Body decoded:
mymethod=POST&mydata=&#20013;&#25991;
</pre>
document.characterSet: windows-1252

3. Conclusion
"windows-1252" uses "numeric character reference" to encode non-ascill character for POST body.
