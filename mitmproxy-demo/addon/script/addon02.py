class Addon02(object):
    def __init__(self):
        self.num = 1

    def request(self, flow):
        print("Addon02: request")
        print(flow.response)
        flow.request.headers["02count"] = str(self.num)

    def response(self, flow):
        self.num = self.num + 1
        flow.response.headers["02count"] = str(self.num)
        print("Addon02: response")

addons = [
    Addon02()
]
