# JFR demo

##

docker exec -it demojfr jcmd 1 JFR.start name=demo filename=/jfr/demojfr.jfr

```
1:
Started recording 1. No limit specified, using maxsize=250MB as default.

Use jcmd 1 JFR.dump name=demo to copy recording data to file.
```

ab -c 10 -n 1000 http://localhost:18030/
```
This is ApacheBench, Version 2.3 <$Revision: 1807734 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient)
Completed 100 requests
Completed 200 requests
Completed 300 requests
Completed 400 requests
Completed 500 requests
Completed 600 requests
Completed 700 requests
Completed 800 requests
Completed 900 requests
Completed 1000 requests
Finished 1000 requests


Server Software:
Server Hostname:        localhost
Server Port:            18030

Document Path:          /
Document Length:        682 bytes

Concurrency Level:      10
Time taken for tests:   1.908 seconds
Complete requests:      1000
Failed requests:        0
Non-2xx responses:      1000
Total transferred:      837000 bytes
HTML transferred:       682000 bytes
Requests per second:    524.17 [#/sec] (mean)
Time per request:       19.078 [ms] (mean)
Time per request:       1.908 [ms] (mean, across all concurrent requests)
Transfer rate:          428.45 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   1.6      0      37
Processing:     2   18  50.9     11     525
Waiting:        2   16  49.0      9     498
Total:          3   19  51.0     11     526

Percentage of the requests served within a certain time (ms)
  50%     11
  66%     15
  75%     17
  80%     18
  90%     24
  95%     35
  98%     56
  99%    514
 100%    526 (longest request)
```

docker exec -it demojfr jcmd 1 JFR.dump name=demo
```
1:
Dumped recording "demo", 1.1 MB written to:

/jfr/appdemo.jfr
```

docker exec -it demojfr jcmd 1 JFR.stop name=demo
```
1:
Stopped recording "demo".
```

## docker exec -it demojfr jfr summary /jfr/demojfr.jfr > /tmp/jfr-summary.txt

## docker exec -it demojfr jfr metadata /jfr/demojfr.jfr > /tmp/jfr-metadata.txt

## docker exec -it demojfr jfr print --events jdk.GCPhasePause /jfr/demojfr.jfr
