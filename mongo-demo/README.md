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


##

```
Server is open to allow connections from anyone (0.0.0.0)
basicAuth credentials are "admin:pass", it is recommended you change this in your config.js!

/node_modules/mongodb/lib/server.js:265
        process.nextTick(function() { throw err; })
                                      ^
Error [MongoError]: failed to connect to server [server:27017] on first connect
    at Pool.<anonymous> (/node_modules/mongodb-core/lib/topologies/server.js:326:35)
    at Pool.emit (events.js:314:20)
    at Connection.<anonymous> (/node_modules/mongodb-core/lib/connection/pool.js:270:12)
    at Object.onceWrapper (events.js:421:26)
    at Connection.emit (events.js:314:20)
    at Socket.<anonymous> (/node_modules/mongodb-core/lib/connection/connection.js:175:49)
    at Object.onceWrapper (events.js:421:26)
    at Socket.emit (events.js:314:20)
    at emitErrorNT (internal/streams/destroy.js:92:8)
    at emitErrorAndCloseNT (internal/streams/destroy.js:60:3)
Server is open to allow connections from anyone (0.0.0.0)
basicAuth credentials are "admin:pass", it is recommended you change this in your config.js!
unable to list databases
Error [MongoError]: command listDatabases requires authentication
    at Function.MongoError.create (/node_modules/mongodb-core/lib/error.js:31:11)
    at /node_modules/mongodb-core/lib/connection/pool.js:483:72
    at authenticateStragglers (/node_modules/mongodb-core/lib/connection/pool.js:429:16)
    at Connection.messageHandler (/node_modules/mongodb-core/lib/connection/pool.js:463:5)
    at Socket.<anonymous> (/node_modules/mongodb-core/lib/connection/connection.js:319:22)
    at Socket.emit (events.js:314:20)
    at addChunk (_stream_readable.js:298:12)
    at readableAddChunk (_stream_readable.js:273:9)
    at Socket.Readable.push (_stream_readable.js:214:10)
    at TCP.onStreamRead (internal/stream_base_commons.js:188:23) {
  ok: 0,
  errmsg: 'command listDatabases requires authentication',
  code: 13,
  codeName: 'Unauthorized'
}
```

## http://127.0.0.1:8081/

Turn on admin in config.js to view server stats!
