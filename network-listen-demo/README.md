# TCP listen demo

## TCP connection status

1; Listen on 18080

python -m SimpleHTTPServer 18080

Serving HTTP on 0.0.0.0 port 18080 ...

```
ss -a | grep 18080
tcp               LISTEN              0                    5                                                                                            0.0.0.0:18080                                                0.0.0.0:*
```

Note: A LISTEN socket uses "0.0.0.0:18080" as SRC, and uses "0.0.0.0:*" as DEST.

2; Setup a TCP connection

telnet 127.0.0.1 18080

```
telnet 127.0.0.1 18080
Trying 127.0.0.1...
Connected to 127.0.0.1.
Escape character is '^]'.
```

```
tcp              LISTEN                 0                   5                                                                                           0.0.0.0:18080                                                0.0.0.0:*
tcp              ESTAB                  0                   0                                                                                         127.0.0.1:18080                                              127.0.0.1:53168
tcp              ESTAB                  0                   0                                                                                         127.0.0.1:53168                                              127.0.0.1:18080
```

Note: A connection involves two sockets: (127.0.0.1:18080, 127.0.0.1:53168) on the server side, and (127.0.0.1:53168, 127.0.0.1:18080) on the client side.

4; Kill Web Server and check status

```
ss -a | grep 18080
tcp              TIME-WAIT              0                   0                                                                                         127.0.0.1:18080                                              127.0.0.1:53168
```

Note: The web server quits, so it's the web server starts the TCP close process. Then the server side goes into TIME-WAIT state.

5; Start the web server with "TIME-WAIT" connections

python -m SimpleHTTPServer 18080

```
ss -a | grep 18080
tcp              LISTEN                 0                   5                                                                                           0.0.0.0:18080                                                0.0.0.0:*
tcp              TIME-WAIT              0                   0                                                                                         127.0.0.1:18080                                              127.0.0.1:53168
```

Note: A "LISTEN" can start when there is a legacy "TIME-WAIT" connection.

6; Setup another TCP connection, and try to "LISTEN' on the port assigned

telnet 127.0.0.1 18080

```
tcp               LISTEN              0                    5                                                                                            0.0.0.0:18080                                                0.0.0.0:*
tcp               ESTAB               0                    0                                                                                          127.0.0.1:18080                                              127.0.0.1:53200
tcp               ESTAB               0                    0                                                                                          127.0.0.1:53200                                              127.0.0.1:18080
```

python -m SimpleHTTPServer 53200

```
python -m SimpleHTTPServer 53200
Traceback (most recent call last):
  File "/usr/lib/python2.7/runpy.py", line 174, in _run_module_as_main
    "__main__", fname, loader, pkg_name)
  File "/usr/lib/python2.7/runpy.py", line 72, in _run_code
    exec code in run_globals
  File "/usr/lib/python2.7/SimpleHTTPServer.py", line 235, in <module>
    test()
  File "/usr/lib/python2.7/SimpleHTTPServer.py", line 231, in test
    BaseHTTPServer.test(HandlerClass, ServerClass)
  File "/usr/lib/python2.7/BaseHTTPServer.py", line 606, in test
    httpd = ServerClass(server_address, HandlerClass)
  File "/usr/lib/python2.7/SocketServer.py", line 420, in __init__
    self.server_bind()
  File "/usr/lib/python2.7/BaseHTTPServer.py", line 108, in server_bind
    SocketServer.TCPServer.server_bind(self)
  File "/usr/lib/python2.7/SocketServer.py", line 434, in server_bind
    self.socket.bind(self.server_address)
  File "/usr/lib/python2.7/socket.py", line 228, in meth
    return getattr(self._sock,name)(*args)
socket.error: [Errno 98] Address already in use
```

Note: We can understand the conflict in this way: the LISTEN socket uses the same SRC as the existing connection, and the LISTEN socket uses "0.0.0.0:*" as the DEST.

"0.0.0.0:*" conflicts with any existing connection on the same SRC.

And if we allow the listen socket, the old existing connection (from local to a remote server) looks like a remote client connection to our local server(the new listen socket). This is absolutely wrong.
