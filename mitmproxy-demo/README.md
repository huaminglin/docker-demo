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

## sys.path in mimproxy

sys.path: ['/script', '/usr/bin', '/usr/lib/python38.zip', '/usr/lib/python3.8', '/usr/lib/python3.8/lib-dynload', '/usr/lib/python3.8/site-packages']

__file__: /script/addon01.py

## Use PyCharm to run mitmweb in debug mode

```
/usr/bin/python3.8 /snap/pycharm-community/223/plugins/python-ce/helpers/pydev/pydevd.py --multiproc --qt-support=auto --client 127.0.0.1 --port 45661 --file /xxx/docker-demo/mitmproxy-demo/wsgi/mymitmweb.py -s /xxx/docker-demo/mitmproxy-demo/wsgi/script/wsgi-flask-app01.py -s /xxx/docker-demo/mitmproxy-demo/wsgi/script/addon02.py --no-web-open-browser --web-host 0.0.0.0 --web-port 6081 --listen-host 0.0.0.0 --listen-port 6080
Connected to pydev debugger (build 203.6682.86)
```

With PyCharm debug, we can learn how mitmproxy works.

## How addon works

```
request, addon02.py:7
invoke_addon, addonmanager.py:238
trigger, addonmanager.py:257
handle_lifecycle, addonmanager.py:214
_run, events.py:81
_run_once, base_events.py:1859
run_forever, base_events.py:570
start, asyncio.py:199
run_loop, master.py:86
run, master.py:113
run, main.py:127
mitmweb, main.py:168
<module>, mymitmweb.py:6
```

```
mitmproxy/tools/web/master.py
    def run(self):  # pragma: no cover
        AsyncIOMainLoop().install()
        iol = tornado.ioloop.IOLoop.instance()
        http_server = tornado.httpserver.HTTPServer(self.app)
        http_server.listen(self.options.web_port, self.options.web_host)
        web_url = f"http://{self.options.web_host}:{self.options.web_port}/"
        self.log.info(
            f"Web server listening at {web_url}",
        )
        self.run_loop(iol.start)

mitmproxy/master.py
    def run_loop(self, loop):
        self.start()
        asyncio.ensure_future(self.running())

        exc = None
        try:
            loop()
        except Exception:  # pragma: no cover
            exc = traceback.format_exc()
        finally:
            if not self.should_exit.is_set():  # pragma: no cover
                self.shutdown()
            loop = asyncio.get_event_loop()
            tasks = asyncio.all_tasks(loop)
            for p in tasks:
                p.cancel()
            loop.close()

        if exc:  # pragma: no cover
            print(exc, file=sys.stderr)
            print("mitmproxy has crashed!", file=sys.stderr)
            print("Please lodge a bug report at:", file=sys.stderr)
            print("\thttps://github.com/mitmproxy/mitmproxy", file=sys.stderr)

        self.addons.trigger("done")


tornado/platform/asyncio.py
    def start(self) -> None:
        try:
            old_loop = asyncio.get_event_loop()
        except (RuntimeError, AssertionError):
            old_loop = None  # type: ignore
        try:
            self._setup_logging()
            asyncio.set_event_loop(self.asyncio_loop)
            self.asyncio_loop.run_forever()
        finally:
            asyncio.set_event_loop(old_loop)


mitmproxy/addonmanager.py
    async def handle_lifecycle(self, name, message):
        """
            Handle a lifecycle event.
        """
```

