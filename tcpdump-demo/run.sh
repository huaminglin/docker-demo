#!/usr/bin/env bash

cd $(dirname $0)

docker run -it --rm --net=container:redis-demo_client_1 -v /var/tmp:/capture itsthenetwork/alpine-tcpdump:latest -v -i eth0 -w /capture/file_name.pcap
