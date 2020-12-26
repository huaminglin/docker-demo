# Setup a HTTP proxy server

## mitmweb help

sudo docker run --rm -it mitmproxy/mitmproxy:6.0.0 mitmweb --help


## mitmproxy-demo/addon/update.sh

curl -v --proxy 127.0.0.1:6080 http://mydesktop:8080/a.html

```
Addon01: request
Addon02: request
None
Addon01: response
Addon02: response
```

Log from the web.sh console: "172.17.0.2 - - [26/Dec/2020 19:33:03] "GET /a.html HTTP/1.1" 200 -"; which means mitmproxy forwards the request to web.sh.

Note: The Addon01 response is called before Addon02; this is not like aop interceptors.


curl -v --proxy 127.0.0.1:6080 http://mydesktop:8080/b.html

```
Addon01: request
Addon02: request
Response(200, text/html, 11b)
Addon01: response
Addon02: response
```

Note: addon02:request() can get the mock response created by addon01:request().

No console log in web.sh; which means the mitmproxy doesn't forward the http response when there is a mock response.

Conclusion: we can intercept part of the requests and mock the response.


## mitmproxy.net.http.request.Request

```
dataclass
class RequestData(message.MessageData):
    host: str
    port: int
    method: bytes
    scheme: bytes
    authority: bytes
    path: bytes
```

mitmproxy.net.http.request.Response

```
@dataclass
class ResponseData(message.MessageData):
    status_code: int
    reason: bytes
```

mitmproxy.net.http.message.MessageData

```
@dataclass
class MessageData(serializable.Serializable):
    http_version: bytes
    headers: Headers
    content: Optional[bytes]
    trailers: Optional[Headers]
    timestamp_start: float
    timestamp_end: Optional[float]
```
