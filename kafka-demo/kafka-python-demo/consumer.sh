#!/usr/bin/env bash

cd $(dirname $0)
source libve/bin/activate
python3 consumer.py