```
AddonManager.chain
00 = {Core} <mitmproxy.addons.core.Core object at 0x7fe20f5644f0>
01 = {Browser} <mitmproxy.addons.browser.Browser object at 0x7fe20f564520>
02 = {Block} <mitmproxy.addons.block.Block object at 0x7fe20f564550>
03 = {AntiCache} <mitmproxy.addons.anticache.AntiCache object at 0x7fe20f564580>
04 = {AntiComp} <mitmproxy.addons.anticomp.AntiComp object at 0x7fe20f5645b0>
05 = {CheckCA} <mitmproxy.addons.check_ca.CheckCA object at 0x7fe20f5645e0>
06 = {ClientPlayback} <mitmproxy.addons.clientplayback.ClientPlayback object at 0x7fe20f564640>
07 = {CommandHistory} <mitmproxy.addons.command_history.CommandHistory object at 0x7fe20f564820>
08 = {Cut} <mitmproxy.addons.cut.Cut object at 0x7fe20f564880>
09 = {DisableH2C} <mitmproxy.addons.disable_h2c.DisableH2C object at 0x7fe20f5648b0>
10 = {Export} <mitmproxy.addons.export.Export object at 0x7fe20f5648e0>
11 = {Onboarding} <mitmproxy.addons.onboarding.Onboarding object at 0x7fe20f564910>
12 = {ProxyAuth} <mitmproxy.addons.proxyauth.ProxyAuth object at 0x7fe20f5649d0>
13 = {ScriptLoader} <mitmproxy.addons.script.ScriptLoader object at 0x7fe20f564a00>
14 = {ServerPlayback} <mitmproxy.addons.serverplayback.ServerPlayback object at 0x7fe20f564ac0>
15 = {MapRemote} <mitmproxy.addons.mapremote.MapRemote object at 0x7fe20f564b20>
16 = {MapLocal} <mitmproxy.addons.maplocal.MapLocal object at 0x7fe20f564b80>
17 = {ModifyBody} <mitmproxy.addons.modifybody.ModifyBody object at 0x7fe20f564be0>
18 = {ModifyHeaders} <mitmproxy.addons.modifyheaders.ModifyHeaders object at 0x7fe20f564c40>
19 = {StickyAuth} <mitmproxy.addons.stickyauth.StickyAuth object at 0x7fe20f564ca0>
20 = {StickyCookie} <mitmproxy.addons.stickycookie.StickyCookie object at 0x7fe20f564d00>
21 = {StreamBodies} <mitmproxy.addons.streambodies.StreamBodies object at 0x7fe20f564d60>
22 = {Save} <mitmproxy.addons.save.Save object at 0x7fe20f564dc0>
23 = {UpstreamAuth} <mitmproxy.addons.upstream_auth.UpstreamAuth object at 0x7fe20f564e20>
24 = {WebAddon} <mitmproxy.tools.web.webaddons.WebAddon object at 0x7fe20f564e80>
25 = {Intercept} <mitmproxy.addons.intercept.Intercept object at 0x7fe20f2e5250>
26 = {ReadFile} <mitmproxy.addons.readfile.ReadFile object at 0x7fe20f2e52b0>
27 = {StaticViewer} <mitmproxy.tools.web.static_viewer.StaticViewer object at 0x7fe20f2e5370>
28 = {View: 0} <mitmproxy.addons.view.View object at 0x7fe20f54dd60>
29 = {EventStore} <mitmproxy.addons.eventstore.EventStore object at 0x7fe20f564370>
30 = {TermLog} <mitmproxy.addons.termlog.TermLog object at 0x7fe20f2e5430>
31 = {TermStatus} <mitmproxy.addons.termstatus.TermStatus object at 0x7fe20f2e58e0>


AddonManager.lookup
'core' = {Core} <mitmproxy.addons.core.Core object at 0x7fe20f5644f0>
'browser' = {Browser} <mitmproxy.addons.browser.Browser object at 0x7fe20f564520>
'block' = {Block} <mitmproxy.addons.block.Block object at 0x7fe20f564550>
'anticache' = {AntiCache} <mitmproxy.addons.anticache.AntiCache object at 0x7fe20f564580>
'anticomp' = {AntiComp} <mitmproxy.addons.anticomp.AntiComp object at 0x7fe20f5645b0>
'checkca' = {CheckCA} <mitmproxy.addons.check_ca.CheckCA object at 0x7fe20f5645e0>
'clientplayback' = {ClientPlayback} <mitmproxy.addons.clientplayback.ClientPlayback object at 0x7fe20f564640>
'commandhistory' = {CommandHistory} <mitmproxy.addons.command_history.CommandHistory object at 0x7fe20f564820>
'cut' = {Cut} <mitmproxy.addons.cut.Cut object at 0x7fe20f564880>
'disableh2c' = {DisableH2C} <mitmproxy.addons.disable_h2c.DisableH2C object at 0x7fe20f5648b0>
'export' = {Export} <mitmproxy.addons.export.Export object at 0x7fe20f5648e0>
'onboarding' = {Onboarding} <mitmproxy.addons.onboarding.Onboarding object at 0x7fe20f564910>
'proxyauth' = {ProxyAuth} <mitmproxy.addons.proxyauth.ProxyAuth object at 0x7fe20f5649d0>
'scriptloader' = {ScriptLoader} <mitmproxy.addons.script.ScriptLoader object at 0x7fe20f564a00>
'serverplayback' = {ServerPlayback} <mitmproxy.addons.serverplayback.ServerPlayback object at 0x7fe20f564ac0>
'mapremote' = {MapRemote} <mitmproxy.addons.mapremote.MapRemote object at 0x7fe20f564b20>
'maplocal' = {MapLocal} <mitmproxy.addons.maplocal.MapLocal object at 0x7fe20f564b80>
'modifybody' = {ModifyBody} <mitmproxy.addons.modifybody.ModifyBody object at 0x7fe20f564be0>
'modifyheaders' = {ModifyHeaders} <mitmproxy.addons.modifyheaders.ModifyHeaders object at 0x7fe20f564c40>
'stickyauth' = {StickyAuth} <mitmproxy.addons.stickyauth.StickyAuth object at 0x7fe20f564ca0>
'stickycookie' = {StickyCookie} <mitmproxy.addons.stickycookie.StickyCookie object at 0x7fe20f564d00>
'streambodies' = {StreamBodies} <mitmproxy.addons.streambodies.StreamBodies object at 0x7fe20f564d60>
'save' = {Save} <mitmproxy.addons.save.Save object at 0x7fe20f564dc0>
'upstreamauth' = {UpstreamAuth} <mitmproxy.addons.upstream_auth.UpstreamAuth object at 0x7fe20f564e20>
'webaddon' = {WebAddon} <mitmproxy.tools.web.webaddons.WebAddon object at 0x7fe20f564e80>
'intercept' = {Intercept} <mitmproxy.addons.intercept.Intercept object at 0x7fe20f2e5250>
'readfile' = {ReadFile} <mitmproxy.addons.readfile.ReadFile object at 0x7fe20f2e52b0>
'staticviewer' = {StaticViewer} <mitmproxy.tools.web.static_viewer.StaticViewer object at 0x7fe20f2e5370>
'view' = {View: 0} <mitmproxy.addons.view.View object at 0x7fe20f54dd60>
'eventstore' = {EventStore} <mitmproxy.addons.eventstore.EventStore object at 0x7fe20f564370>
'termlog' = {TermLog} <mitmproxy.addons.termlog.TermLog object at 0x7fe20f2e5430>
'termstatus' = {TermStatus} <mitmproxy.addons.termstatus.TermStatus object at 0x7fe20f2e58e0>
'scriptmanager:/xxx/docker-demo/mitmproxy-demo/wsgi/script/wsgi-flask-app01.py' = {Script} <mitmproxy.addons.script.Script object at 0x7fe20f300a60>
'scriptmanager:/xxx/docker-demo/mitmproxy-demo/wsgi/script/addon02.py' = {Script} <mitmproxy.addons.script.Script object at 0x7fe20f300580>
'/xxx/docker-demo/mitmproxy-demo/wsgi/script/wsgi-flask-app01.py' = {module} <module '__mitmproxy_script__.wsgi-flask-app01' from '/xxx/docker-demo/mitmproxy-demo/wsgi/script/wsgi-flask-app01.py'>
'wsgiapp:mydesktop:8080' = {MyWSGIApp} <__mitmproxy_script__.wsgi-flask-app01.MyWSGIApp object at 0x7fe20f2b3f40>
'/xxx/docker-demo/mitmproxy-demo/wsgi/script/addon02.py' = {module} <module '__mitmproxy_script__.addon02' from '/xxx/docker-demo/mitmproxy-demo/wsgi/script/addon02.py'>
'addon02' = {Addon02} <__mitmproxy_script__.addon02.Addon02 object at 0x7fe20f2b0430>
```
