http://127.0.0.1:15672/

docker exec -it rabbitmq bash

rabbitmqadmin list users
rabbitmqadmin list bindings
rabbitmqadmin list queues
rabbitmqadmin list exchanges

rabbitmqadmin declare queue name=test durable=true
rabbitmqadmin publish routing_key=test payload="test message1"
rabbitmqadmin get queue=test

rabbitmqadmin declare exchange name=my.topic type=topic
rabbitmqadmin declare binding source=my.topic destination=test routing_key=first
rabbitmqadmin publish routing_key=first exchange=my.topic payload="test message1"

