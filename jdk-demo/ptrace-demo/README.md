# jhsdb demo

## ERROR: ptrace(PTRACE_ATTACH, ..) failed for 1: Operation not permitted

docker exec -it demoptrace jhsdb jmap --pid 1
```
Attaching to process ID 1, please wait...
ERROR: ptrace(PTRACE_ATTACH, ..) failed for 1: Operation not permitted
Error attaching to process: sun.jvm.hotspot.debugger.DebuggerException: Can't attach to the process: ptrace(PTRACE_ATTACH, ..) failed for 1: Operation not permitted
sun.jvm.hotspot.debugger.DebuggerException: sun.jvm.hotspot.debugger.DebuggerException: Can't attach to the process: ptrace(PTRACE_ATTACH, ..) failed for 1: Operation not permitted
        at jdk.hotspot.agent/sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal$LinuxDebuggerLocalWorkerThread.execute(LinuxDebuggerLocal.java:163)
        at jdk.hotspot.agent/sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal.attach(LinuxDebuggerLocal.java:274)
        at jdk.hotspot.agent/sun.jvm.hotspot.HotSpotAgent.attachDebugger(HotSpotAgent.java:672)
        at jdk.hotspot.agent/sun.jvm.hotspot.HotSpotAgent.setupDebuggerLinux(HotSpotAgent.java:612)
        at jdk.hotspot.agent/sun.jvm.hotspot.HotSpotAgent.setupDebugger(HotSpotAgent.java:338)
        at jdk.hotspot.agent/sun.jvm.hotspot.HotSpotAgent.go(HotSpotAgent.java:305)
        at jdk.hotspot.agent/sun.jvm.hotspot.HotSpotAgent.attach(HotSpotAgent.java:141)
        at jdk.hotspot.agent/sun.jvm.hotspot.tools.Tool.start(Tool.java:185)
        at jdk.hotspot.agent/sun.jvm.hotspot.tools.Tool.execute(Tool.java:118)
        at jdk.hotspot.agent/sun.jvm.hotspot.tools.JMap.main(JMap.java:176)
        at jdk.hotspot.agent/sun.jvm.hotspot.SALauncher.runJMAP(SALauncher.java:369)
        at jdk.hotspot.agent/sun.jvm.hotspot.SALauncher.main(SALauncher.java:538)
Caused by: sun.jvm.hotspot.debugger.DebuggerException: Can't attach to the process: ptrace(PTRACE_ATTACH, ..) failed for 1: Operation not permitted
        at jdk.hotspot.agent/sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal.attach0(Native Method)
        at jdk.hotspot.agent/sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal$1AttachTask.doit(LinuxDebuggerLocal.java:265)
        at jdk.hotspot.agent/sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal$LinuxDebuggerLocalWorkerThread.run(LinuxDebuggerLocal.java:138)
```

## "--cap-add=SYS_PTRACE"

docker exec -it demoptrace jhsdb jmap --pid 1
```
Attaching to process ID 1, please wait...
Debugger attached successfully.
Server compiler detected.
JVM version is 11.0.10+9
0x000055d5c6db8000      12K     /usr/local/openjdk-11/bin/java
0x00007f44b6dfa000      12K     /usr/local/openjdk-11/lib/libextnet.so
0x00007f44b7502000      42K     /lib/x86_64-linux-gnu/libcrypt-2.28.so
0x00007f44b753c000      225K    /usr/lib/x86_64-linux-gnu/libapr-1.so.0.6.5
0x00007f44b7575000      2960K   /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1
0x00007f44b785e000      579K    /usr/lib/x86_64-linux-gnu/libssl.so.1.1
0x00007f44b78f0000      33K     /usr/local/openjdk-11/lib/libmanagement_ext.so
0x00007f44b7af7000      29K     /usr/local/openjdk-11/lib/libmanagement.so
0x00007f44e8013000      30K     /lib/x86_64-linux-gnu/libuuid.so.1.3.0
0x00007f44e804d000      112K    /usr/local/openjdk-11/lib/libnet.so
0x00007f44e8265000      89K     /usr/local/openjdk-11/lib/libnio.so
0x00007f44f0000000      1196K   /usr/local/tomcat/native-jni-lib/libtcnative-1.so.0.2.26
0x00007f451529f000      40K     /usr/local/openjdk-11/lib/libzip.so
0x00007f45154b0000      54K     /lib/x86_64-linux-gnu/libnss_files-2.28.so
0x00007f45154c9000      59K     /usr/local/openjdk-11/lib/libjimage.so
0x00007f45156d5000      214K    /usr/local/openjdk-11/lib/libjava.so
0x00007f4515901000      67K     /usr/local/openjdk-11/lib/libverify.so
0x00007f4515b11000      34K     /lib/x86_64-linux-gnu/librt-2.28.so
0x00007f4515c1c000      98K     /lib/x86_64-linux-gnu/libgcc_s.so.1
0x00007f4515c36000      1542K   /lib/x86_64-linux-gnu/libm-2.28.so
0x00007f4515db9000      1533K   /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.25
0x00007f4515f3d000      22386K  /usr/local/openjdk-11/lib/server/libjvm.so
0x00007f45173b5000      1781K   /lib/x86_64-linux-gnu/libc-2.28.so
0x00007f4517576000      14K     /lib/x86_64-linux-gnu/libdl-2.28.so
0x00007f451757b000      73K     /usr/local/openjdk-11/lib/jli/libjli.so
0x00007f451778b000      143K    /lib/x86_64-linux-gnu/libpthread-2.28.so
0x00007f45177ac000      118K    /lib/x86_64-linux-gnu/libz.so.1.2.11
0x00007f45179d0000      161K    /lib/x86_64-linux-gnu/ld-2.28.so
```

