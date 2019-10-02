########################################################
## docker "--net=host"
If a docker container runs with "--net=host", it can bind to the docker bridge gateway ip. Then its service is accessible to containers through gateway ip.

########################################################
## Check status
docker exec consul-bridge_consul_1 consul members -http-addr=http://172.17.0.1:8500
Node         Address          Status  Type    Build  Protocol  DC   Segment
firstconsul  172.17.0.1:8301  alive   server  1.6.1  2         dc1  <all>

docker logs consul-bridge_consul_1
==> Starting Consul agent...
           Version: 'v1.6.1'
           Node ID: '3c2ce5fa-3824-317b-1a44-27b08ae4e2d6'
         Node name: 'firstconsul'
        Datacenter: 'dc1' (Segment: '<all>')
            Server: true (Bootstrap: false)
       Client Addr: [172.17.0.1] (HTTP: 8500, HTTPS: -1, gRPC: 8502, DNS: 53)
      Cluster Addr: 172.17.0.1 (LAN: 8301, WAN: 8302)
           Encrypt: Gossip: false, TLS-Outgoing: false, TLS-Incoming: false, Auto-Encrypt-TLS: false

==> Log data will now stream in as it occurs:

    2019/10/02 09:09:17 [DEBUG] agent: Using random ID "3c2ce5fa-3824-317b-1a44-27b08ae4e2d6" as node ID
    2019/10/02 09:09:17 [DEBUG] tlsutil: Update with version 1
    2019/10/02 09:09:17 [DEBUG] tlsutil: OutgoingRPCWrapper with version 1
    2019/10/02 09:09:17 [INFO]  raft: Initial configuration (index=1): [{Suffrage:Voter ID:3c2ce5fa-3824-317b-1a44-27b08ae4e2d6 Address:172.17.0.1:8300}]
    2019/10/02 09:09:17 [INFO]  raft: Node at 172.17.0.1:8300 [Follower] entering Follower state (Leader: "")
    2019/10/02 09:09:17 [INFO] serf: EventMemberJoin: firstconsul.dc1 172.17.0.1
    2019/10/02 09:09:17 [INFO] serf: EventMemberJoin: firstconsul 172.17.0.1
    2019/10/02 09:09:17 [DEBUG] dns: recursor enabled
    2019/10/02 09:09:17 [INFO] consul: Handled member-join event for server "firstconsul.dc1" in area "wan"
    2019/10/02 09:09:17 [INFO] agent: Started DNS server 172.17.0.1:53 (udp)
    2019/10/02 09:09:17 [INFO] consul: Adding LAN server firstconsul (Addr: tcp/172.17.0.1:8300) (DC: dc1)
    2019/10/02 09:09:17 [DEBUG] dns: recursor enabled
    2019/10/02 09:09:17 [INFO] agent: Started DNS server 172.17.0.1:53 (tcp)
    2019/10/02 09:09:17 [INFO] agent: Started HTTP server on 172.17.0.1:8500 (tcp)
    2019/10/02 09:09:17 [INFO] agent: Started gRPC server on 172.17.0.1:8502 (tcp)
    2019/10/02 09:09:17 [INFO] agent: started state syncer
==> Consul agent running!
    2019/10/02 09:09:17 [WARN]  raft: Heartbeat timeout from "" reached, starting election
    2019/10/02 09:09:17 [INFO]  raft: Node at 172.17.0.1:8300 [Candidate] entering Candidate state in term 2
    2019/10/02 09:09:17 [DEBUG] raft: Votes needed: 1
    2019/10/02 09:09:17 [DEBUG] raft: Vote granted from 3c2ce5fa-3824-317b-1a44-27b08ae4e2d6 in term 2. Tally: 1
    2019/10/02 09:09:17 [INFO]  raft: Election won. Tally: 1
    2019/10/02 09:09:17 [INFO]  raft: Node at 172.17.0.1:8300 [Leader] entering Leader state
    2019/10/02 09:09:17 [INFO] consul: cluster leadership acquired
    2019/10/02 09:09:17 [INFO] consul: New leader elected: firstconsul
    2019/10/02 09:09:17 [INFO] connect: initialized primary datacenter CA with provider "consul"
    2019/10/02 09:09:17 [DEBUG] consul: Skipping self join check for "firstconsul" since the cluster is too small
    2019/10/02 09:09:17 [INFO] consul: member 'firstconsul' joined, marking health alive
    2019/10/02 09:09:18 [DEBUG] agent: Skipping remote check "serfHealth" since it is managed automatically
    2019/10/02 09:09:18 [INFO] agent: Synced node info
    2019/10/02 09:09:18 [DEBUG] agent: Node info in sync
    2019/10/02 09:09:18 [DEBUG] agent: Skipping remote check "serfHealth" since it is managed automatically
    2019/10/02 09:09:18 [DEBUG] agent: Node info in sync
    2019/10/02 09:09:19 [DEBUG] tlsutil: OutgoingRPCWrapper with version 1
    2019/10/02 09:10:17 [DEBUG] consul: Skipping self join check for "firstconsul" since the cluster is too small
    2019/10/02 09:10:56 [DEBUG] agent: Skipping remote check "serfHealth" since it is managed automatically
    2019/10/02 09:10:56 [DEBUG] agent: Node info in sync
    2019/10/02 09:11:17 [DEBUG] manager: Rebalanced 1 servers, next active server is firstconsul.dc1 (Addr: tcp/172.17.0.1:8300) (DC: dc1)
    2019/10/02 09:11:17 [DEBUG] consul: Skipping self join check for "firstconsul" since the cluster is too small
    2019/10/02 09:11:35 [DEBUG] http: Request GET /v1/agent/members?segment=_all (790.589µs) from=10.175.5.83:36106

########################################################
## Check the DNS service
docker exec consul-bridge_client_1 dig @172.17.0.1 -p 53 consul.service.consul SRV

docker exec consul-bridge_client_1 dig consul.service.consul SRV
