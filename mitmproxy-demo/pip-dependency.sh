#!/bin/bash

set -e
# Set commonutil as current folder
cd $(dirname $0)

pip3 install virtualenv

~/.local/bin/virtualenv libve

source libve/bin/activate

# Download source codes for reference
pip install -r requirements.txt
