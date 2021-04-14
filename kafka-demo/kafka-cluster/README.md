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

## Unable to parse INTERNAL://kafka01:9090" to a broker endpoint

```
[2021-04-14 16:57:24,359] ERROR Fatal error during SupportedServerStartable startup. Prepare to shutdown (io.confluent.support.metrics.SupportedKafka)
java.lang.IllegalArgumentException: Error creating broker listeners from 'INTERNAL://kafka01:9090"': Unable to parse INTERNAL://kafka01:9090" to a broker endpoint
        at kafka.utils.CoreUtils$.listenerListToEndPoints(CoreUtils.scala:289)
        at kafka.server.KafkaConfig.$anonfun$listeners$1(KafkaConfig.scala:1630)
        at kafka.server.KafkaConfig.listeners(KafkaConfig.scala:1629)
        at kafka.server.KafkaConfig.validateValues(KafkaConfig.scala:1729)
        at kafka.server.KafkaConfig.<init>(KafkaConfig.scala:1706)
        at kafka.server.KafkaConfig.<init>(KafkaConfig.scala:1270)
        at kafka.server.KafkaConfig$.fromProps(KafkaConfig.scala:1218)
        at kafka.server.KafkaConfig$.fromProps(KafkaConfig.scala:1215)
        at kafka.server.KafkaConfig.fromProps(KafkaConfig.scala)
        at io.confluent.support.metrics.SupportedServerStartable.<init>(SupportedServerStartable.java:52)
        at io.confluent.support.metrics.SupportedKafka.main(SupportedKafka.java:45)
Caused by: org.apache.kafka.common.KafkaException: Unable to parse INTERNAL://kafka01:9090" to a broker endpoint
        at kafka.cluster.EndPoint$.createEndPoint(EndPoint.scala:57)
        at kafka.utils.CoreUtils$.$anonfun$listenerListToEndPoints$6(CoreUtils.scala:286)
        at scala.collection.TraversableLike.$anonfun$map$1(TraversableLike.scala:238)
        at scala.collection.IndexedSeqOptimized.foreach(IndexedSeqOptimized.scala:36)
        at scala.collection.IndexedSeqOptimized.foreach$(IndexedSeqOptimized.scala:33)
        at scala.collection.mutable.WrappedArray.foreach(WrappedArray.scala:38)
        at scala.collection.TraversableLike.map(TraversableLike.scala:238)
        at scala.collection.TraversableLike.map$(TraversableLike.scala:231)
        at scala.collection.AbstractTraversable.map(Traversable.scala:108)
        at kafka.utils.CoreUtils$.listenerListToEndPoints(CoreUtils.scala:286)
        ... 10 more
```

Conclusion: The problem is '"" character. A typo.


```
[2021-04-14 17:00:12,530] ERROR Fatal error during SupportedServerStartable startup. Prepare to shutdown (io.confluent.support.metrics.SupportedKafka)
java.lang.IllegalArgumentException: requirement failed: inter.broker.listener.name must be a listener name defined in advertised.listeners. The valid options based on currently configured listeners are OUTSIDE
        at kafka.server.KafkaConfig.validateValues(KafkaConfig.scala:1731)
        at kafka.server.KafkaConfig.<init>(KafkaConfig.scala:1706)
        at kafka.server.KafkaConfig.<init>(KafkaConfig.scala:1270)
        at kafka.server.KafkaConfig$.fromProps(KafkaConfig.scala:1218)
        at kafka.server.KafkaConfig$.fromProps(KafkaConfig.scala:1215)
        at kafka.server.KafkaConfig.fromProps(KafkaConfig.scala)
        at io.confluent.support.metrics.SupportedServerStartable.<init>(SupportedServerStartable.java:52)
        at io.confluent.support.metrics.SupportedKafka.main(SupportedKafka.java:45)
```

Question: If inter.broker.listener.name must be a listener name defined in advertised.listeners, in which case we need to define a for KAFKA_LISTENERS but not for KAFKA_ADVERTISED_LISTENERS?

## Client from external network

sudo docker run --rm -it confluentinc/cp-kafkacat:5.5.2 kafkacat -L -b $MY_HOST_IP:9092

```
Metadata for all topics (from broker -1: 10.0.0.211:9092/bootstrap):
 2 brokers:
  broker 1001 at kafka01:9092
  broker 1002 at kafka02:9093
 1 topics:
  topic "__confluent.support.metrics" with 1 partitions:
    partition 0, leader 1001, replicas: 1001,1002, isrs: 1001,1002
```


9092 is exposed for clients on the docker host.
When connecting to a broker, the listener that will be returned to the client will be the listener to which you connected (based on the port).

Question: If a client connects to 9092 on kafka01, can the client be redirected to 9093 on kafka02?
Can kafka01 use kafka02 in its KAFKA_ADVERTISED_LISTENERS?
