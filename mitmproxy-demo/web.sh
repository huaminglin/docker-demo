#!/usr/bin/env bash

cd /tmp

mkdir mitmproxy-demo
cd mitmproxy-demo

echo a > a.html
echo b > b.html
echo c > c.html

python -m SimpleHTTPServer 8080
