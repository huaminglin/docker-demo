http://127.0.0.1:18030/examples/jsp/encoding.jsp

http://127.0.0.1:18030/examples/jsp/encoding-non.jsp

## how a GET request and encoding works on the client side (Use mitmproxy to track the request)
1. The GET request sent to the server from browser address bar directly
http://127.0.0.1:18030/examples/jsp/encoding.jsp?mymethod=GET&mydata=中文
GET http://x.x.x.x:18030/examples/jsp/encoding.jsp?mymethod=GET&mydata=%E4%B8%AD%E6%96%87 HTTP/1.1
Note: UTF-8 is used for Chrome on Linux (Version 70.0.3538.77 (Official Build) (64-bit))

2. The GET request sent to the server from a page with content-type encoiding UTF-8
http://127.0.0.1:18030/examples/jsp/encoding.jsp
GET http://x.x.x.x:18030/examples/jsp/encoding.jsp?mymethod=GET&mydata=%E4%B8%AD%E6%96%87 HTTP/1.1

3. The GET request sent to the server from a page with content-type encoiding ISO-8859-1
http://127.0.0.1:18030/examples/jsp/encoding-ISO-8859-1.jsp
GET http://x.x.x.x:18030/examples/jsp/encoding-ISO-8859-1.jsp?mymethod=GET&mydata=%26%2320013%3B%26%2325991%3B HTTP/1.1
Note: &#20013;&#25991; is used to generate query string.

4. The GET request sent to the server from a page without content-type encoiding
Use Firefox (69.0.2 (64-bit)). It supports to view page info. It shows "Text Encoding: windows-1252".
GET http://x.x.x.x:18030/examples/jsp/encoding-non.jsp?mymethod=GET&mydata=%26%2320013%3B%26%2325991%3B HTTP/1.1
Note:
  &#20013;&#25991; is used to generate query string.
  document.characterSet: windows-1252

Conclusion: A web page can submit character which is not supported by the page encoding. Numeric character reference is used to encode the character into ASCII characters.

## how a Ajax request and encoding works on the client side (Use mitmproxy to track the request)
Content-Type:	application/x-www-form-urlencoded; charset=UTF-8
Referer:	http://x.x.x.x:18030/examples/jsp/encoding-ISO-8859-1.jsp
Payload: {"a":"\xe4\xb8\xad\xe6\x96\x87"}
Conclusion: Even in a page with ISO-8859-1 encoding, "application/x-www-form-urlencoded; charset=UTF-8" is used for ajax request.

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
