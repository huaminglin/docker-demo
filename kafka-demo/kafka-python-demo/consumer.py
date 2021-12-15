from kafka import KafkaConsumer

consumer = KafkaConsumer('user-details', bootstrap_servers='127.0.0.1:9092', auto_offset_reset='earliest', group_id='test05')

for message in consumer:
    # print(type(message))
    # print(dir(message))
    print(message)
