class Addon02(object):

    def request(self, flow):
        print('Addon02: request begin')
        print('flow', flow)
        if flow.reply and flow.reply.has_message:
            obj = flow.reply.take()
            print('obj', obj)
        print('flow.response', flow.response)
        print('flow.reply', flow.reply)
        print('Addon02: request end')

    def response(self, flow):
        print('Addon02: response begin')
        print('flow', flow)
        print('flow.response', flow.response)
        print('flow.reply', flow.reply)
        print('Addon02: response end')

addons = [
    Addon02()
]
