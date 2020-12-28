from mitmproxy.ctx import master
import mitmproxy.script.concurrent

class Addon02(object):

    def request(self, flow):
        print('Addon02: request begin')
        print('flow', flow)
        print('flow.response', flow.response)
        print('flow.reply', flow.reply, flow.reply.state)
        if flow.response:
            print('flow.response.headers', flow.response.headers)
            if not flow.response.headers.get('X-mitmproxy-processed'):
                print('X-mitmproxy-processed is not found in the response header')
                flow.response = None
        # When we use asgiapp.WSGIApp(it is async), we can't get the flask response here;
        # It's weird and it make no sence.
        # So we can't use asgiapp.WSGIApp; we have to call flask app synchronize.
        print('Addon02: request end')
        # breakpoint()

    # @mitmproxy.script.concurrent
    def response_disabled(self, flow):
        # We try to use "replay.client" command to forward the requests which flask doesn't handle to the target host.
        # We can forward the requests, but we don't find a way to write the response back.
        print('Addon02: response begin')
        print('flow', type(flow), flow)
        print('flow.reply', flow.reply, flow.reply.state)
        print('flow.response', type(flow.response), flow.response)
        print('flow.response.headers', type(flow.response.headers), flow.response.headers, dir(flow.response.headers))
        forward_flag = flow.response.headers.get('X-mitmproxy-forward')
        print(forward_flag)

        if forward_flag:
            print('Addon02: request forwarding')
            print('master', type(master), master, dir(master))
            flow.response = None
            new_flow = flow.copy()
            new_flow.request.headers['X-mitmproxy-forward'] = forward_flag
            master.commands.call("replay.client", [new_flow])  # Can't replay live flow if we use the original flow.
            # master.commands.call is async, new_flow.response is always null.
            # So we can't use the replay response as response to the client.
            flow.response = new_flow.response
            print('Addon02: request forwarded')
        print('Addon02: response end')


addons = [
    Addon02()
]
