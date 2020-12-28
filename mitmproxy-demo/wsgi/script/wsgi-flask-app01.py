"""
Host a WSGI app in mitmproxy.

This example shows how to graft a WSGI app onto mitmproxy. In this
instance, we're using the Flask framework (http://flask.pocoo.org/) to expose
a single simplest-possible page.
"""
import flask
from flask import Flask
from flask import request
import wsgiapp

app = Flask("proxapp01")


@app.route('/a.html')
def hello_world_a() -> str:
    print('hello_world_a()')
    response = flask.make_response('app01 a: Hello World!', 200)
    response.headers['X-mitmproxy-processed'] = 'processed'
    return response


@app.route('/b.html')
def hello_world_b() -> str:
    print('hello_world_b(): begin')
    if request.args.get('age'):
        response = flask.make_response('app01 b: ' + request.args.get('age'), 200)
        response.headers['X-mitmproxy-processed'] = 'processed'
        return response

    print('hello_world_b(): end')
    response = flask.make_response('forward', 555)
    response.headers['X-mitmproxy-forward'] = 'forward'
    return response


class MyWSGIApp(wsgiapp.WSGIApp):

    def __init__(self, app, host, port):
        super().__init__(app, host, port)

    def serve(self, app, flow):
        # wsgiapp.WSGIApp write to flow.client_conn.wfile directly.
        # Switch to write to /dev/null, and modify wsgiapp.WSGIApp to set flow.response.
        old_file = flow.client_conn.wfile
        flow.client_conn.wfile = open('/dev/null', 'bw')
        super().serve(app, flow)
        flow.client_conn.wfile = old_file


addons = [
    # Host app at the magic domain "example.com" on port 80. Requests to this
    # domain and port combination will now be routed to the WSGI app instance.
    MyWSGIApp(app, "mydesktop", 8080)
    # SSL works too, but the magic domain needs to be resolvable from the mitmproxy machine due to mitmproxy's design.
    # mitmproxy will connect to said domain and use serve its certificate (unless --no-upstream-cert is set)
    # but won't send any data.
    # mitmproxy.ctx.master.apps.add(app, "example.com", 443)
]
