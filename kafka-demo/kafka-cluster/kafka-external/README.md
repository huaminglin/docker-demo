# Show how a broker joins others with different network

## inter.broker.listener.name

"KAFKA_INTER_BROKER_LISTENER_NAME: OUTSIDE" vs. "KAFKA_INTER_BROKER_LISTENER_NAME: INTERNAL"

If the brokers are on different network, how a broker communicate with another in the same/different network.

## Use kafkacat to check the external broker

sudo docker exec -it kafkacat kafkacat -L -b $MY_HOST_IP:9170

% ERROR: Failed to acquire metadata: Local: Timed out

Note: Have no idea why kafkacat can't connect to this external broker.

Solution: all the brokers use external listeners. (Ideally, brokers in the same network should use internal listener)
