# MongoDB Demo

## MongoDB shell

docker exec -it mongo-demo_client_1 mongo server/mydemo

```
MongoDB shell version v4.2.11
connecting to: mongodb://server:27017/mydemo?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("c6e20c70-61dd-48bf-8d15-5b41b0e47552") }
MongoDB server version: 4.2.11
>
```

## MongoDB help

docker exec -it mongo-demo_client_1 mongo --help > mongo.help

## MongoDB logs

docker logs mongo-demo_server_1 > mongo-demo_server_1.logs

docker exec mongo-demo_server_1 cat /proc/1/cmdline

mongod --auth --bind_ip_all
