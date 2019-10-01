###################################################################################
## docker run --rm consul
==> Starting Consul agent...
           Version: 'v1.6.1'
           Node ID: '6bc926e6-0cdc-ffaf-5633-f8a9ab88d3c4'
         Node name: '641a843fcf74'
        Datacenter: 'dc1' (Segment: '<all>')
            Server: true (Bootstrap: false)
       Client Addr: [0.0.0.0] (HTTP: 8500, HTTPS: -1, gRPC: 8502, DNS: 8600)
      Cluster Addr: 127.0.0.1 (LAN: 8301, WAN: 8302)
           Encrypt: Gossip: false, TLS-Outgoing: false, TLS-Incoming: false, Auto-Encrypt-TLS: false

==> Log data will now stream in as it occurs:

    2019/10/01 10:19:31 [DEBUG] agent: Using random ID "6bc926e6-0cdc-ffaf-5633-f8a9ab88d3c4" as node ID
    2019/10/01 10:19:32 [DEBUG] tlsutil: Update with version 1
    2019/10/01 10:19:32 [DEBUG] tlsutil: OutgoingRPCWrapper with version 1
    2019/10/01 10:19:32 [INFO]  raft: Initial configuration (index=1): [{Suffrage:Voter ID:6bc926e6-0cdc-ffaf-5633-f8a9ab88d3c4 Address:127.0.0.1:8300}]
    2019/10/01 10:19:32 [INFO]  raft: Node at 127.0.0.1:8300 [Follower] entering Follower state (Leader: "")
    2019/10/01 10:19:32 [INFO] serf: EventMemberJoin: 641a843fcf74.dc1 127.0.0.1
    2019/10/01 10:19:32 [INFO] serf: EventMemberJoin: 641a843fcf74 127.0.0.1
    2019/10/01 10:19:32 [INFO] agent: Started DNS server 0.0.0.0:8600 (udp)
    2019/10/01 10:19:32 [INFO] consul: Adding LAN server 641a843fcf74 (Addr: tcp/127.0.0.1:8300) (DC: dc1)
    2019/10/01 10:19:32 [INFO] consul: Handled member-join event for server "641a843fcf74.dc1" in area "wan"
    2019/10/01 10:19:32 [INFO] agent: Started DNS server 0.0.0.0:8600 (tcp)
    2019/10/01 10:19:32 [INFO] agent: Started HTTP server on [::]:8500 (tcp)
    2019/10/01 10:19:32 [INFO] agent: Started gRPC server on [::]:8502 (tcp)
    2019/10/01 10:19:32 [INFO] agent: started state syncer
==> Consul agent running!
    2019/10/01 10:19:32 [WARN]  raft: Heartbeat timeout from "" reached, starting election
    2019/10/01 10:19:32 [INFO]  raft: Node at 127.0.0.1:8300 [Candidate] entering Candidate state in term 2
    2019/10/01 10:19:32 [DEBUG] raft: Votes needed: 1
    2019/10/01 10:19:32 [DEBUG] raft: Vote granted from 6bc926e6-0cdc-ffaf-5633-f8a9ab88d3c4 in term 2. Tally: 1
    2019/10/01 10:19:32 [INFO]  raft: Election won. Tally: 1
    2019/10/01 10:19:32 [INFO]  raft: Node at 127.0.0.1:8300 [Leader] entering Leader state
    2019/10/01 10:19:32 [INFO] consul: cluster leadership acquired
    2019/10/01 10:19:32 [INFO] consul: New leader elected: 641a843fcf74
    2019/10/01 10:19:32 [INFO] connect: initialized primary datacenter CA with provider "consul"
    2019/10/01 10:19:32 [DEBUG] consul: Skipping self join check for "641a843fcf74" since the cluster is too small
    2019/10/01 10:19:32 [INFO] consul: member '641a843fcf74' joined, marking health alive
    2019/10/01 10:19:32 [DEBUG] agent: Skipping remote check "serfHealth" since it is managed automatically
    2019/10/01 10:19:32 [INFO] agent: Synced node info
    2019/10/01 10:19:32 [DEBUG] agent: Node info in sync
    2019/10/01 10:19:34 [DEBUG] tlsutil: OutgoingRPCWrapper with version 1
    2019/10/01 10:19:34 [DEBUG] agent: Skipping remote check "serfHealth" since it is managed automatically
    2019/10/01 10:19:34 [DEBUG] agent: Node info in sync

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

###################################################################################
## http://127.0.0.1:8500/
Consul Agent

docker exec consul-host_consul_1 consul members
Node         Address         Status  Type    Build  Protocol  DC   Segment
firstconsul  127.0.0.1:8301  alive   server  1.6.1  2         dc1  <all>

###############################################################33
## docker exec -it consul-host_client_1 bash
docker exec consul-host_client_1 dig @127.0.0.1 -p 53 firstconsul.node.consul ANY

docker exec consul-host_client_1 dig @127.0.0.1 -p 53 web.service.consul SRV

