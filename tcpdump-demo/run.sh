#!/usr/bin/env bash

cd $(dirname $0)

target_container=$1

if [ -z "$1" ]; then
    echo "Please input the target container as the first parameter."
    exit 1
fi

if [ -f /var/tmp/$1.pcap ]; then
    sudo rm /var/tmp/$1.pcap
fi
touch /var/tmp/$1.pcap
wireshark -k -i <(tail -f -c +0 /var/tmp/$1.pcap) &
sudo docker run -it --rm --net=container:$1 -v /var/tmp:/capture corfr/tcpdump -v -i eth0 -w /capture/$1.pcap
