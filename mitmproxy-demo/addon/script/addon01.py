import myutil


class Addon01(object):
    def __init__(self):
        self.num = 1

    def request(self, flow):
        print("Addon01: request")
        if flow.request.path == '/b.html':
            flow.response = myutil.mock_response(b"Hello World")
        else:
            flow.request.headers["01count"] = str(self.num)

    def response(self, flow):
        self.num = self.num + 1
        flow.response.headers["01count"] = str(self.num)
        print("Addon01: response")

addons = [
    Addon01()
]
