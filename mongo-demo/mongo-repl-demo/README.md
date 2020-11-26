# MongoDB Demo

## Use MongoDB shell to call rs.initiate()

sudo docker exec -it mongo-repl-demo_repl01_1 mongo

```
rs.initiate( {
   _id : "myrepl",
   members: [
      { _id: 0, host: "repl01:27017" },
      { _id: 1, host: "repl02:27017" },
      { _id: 2, host: "repl03:27017" }
   ]
})
```

```
{
        "ok" : 1,
        "$clusterTime" : {
                "clusterTime" : Timestamp(1606402815, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        },
        "operationTime" : Timestamp(1606402815, 1)
}
```

myrepl:SECONDARY>


```
rs.conf()
{
        "_id" : "myrepl",
        "version" : 1,
        "protocolVersion" : NumberLong(1),
        "writeConcernMajorityJournalDefault" : true,
        "members" : [
                {
                        "_id" : 0,
                        "host" : "repl01:27017",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 1,
                        "host" : "repl02:27017",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 2,
                        "host" : "repl03:27017",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                }
        ],
        "settings" : {
                "chainingAllowed" : true,
                "heartbeatIntervalMillis" : 2000,
                "heartbeatTimeoutSecs" : 10,
                "electionTimeoutMillis" : 10000,
                "catchUpTimeoutMillis" : -1,
                "catchUpTakeoverDelayMillis" : 30000,
                "getLastErrorModes" : {

                },
                "getLastErrorDefaults" : {
                        "w" : 1,
                        "wtimeout" : 0
                },
                "replicaSetId" : ObjectId("5fbfc2ffd59a6774da0988c4")
        }
}
```

```
rs.status()
{
        "set" : "myrepl",
        "date" : ISODate("2020-11-26T15:02:19.803Z"),
        "myState" : 1,
        "term" : NumberLong(1),
        "syncingTo" : "",
        "syncSourceHost" : "",
        "syncSourceId" : -1,
        "heartbeatIntervalMillis" : NumberLong(2000),
        "majorityVoteCount" : 2,
        "writeMajorityCount" : 2,
        "optimes" : {
                "lastCommittedOpTime" : {
                        "ts" : Timestamp(1606402935, 1),
                        "t" : NumberLong(1)
                },
                "lastCommittedWallTime" : ISODate("2020-11-26T15:02:15.955Z"),
                "readConcernMajorityOpTime" : {
                        "ts" : Timestamp(1606402935, 1),
                        "t" : NumberLong(1)
                },
                "readConcernMajorityWallTime" : ISODate("2020-11-26T15:02:15.955Z"),
                "appliedOpTime" : {
                        "ts" : Timestamp(1606402935, 1),
                        "t" : NumberLong(1)
                },
                "durableOpTime" : {
                        "ts" : Timestamp(1606402935, 1),
                        "t" : NumberLong(1)
                },
                "lastAppliedWallTime" : ISODate("2020-11-26T15:02:15.955Z"),
                "lastDurableWallTime" : ISODate("2020-11-26T15:02:15.955Z")
        },
        "lastStableRecoveryTimestamp" : Timestamp(1606402885, 1),
        "lastStableCheckpointTimestamp" : Timestamp(1606402885, 1),
        "electionCandidateMetrics" : {
                "lastElectionReason" : "electionTimeout",
                "lastElectionDate" : ISODate("2020-11-26T15:00:25.940Z"),
                "electionTerm" : NumberLong(1),
                "lastCommittedOpTimeAtElection" : {
                        "ts" : Timestamp(0, 0),
                        "t" : NumberLong(-1)
                },
                "lastSeenOpTimeAtElection" : {
                        "ts" : Timestamp(1606402815, 1),
                        "t" : NumberLong(-1)
                },
                "numVotesNeeded" : 2,
                "priorityAtElection" : 1,
                "electionTimeoutMillis" : NumberLong(10000),
                "numCatchUpOps" : NumberLong(0),
                "newTermStartDate" : ISODate("2020-11-26T15:00:25.953Z"),
                "wMajorityWriteAvailabilityDate" : ISODate("2020-11-26T15:00:26.656Z")
        },
        "members" : [
                {
                        "_id" : 0,
                        "name" : "repl01:27017",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "uptime" : 192,
                        "optime" : {
                                "ts" : Timestamp(1606402935, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2020-11-26T15:02:15Z"),
                        "syncingTo" : "",
                        "syncSourceHost" : "",
                        "syncSourceId" : -1,
                        "infoMessage" : "could not find member to sync from",
                        "electionTime" : Timestamp(1606402825, 1),
                        "electionDate" : ISODate("2020-11-26T15:00:25Z"),
                        "configVersion" : 1,
                        "self" : true,
                        "lastHeartbeatMessage" : ""
                },
                {
                        "_id" : 1,
                        "name" : "repl02:27017",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 124,
                        "optime" : {
                                "ts" : Timestamp(1606402935, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1606402935, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2020-11-26T15:02:15Z"),
                        "optimeDurableDate" : ISODate("2020-11-26T15:02:15Z"),
                        "lastHeartbeat" : ISODate("2020-11-26T15:02:17.946Z"),
                        "lastHeartbeatRecv" : ISODate("2020-11-26T15:02:18.646Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncingTo" : "repl01:27017",
                        "syncSourceHost" : "repl01:27017",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1
                },
                {
                        "_id" : 2,
                        "name" : "repl03:27017",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 124,
                        "optime" : {
                                "ts" : Timestamp(1606402935, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1606402935, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2020-11-26T15:02:15Z"),
                        "optimeDurableDate" : ISODate("2020-11-26T15:02:15Z"),
                        "lastHeartbeat" : ISODate("2020-11-26T15:02:17.945Z"),
                        "lastHeartbeatRecv" : ISODate("2020-11-26T15:02:18.646Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncingTo" : "repl01:27017",
                        "syncSourceHost" : "repl01:27017",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1
                }
        ],
        "ok" : 1,
        "$clusterTime" : {
                "clusterTime" : Timestamp(1606402935, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        },
        "operationTime" : Timestamp(1606402935, 1)
}
```

## http://127.0.0.1:8081/

Turn on admin in config.js to view server stats!

## Access the cluster on the slave node

sudo docker exec -it mongo-repl-demo_repl02_1 mongo

```
myrepl:SECONDARY> db.foo
test.foo
myrepl:SECONDARY> db.foo.find()
Error: error: {
        "operationTime" : Timestamp(1606405296, 1),
        "ok" : 0,
        "errmsg" : "not master and slaveOk=false",
        "code" : 13435,
        "codeName" : "NotPrimaryNoSecondaryOk",
        "$clusterTime" : {
                "clusterTime" : Timestamp(1606405296, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        }
}
myrepl:SECONDARY>
```

