import mitmproxy.http


def mock_response(body):
    return mitmproxy.http.HTTPResponse.make(200, body, {"Content-Type": "text/html"})
