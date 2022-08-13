from dnsrewriteproxy import DnsProxy

# Proxy all incoming A record requests without any rewriting
start = DnsProxy(rules=(
    (r'^www\.baidu\.com$', r'www.sohu.com'),
    (r'(^.*$)', r'\1'),
))

server_task = await start()

# Waiting here until the server is stopped
await server_task
