#!/usr/bin/env bash

cd $(dirname $0)

export http_proxy=http://myhttpproxy:8123
export https_proxy=$http_proxy

pip3 install virtualenv

~/.local/bin/virtualenv libve

source libve/bin/activate

pip install -r requirements.txt
