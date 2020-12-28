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

Note: Addon02/request() can't get flask response; the flask is executed async;

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

Note: flask expects a response.

## Is it possible mitmproxy.addons.asgiapp.WSGIApp to skip some pattern of requests

We can extend ASGIApp and override 'def should_serve(self, flow: http.HTTPFlow) -> bool:'.

In this way, we allow flask to mock some and forward the others.

Update:

1) We can forward the request to the target server, but I can't find a way to write the new response to client.

2) master.commands.call("replay.client", [new_flow]) is async.

3) asgiapp.WSGIApp is async, and we can't get its response in the next addon02.request().

## mitmproxy.tools.web.master.WebMaster

```
master <class 'mitmproxy.tools.web.master.WebMaster'> <mitmproxy.tools.web.master.WebMaster object at 0x7f07f3788040> ['__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__init_subclass__', '__le__', '__lt__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_change_reverse_host', '_server', '_shutdown', '_sig_events_add', '_sig_events_refresh', '_sig_options_update', '_sig_settings_update', '_sig_view_add', '_sig_view_refresh', '_sig_view_remove', '_sig_view_update', 'addons', 'app', 'channel', 'commands', 'events', 'load_flow', 'log', 'options', 'run', 'run_loop', 'running', 'server', 'should_exit', 'shutdown', 'start', 'view', 'waiting_flows']
```

## mitmproxy.net.http.headers.Headers

```
flow.response.headers <class 'mitmproxy.net.http.headers.Headers'> Headers[(b'content-type', b'text/html; charset=utf-8'), (b'content-length', b'7'), (b'x-mitmproxy-forward', b'forward')] ['_MutableMapping__marker', '__abstractmethods__', '__bytes__', '__class__', '__contains__', '__delattr__', '__delitem__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__getitem__', '__gt__', '__hash__', '__init__', '__init_subclass__', '__iter__', '__le__', '__len__', '__lt__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__reversed__', '__setattr__', '__setitem__', '__sizeof__', '__slots__', '__str__', '__subclasshook__', '__weakref__', '_abc_impl', '_kconv', '_reduce_values', 'add', 'clear', 'copy', 'fields', 'from_state', 'get', 'get_all', 'get_state', 'insert', 'items', 'keys', 'pop', 'popitem', 'set_all', 'set_state', 'setdefault', 'update', 'values']
```

## The wsgiapp in the old mitmproxy 4.0.0

err = app.serve(flow, flow.client_conn.wfile, **{"mitmproxy.master": ctx.master})

So the flask response is written to flow.client_conn.wfile directly; which means the addon02.request() can't get its response as well.

## Change wsgiapp to set flow.response

1) "# Hyman fix: Create response for the next addon.request()" in wsgi.py

2) "# Hyman fix: Don't kill since we don't write to client connection any more." in wsgiapp.py

3) "# Switch flow.client_conn.wfile to /dev/null, and modify wsgiapp.WSGIApp to set flow.response." in wsgi-flask-app01.py

4) "response.headers['X-mitmproxy-processed'] = 'processed'", always forward other requests.

In this way, we create a mock server using flask; it will forward requests to the target host unless we set response.headers['X-mitmproxy-processed'].

## mitmproxy.addons.asgiapp.WSGIApp

TODO: The above solution is just a workaround. I need to learn more about asyncio and asgiapp.WSGIApp.

We'd better keep up with the latest mitmproxy implementation and build the solution on top of it.
