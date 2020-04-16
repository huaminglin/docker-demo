# Kafka REST Proxy

## Configuration tip

ZooKeeper to expose Kafka endpoints which has high priority than kafka-rest.properties: bootstrap.servers.
So KAFKA_REST_ZOOKEEPER_CONNECT also affect the bootstrap.servers which is read from zookeeper server.


## /etc/kafka-rest/kafka-rest.properties

ENVs like KAFKA_ZOOKEEPER_CONNECT ared used to overwrite kafka-rest.properties.

schema.registry.url=http://schema-registry:8081
zookeeper.connect=zookeeper:2181
host.name=kafka-rest

## /topics

http://127.0.0.1:8082/topics
["__confluent.support.metrics"]

http://127.0.0.1:8082/topics/__confluent.support.metrics
{
	"name" : "__confluent.support.metrics",
	"configs" : {
		"message.downconversion.enable" : "true",
		"file.delete.delay.ms" : "60000",
		"segment.ms" : "604800000",
		"min.compaction.lag.ms" : "0",
		"retention.bytes" : "-1",
		"segment.index.bytes" : "10485760",
		"cleanup.policy" : "delete",
		"follower.replication.throttled.replicas" : "",
		"message.timestamp.difference.max.ms" : "9223372036854775807",
		"segment.jitter.ms" : "0",
		"preallocate" : "false",
		"message.timestamp.type" : "CreateTime",
		"message.format.version" : "2.0-IV1",
		"segment.bytes" : "1073741824",
		"unclean.leader.election.enable" : "false",
		"max.message.bytes" : "1000012",
		"retention.ms" : "31536000000",
		"flush.ms" : "9223372036854775807",
		"delete.retention.ms" : "86400000",
		"leader.replication.throttled.replicas" : "",
		"min.insync.replicas" : "1",
		"flush.messages" : "9223372036854775807",
		"compression.type" : "producer",
		"index.interval.bytes" : "4096",
		"min.cleanable.dirty.ratio" : "0.5"
	},
	"partitions" : [{
			"partition" : 0,
			"leader" : 1001,
			"replicas" : [{
					"broker" : 1001,
					"leader" : true,
					"in_sync" : true
				}
			]
		}
	]
}

