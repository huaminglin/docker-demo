###################################################################################
## consul agent
==> Multiple private IPv4 addresses found. Please configure one with 'bind' and/or 'advertise'.

###################################################################################
## consul agent -dns-port=53 -bind=127.0.0.1
Error starting agent: 2 errors occurred:
	* listen udp 127.0.0.1:53: bind: permission denied
	* listen tcp 127.0.0.1:53: bind: permission denied

###################################################################################
## export CONSUL_ALLOW_PRIVILEGED_PORTS="" & consul agent -dns-port=53 -bind=127.0.0.1
    2019/10/01 08:57:16 [INFO] serf: EventMemberJoin: user1-VirtualBox 127.0.0.1
    2019/10/01 08:57:16 [INFO] agent: Started DNS server 127.0.0.1:53 (tcp)
    2019/10/01 08:57:16 [INFO] agent: Started DNS server 127.0.0.1:53 (udp)
    2019/10/01 08:57:16 [INFO] agent: Started HTTP server on 127.0.0.1:8500 (tcp)
    2019/10/01 08:57:16 [INFO] agent: started state syncer

