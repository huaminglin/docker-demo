#!/usr/bin/env bash

cd $(dirname $0)/..

source libve/bin/activate

mitmweb -s wsgi/script/wsgi-flask-app01.py -s wsgi/script/addon02.py --no-web-open-browser --web-host 0.0.0.0 --web-port 6081 --listen-host 0.0.0.0 --listen-port 6080
