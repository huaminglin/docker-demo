# Demo hazelcast features

## Configure Hazelcast Cluster for HMC

It seems that "MANCENTER_URL" is only available for Hazelcast Enterprise since HMC is only available for Enterprise.

We can register the cluster to HMC manually.


http://127.0.0.1:17080/manage-clusters

"Member Addresses" field support multiple hosts, so after typing host name, "ENTER" to confirm the input.

## Run script from Hazelcast Management Center

http://127.0.0.1:17080/hazelcast-mancenter/dev/scripting

## Setup Groovy Script Engine


mvn dependency:get -Dartifact=org.codehaus.groovy:groovy:3.0.4 -Dtransitive=false

mvn dependency:get -Dartifact=org.codehaus.groovy:groovy-jsr223:3.0.4 -Dtransitive=false

$HOME/.m2/repository/org/codehaus/groovy/groovy/3.0.4/groovy-3.0.4.jar
$HOME/.m2/repository/org/codehaus/groovy/groovy-jsr223/3.0.4/groovy-jsr223-3.0.4.jar

The support for script execution is disabled by default. The reason is security.

```Groovy
hazelcast.getMap("m1").put("a", 123);
hazelcast.getMap("m1").get("a").toString();
```

## Logging

LOGGING_LEVEL=FINEST

## HMC console to interact with the cluster

http://127.0.0.1:17080/dev/console

## MulticastJoiner is used to create cluster by default

com.hazelcast.internal.cluster.impl.MulticastJoiner

## tcpdump

cat hazelcast-demo_server01_1.pcap | tcpdump -n -r - net 192.168.160.0/24 -w $HOME/hazelcast-demo_server01_1.pcap

```pcap
22:05:29.410586 IP (tos 0x0, ttl 32, id 27839, offset 0, flags [DF], proto UDP (17), length 269)
    192.168.160.3.54327 > 224.2.2.3.54327: [bad udp cksum 0x43bc -> 0xce3f!] UDP, length 241
```

224.2.2.3.54327 is multicast address.

## Lock and connection liveness

Note:

Only one active HMC is allowed.

"docker attach" attach to the main process inside the container.

We can enter to the console.

"exit" will also exit the main process.

Step 1: client01 acquire the lock "lock01"

sudo docker attach hazelcast-demo_client01_1

Input "help" and enter to view available commands.

Input "lock lock01" to acquire a lock.

Step 2: client02 acquire the lock "lock01" but is blocked

sudo docker attach hazelcast-demo_client02_1

Input "help" and enter to view available commands.

Input "lock lock01" to acquire a lock. This action will be blocked untile client01 release the lock.

Step 3: Stop client01 and check whether client02 can acquire the lock

sudo docker stop hazelcast-demo_client01_1

Fact 01: client02 can't acquire the lock after the client01 is killed.


Conclusion by "Fact 01":

"Locks are fail-safe. If a member holds a lock and some other members go down, the cluster will keep your locks safe and available. Moreover, when a member leaves the cluster, all the locks acquired by that dead member will be removed so that those locks are immediately available for live members."

Keep attention to the word "member".

This means embed mode, not the client/server mode.

Fact 02: Several minutes later, the client02 does acquire the lock.

Conclusion by "Fact 02":

Hazelcast cluster does have a mechanism to check the client liveness and release the related lock.

From the HMC page, the client disappear seconds later after the container closes. Anyway, if the client comes back, HMC can show it again without harm.

From the HMC page, we can know every client connection has a UUID.

It can take minutes to verify a TCP connection is lost. The cluster has to unlock the lost connection with cautions.


## How client keep TCP connection active

```pcap
tcpdump -tt -r hazelcast-demo_client02_1.pcap src 172.31.0.6 and dst 172.31.0.2
reading from file hazelcast-demo_client02_1.pcap, link-type EN10MB (Ethernet)
1593696966.029910 IP 172.31.0.6.34215 > 172.31.0.2.5701: Flags [P.], seq 480087775:480087851, ack 1795827304, win 501, options [nop,nop,TS val 3067602435 ecr 1050877688], length 76
1593696966.031558 IP 172.31.0.6.34215 > 172.31.0.2.5701: Flags [.], ack 20, win 501, options [nop,nop,TS val 3067602436 ecr 1050882687], length 0
1593696971.029897 IP 172.31.0.6.34215 > 172.31.0.2.5701: Flags [P.], seq 76:152, ack 20, win 501, options [nop,nop,TS val 3067607435 ecr 1050882687], length 76
1593696971.031768 IP 172.31.0.6.34215 > 172.31.0.2.5701: Flags [.], ack 39, win 501, options [nop,nop,TS val 3067607437 ecr 1050887688], length 0
1593696976.029924 IP 172.31.0.6.34215 > 172.31.0.2.5701: Flags [P.], seq 152:228, ack 39, win 501, options [nop,nop,TS val 3067612435 ecr 1050887688], length 76
1593696976.032396 IP 172.31.0.6.34215 > 172.31.0.2.5701: Flags [.], ack 58, win 501, options [nop,nop,TS val 3067612437 ecr 1050892688], length 0
1593696981.029909 IP 172.31.0.6.34215 > 172.31.0.2.5701: Flags [P.], seq 228:304, ack 58, win 501, options [nop,nop,TS val 3067617435 ecr 1050892688], length 76
1593696981.031800 IP 172.31.0.6.34215 > 172.31.0.2.5701: Flags [.], ack 77, win 501, options [nop,nop,TS val 3067617437 ecr 1050897688], length 0
1593696986.029894 IP 172.31.0.6.34215 > 172.31.0.2.5701: Flags [P.], seq 304:380, ack 77, win 501, options [nop,nop,TS val 3067622435 ecr 1050897688], length 76
1593696986.031792 IP 172.31.0.6.34215 > 172.31.0.2.5701: Flags [.], ack 96, win 501, options [nop,nop,TS val 3067622437 ecr 1050902688], length 0
1593696986.736909 IP 172.31.0.6.34215 > 172.31.0.2.5701: Flags [.], ack 1270, win 501, options [nop,nop,TS val 3067623142 ecr 1050903393], length 0
1593696986.737178 IP 172.31.0.6.34215 > 172.31.0.2.5701: Flags [.], ack 1518, win 501, options [nop,nop,TS val 3067623142 ecr 1050903393], length 0
```

The client sends a package with PSH flat to server every 5 seconds.

## hazelcast.local.publicAddress

Customized public address ip for server01: -Dhazelcast.local.publicAddress=server01:5701

```log
Members {size:2, ver:2} [
        Member [server01]:5701 - 8193eb1d-8fbc-4b6d-ad1f-e4d65cb49969 this
        Member [172.25.0.3]:5701 - c7e5c5c5-9903-4006-a509-e80d52a36d26
]
```

From the log, publicAddress is used for member list info; The default is to use host ip as member.
