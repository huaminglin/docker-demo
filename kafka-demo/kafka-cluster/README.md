# Kafka Cluster

## Create a topic with multiple partitions

sudo docker exec -it kafka-cluster_kafka01_1 /bin/bash -c 'kafka-topics --create --topic mytopic3 --zookeeper kafka-cluster_zookeeper_1:2181 --replication-factor 2 --partitions 10'

## Publish message

sudo docker exec -it kafkacat kafkacat -P -b $MY_HOST_IP:9070 -t mytopic3

## Consume message

sudo docker exec -it kafkacat kafkacat -C -b $MY_HOST_IP:9080 -t mytopic3

sudo docker exec -it kafka-cluster_kafka01_1 /bin/bash -c "kafka-console-consumer --bootstrap-server $MY_HOST_IP:9170 --consumer-property client.id=abc --group kafka-intro --topic mytopic3"

sudo docker exec -it kafka-cluster_kafka01_1 /bin/bash -c "kafka-console-consumer --bootstrap-server $MY_HOST_IP:9170 --consumer-property client.id=abc02 --group kafka-intro --topic mytopic3"


## List consumer groups

sudo docker exec -it kafka-cluster_kafka01_1 /bin/bash -c "kafka-consumer-groups --bootstrap-server $MY_HOST_IP:9170 --list"

```
kafka-intro
demo
```

Note: "kafkacat -C" consumer is not in the list. Weird.


## Check the group for a given consumer

sudo docker exec -it kafka-cluster_kafka01_1 /bin/bash -c "kafka-consumer-groups --bootstrap-server $MY_HOST_IP:9170  --describe --group kafka-intro"

```
GROUP           TOPIC           PARTITION  CURRENT-OFFSET  LOG-END-OFFSET  LAG             CONSUMER-ID                                                 HOST            CLIENT-ID
kafka-intro     mytopic3        0          1               1               0               abc-ed820380-da82-44cd-b2c5-f0d9ee59fa16                    /172.24.0.1     abc
kafka-intro     mytopic3        1          0               0               0               abc-ed820380-da82-44cd-b2c5-f0d9ee59fa16                    /172.24.0.1     abc
kafka-intro     mytopic3        2          0               0               0               abc-ed820380-da82-44cd-b2c5-f0d9ee59fa16                    /172.24.0.1     abc
kafka-intro     mytopic3        3          1               1               0               abc-ed820380-da82-44cd-b2c5-f0d9ee59fa16                    /172.24.0.1     abc
kafka-intro     mytopic3        4          1               1               0               abc02-c0e5077d-bb2f-4bd6-9038-22a589fa2d10                  /172.24.0.1     abc02
kafka-intro     mytopic3        5          0               0               0               abc02-c0e5077d-bb2f-4bd6-9038-22a589fa2d10                  /172.24.0.1     abc02
kafka-intro     mytopic3        6          0               0               0               abc02-c0e5077d-bb2f-4bd6-9038-22a589fa2d10                  /172.24.0.1     abc02
kafka-intro     mytopic3        7          1               1               0               consumer-kafka-intro-1-7984e165-f9cc-4d19-a025-dd292841cd6d /x.x.x.x     consumer-kafka-intro-1
kafka-intro     mytopic3        8          1               1               0               consumer-kafka-intro-1-7984e165-f9cc-4d19-a025-dd292841cd6d /x.x.x.x     consumer-kafka-intro-1
kafka-intro     mytopic3        9          1               1               0               consumer-kafka-intro-1-7984e165-f9cc-4d19-a025-dd292841cd6d /x.x.x.x     consumer-kafka-intro-1
```

Conclusion: The first consumer will take all the partitions; The second consumer will take part of the partitions from the first consumer.

So the Kafka consumer can response to the change of the topic topology; check ConsumerCoordinator for more detail.
