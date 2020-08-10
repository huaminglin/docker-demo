#!/usr/bin/env bash

# This script is used to monitor network tracfic on the container network.
# So we can run the target application in container and analyze its network behavior.

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
sudo docker run -it --rm --net=container:$1 -v /var/tmp:/capture nicolaka/netshoot tcpdump  -v -i eth0 -w /capture/$1.pcap
