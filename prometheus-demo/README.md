htpasswd -bc user.wd admin admin

docker run -it --rm --net=container:prometheus-demo_actuator_1 -v /var/tmp:/capture itsthenetwork/alpine-tcpdump:latest -v -i eth0 -w /capture/file_name.pcap

#########################################################################
## grafana
http://localhost:3000/login
admin/admin

Add data source

#########################################################################
## cAdvisor web UI
http://localhost:8070/
