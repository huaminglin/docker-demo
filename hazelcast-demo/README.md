# Demo hazelcast features

## Configure Hazelcast Cluster for HMC

It seems that "MANCENTER_URL" is only available for Hazelcast Enterprise since HMC is only available for Enterprise.

We can register the cluster to HMC manually.

http://127.0.0.1:17080/manage-clusters

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
