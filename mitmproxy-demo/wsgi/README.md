# mitmproxy as mock server

## mitmproxy-demo/wsgi/update.sh

## curl

curl --proxy 127.0.0.1:6080 http://mydesktop:8080/a.html


curl --proxy 127.0.0.1:6080 http://mydesktop:8080/b.html


curl --proxy 127.0.0.1:6080 http://mydesktop:8080/c.html

## mitmproxy.addons.wsgiapp.WSGIApp

mitmproxy/addons/asgiapp.py

```
    def should_serve(self, flow: http.HTTPFlow) -> bool:
        assert flow.reply
        return bool(
            (flow.request.pretty_host, flow.request.port) == (self.host, self.port)
            and not flow.reply.has_message
            and not isinstance(flow.reply, DummyReply)  # ignore the HTTP flows of this app loaded from somewhere
        )

    def request(self, flow: http.HTTPFlow) -> None:
        assert flow.reply
        if self.should_serve(flow):
            flow.reply.take()  # pause hook completion
            asyncio.ensure_future(serve(self.asgi_app, flow))
```

Note: The asgiapp handle the request with asyncio.

mitmproxy/addonmanager.py

```
    def register(self, addon):
        """
            Register an addon, call its load event, and then register all its
            sub-addons. This should be used by addons that dynamically manage
            addons.

            If the calling addon is already running, it should follow with
            running and configure events. Must be called within a current
            context.
        """
        for a in traverse([addon]):
            name = _get_name(a)
            if name in self.lookup:
                raise exceptions.AddonManagerError(
                    "An addon called '%s' already exists." % name
                )

 _get_name(itm):
    return getattr(itm, "name", itm.__class__.__name__.lower())

```

Conclusion: The host and port is used to identify the app, so we can't use two different WSGIApp for the same host and port.

## Can we use flask to mock a part of the requets and forward the others to the target host

```
ERROR:proxapp01:Exception on /b.html [GET]
Traceback (most recent call last):
  File "/usr/lib/python3.8/site-packages/flask/app.py", line 2447, in wsgi_app
    response = self.full_dispatch_request()
  File "/usr/lib/python3.8/site-packages/flask/app.py", line 1953, in full_dispatch_request
    return self.finalize_request(rv)
  File "/usr/lib/python3.8/site-packages/flask/app.py", line 1968, in finalize_request
    response = self.make_response(rv)
  File "/usr/lib/python3.8/site-packages/flask/app.py", line 2097, in make_response
    raise TypeError(
TypeError: The view function did not return a valid response. The function either returned None or ended without a return statement.
172.17.0.1:35296: clientdisconnect
```

So the flask app always need a response; it seems we can't select which kind of requests to mock or forward.


## Can we use a second addon to process and ignore some of the flask response and forward request


curl --proxy 127.0.0.1:6080 http://mydesktop:8080/b.html?age=18

```
Web server listening at http://0.0.0.0:8081/
Loading script /script/wsgi-flask-app01.py
Loading script /script/addon02.py
Proxy server listening at http://*:8080
172.17.0.1:38942: clientconnect
Addon02: request
flow <HTTPFlow
  request = Request(GET mydesktop:8080/b.html?age=18)
  client_conn = <ClientConnection: 172.17.0.1:38942>
  server_conn = <ServerConnection: <no address>>>
flow.response None
flow.reply <mitmproxy.controller.Reply object at 0x7feaedba0040>
Addon02: response begin
flow <HTTPFlow
  request = Request(GET mydesktop:8080/b.html?age=18)
  response = Response(200, text/html; charset=utf-8, 11b)
  client_conn = <ClientConnection: 172.17.0.1:38942>
  server_conn = <ServerConnection: <no address>>>
flow.response Response(200, text/html; charset=utf-8, 11b)
flow.reply <mitmproxy.controller.Reply object at 0x7feaedf0d730>
Addon02: response end
172.17.0.1:38942: clientdisconnect
```

Note: Addon02/request() can't get flask response; and we don't get any the flask logging;

Addon02/response() can get flask response.



curl --proxy 127.0.0.1:6080 http://mydesktop:8080/b.html

```
Web server listening at http://0.0.0.0:8081/
Loading script /script/wsgi-flask-app01.py
Loading script /script/addon02.py
Proxy server listening at http://*:8080
172.17.0.1:38980: clientconnect
ERROR:proxapp01:Exception on /b.html [GET]
Traceback (most recent call last):
  File "/usr/lib/python3.8/site-packages/flask/app.py", line 2447, in wsgi_app
    response = self.full_dispatch_request()
  File "/usr/lib/python3.8/site-packages/flask/app.py", line 1953, in full_dispatch_request
    return self.finalize_request(rv)
  File "/usr/lib/python3.8/site-packages/flask/app.py", line 1968, in finalize_request
    response = self.make_response(rv)
  File "/usr/lib/python3.8/site-packages/flask/app.py", line 2097, in make_response
    raise TypeError(
TypeError: The view function did not return a valid response. The function either returned None or ended without a return statement.
Addon02: request
flow <HTTPFlow
  request = Request(GET mydesktop:8080/b.html)
  client_conn = <ClientConnection: 172.17.0.1:38980>
  server_conn = <ServerConnection: <no address>>>
flow.response None
flow.reply <mitmproxy.controller.Reply object at 0x7fe8f67e0040>
hello_world_b()
Addon02: response begin
flow <HTTPFlow
  request = Request(GET mydesktop:8080/b.html)
  response = Response(500, text/html; charset=utf-8, 290b)
  client_conn = <ClientConnection: 172.17.0.1:38980>
  server_conn = <ServerConnection: <no address>>>
flow.response Response(500, text/html; charset=utf-8, 290b)
flow.reply <mitmproxy.controller.Reply object at 0x7fe8f67e0790>
Addon02: response end
172.17.0.1:38980: clientdisconnect
```

## Is it possible mitmproxy.addons.asgiapp.WSGIApp to skip some pattern of requests

We can extend ASGIApp and override 'def should_serve(self, flow: http.HTTPFlow) -> bool:'.

In this way, we allow flask to mock some and forword the others.
