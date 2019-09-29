htpasswd -bc user.wd admin admin

docker run -it --rm --net=container:prometheus-demo_actuator_1 -v /var/tmp:/capture itsthenetwork/alpine-tcpdump:latest -v -i eth0 -w /capture/file_name.pcap
