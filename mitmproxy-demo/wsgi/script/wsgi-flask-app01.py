"""
Host a WSGI app in mitmproxy.

This example shows how to graft a WSGI app onto mitmproxy. In this
instance, we're using the Flask framework (http://flask.pocoo.org/) to expose
a single simplest-possible page.
"""
from flask import Flask
from flask import request
from mitmproxy.addons import asgiapp
from mitmproxy import ctx, http

app = Flask("proxapp01")


@app.route('/a.html')
def hello_world_a() -> str:
    print('hello_world_a()')
    return 'app01 a: Hello World!'


@app.route('/b.html')
def hello_world_b() -> str:
    print('hello_world_b(): begin')
    if request.args.get('age'):
        return 'app01 b: ' + request.args.get('age')

    print('hello_world_b(): end')


class MyWSGIApp(asgiapp.WSGIApp):

    def __init__(self, wsgi_app, host: str, port: int):
        super().__init__(wsgi_app, host, port)

    def should_serve(self, flow: http.HTTPFlow) -> bool:
        print('flow.request.query', type(flow.request.query), flow.request.query)
        if flow.request.path == '/b.html' and not flow.request.query:
            return False
        return super().should_serve(flow)


addons = [
    # Host app at the magic domain "example.com" on port 80. Requests to this
    # domain and port combination will now be routed to the WSGI app instance.
    MyWSGIApp(app, "mydesktop", 8080)
    # SSL works too, but the magic domain needs to be resolvable from the mitmproxy machine due to mitmproxy's design.
    # mitmproxy will connect to said domain and use serve its certificate (unless --no-upstream-cert is set)
    # but won't send any data.
    # mitmproxy.ctx.master.apps.add(app, "example.com", 443)
]
