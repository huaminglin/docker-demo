#!/usr/bin/env bash

cd $(dirname $0)

sudo docker stop demomitmproxy
sudo docker rm demomitmproxy
sudo docker create --name demomitmproxy -p 6080:8080 -p 6081:8081 mitmproxy/mitmproxy mitmweb --no-web-open-browser --web-host 0.0.0.0
sudo docker start demomitmproxy

