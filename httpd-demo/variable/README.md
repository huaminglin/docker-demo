# Environment Variable Substitution in Apache httpd Configs

## Enable mod_info to view configuration resolved

LoadModule info_module modules/mod_info.so

```
<Location "/server-info">
    SetHandler server-info
</Location>
```

<http://127.0.0.1:18020/server-info>

## Enable cgi-bin

chmod 755 myenv.sh

"#!/bin/sh" is prefered.

<http://127.0.0.1:18020/cgi-bin/my/first.pl?a=d>

<http://127.0.0.1:18020/cgi-bin/my/myenv.sh?a=d>

```
GATEWAY_INTERFACE=CGI/1.1
REMOTE_ADDR=172.17.0.1
QUERY_STRING=a=d
HTTP_USER_AGENT=Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:83.0) Gecko/20100101 Firefox/83.0
DOCUMENT_ROOT=/usr/local/apache2/htdocs
REMOTE_PORT=43102
HTTP_UPGRADE_INSECURE_REQUESTS=1
HTTP_ACCEPT=text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
SERVER_SIGNATURE=
CONTEXT_DOCUMENT_ROOT=/usr/local/apache2/cgi-bin/
SCRIPT_FILENAME=/usr/local/apache2/cgi-bin/myenv.sh
HTTP_HOST=127.0.0.1:18020
REQUEST_URI=/cgi-bin/myenv.sh?a=d
SERVER_SOFTWARE=Apache/2.4.41 (Unix)
HTTP_CONNECTION=keep-alive
REQUEST_SCHEME=http
PATH=/usr/local/apache2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HTTP_ACCEPT_LANGUAGE=en-US,en;q=0.5
SERVER_PROTOCOL=HTTP/1.1
HTTP_ACCEPT_ENCODING=gzip, deflate
SCRIPT_URI=http://127.0.0.1:18020/cgi-bin/myenv.sh
SCRIPT_URL=/cgi-bin/myenv.sh
REQUEST_METHOD=GET
SERVER_ADDR=172.17.0.2
SERVER_ADMIN=you@example.com
CONTEXT_PREFIX=/cgi-bin/
PWD=/usr/local/apache2/cgi-bin
SERVER_PORT=18020
SCRIPT_NAME=/cgi-bin/myenv.sh
SERVER_NAME=127.0.0.1
```

```
ScriptAlias /cgi-bin/ "/usr/local/apache2/cgi-bin/"

<Directory "/usr/local/apache2/cgi-bin">
    AllowOverride None
    Options None
    Require all granted
</Directory>

```

Conclusion: "REDIRECT_TARGET" is not exposed to the CGI script.

## Verify "httpd-foreground -D REDIRECT_TARGET=f -D REDIRECT_TARGET2=g" and ${REDIRECT_TARGET2}

<http://127.0.0.1:18020/server-info>

557: RewriteRule /a.html /e1.html [R=301,L]
558: RewriteRule /d.html /.html [R=301,L]
559: RewriteRule /e.html /d3.html [R=301,L]
560: RewriteRule /f.html /${REDIRECT_TARGET4}.html [R=301,L]
561: RewriteRule /g.html /d5.html [R=301,L]
562: RewriteRule /h.html /d6.html [R=301,L]
563: RewriteRule /i.html /d7.html [R=301,L]
564: RewriteRule /j.html /d8.2.html [R=301,L]

Conclusion:

557 -> ${} can resolve from an Environment Variable.
558 -> ${} can resolve from an Environment Variable even when it has an empty value.
559 -> ${} prefers "Define Directive" than Environment Variable.
560 -> ${} doesn't resolve from "httpd -D name" since it doesn't provide value.
561 -> ${} can resolve from "Define Directive".
562 -> ${} can resolve from the included conf which locates outside the apache home folder.
563 -> The Include directive supports ${} as its target.
564 -> The last define wins.

## Verify RewriteMap content

<http://127.0.0.1:18020/k.html>

The page is redirected to <http://127.0.0.1:9090/k.html> sucessfully.

## RewriteMap file ignore # character

At lease, "# url http://127.0.0.1:9999" line dones't break the file.

## Environment variables and Define can be used to inject a command

```
 571: RewriteMap cdnDomainMap rnd:/myhome/cdn.properties
 572: RewriteMap cdnDomainMap02 rnd:/myhome/cdn.properties
 573: RewriteMap cdnDomainMap03 rnd:/myhome/cdn.properties
 574: RewriteRule ^.*(/k\.html).*$ ${cdnDomainMap:url}$1 [R=302]
```