docker inspect -f '{{.State.Pid}}' demoptrace

```
sudo ps aux|grep 28602
root     28602  6.1  1.3 6150024 106236 ?      Ssl  01:55   0:10 /usr/local/openjdk-11/bin/java -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djdk.tls.ephemeralDHKeySize=2048 -Djava.protocol.handler.pkgs=org.apache.catalina.webresources -Dorg.apache.catalina.security.SecurityListener.UMASK=0027 -Dignore.endorsed.dirs= -classpath /usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar -Dcatalina.base=/usr/local/tomcat -Dcatalina.home=/usr/local/tomcat -Djava.io.tmpdir=/usr/local/tomcat/temp org.apache.catalina.startup.Bootstrap start
user1    28830  0.0  0.0  16192  1160 pts/0    S+   01:58   0:00 grep --color=auto 28602
```

```
docker exec -it demoptrace jhsdb clhsdb --pid 1
Attaching to process 1, please wait...
Warning: Nashorn engine is planned to be removed from a future JDK release
javax.script.ScriptException: TypeError: sapkg.runtime.VM.getVM is not a function in sa.js at line number 54
javax.script.ScriptException: TypeError: sapkg.runtime.VM.getVM is not a function in sa.js at line number 54
Warning! JS Engine can't start, some commands will not be available.
hsdb>
```

```
root     28602  1.7  1.3 6150024 106760 ?      tsl  01:55   0:12 /usr/local/openjdk-11/bin/java -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djdk.tls.ephemeralDHKeySize=2048 -Djava.protocol.handler.pkgs=org.apache.catalina.webresources -Dorg.apache.catalina.security.SecurityListener.UMASK=0027 -Dignore.endorsed.dirs= -classpath /usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar -Dcatalina.base=/usr/local/tomcat -Dcatalina.home=/usr/local/tomcat -Djava.io.tmpdir=/usr/local/tomcat/temp org.apache.catalina.startup.Bootstrap start
```
Note: the state is "tsl", and request http://127.0.0.1:18030/ on browser is blocking.

"t stopped by debugger during the tracing"

```
docker run -it --rm --security-opt=seccomp:unconfined --security-opt=apparmor:unconfined --privileged --pid=host --userns=host debian:jessie@sha256:51cd80bb935b76fbbf49640750736abc63ab7084d5331e198326b20063e7f13c nsenter -t 28602 -m -u -n -i -F ss -tpi
State                         Recv-Q                     Send-Q                                         Local Address:Port                                             Peer Address:Port
CLOSE-WAIT                    1                          0                                                 172.17.0.2:http-alt                                           172.17.0.1:35912
	 cubic wscale:7,7 rto:204 rtt:0.15/0.075 ato:40 mss:1448 pmtu:1500 rcvmss:536 advmss:1448 cwnd:10 bytes_received:1 segs_out:1 segs_in:3 send 772.3Mbps lastsnd:2075164 lastrcv:2075164 lastack:944 pacing_rate 1544.5Mbps rcv_space:14600 rcv_ssthresh:64076 minrtt:0.15
ESTAB                         403                        0                                                 172.17.0.2:http-alt                                           172.17.0.1:35914
	 cubic wscale:7,7 rto:204 rtt:0.116/0.058 ato:40 mss:1448 pmtu:1500 rcvmss:536 advmss:1448 cwnd:10 bytes_received:403 segs_out:1 segs_in:3 data_segs_in:1 send 998.6Mbps lastsnd:2075164 lastrcv:2075160 lastack:2075160 pacing_rate 1997.2Mbps rcv_space:14600 rcv_ssthresh:64076 minrtt:0.116
```
