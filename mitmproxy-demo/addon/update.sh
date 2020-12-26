#!/usr/bin/env bash

cd $(dirname $0)

sudo docker stop demomitmproxy
sudo docker rm demomitmproxy
sudo docker create --name demomitmproxy --add-host=mydesktop:x.x.x.x -v $PWD/script:/script -p 6080:8080 -p 6081:8081 mitmproxy/mitmproxy:6.0.0 mitmweb -s /script/addon01.py -s /script/addon02.py --no-web-open-browser --web-host 0.0.0.0 

sudo docker start demomitmproxy
