# UsePerfData Demo: "-XX:+UsePerfData"

## jps -lvm

```
1 org.apache.catalina.startup.Bootstrap start --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.util.concurrent=ALL-UNNAMED --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -XX:+UsePerfData -Djdk.tls.ephemeralDHKeySize=2048 -Djava.protocol.handler.pkgs=org.apache.catalina.webresources -Dorg.apache.catalina.security.SecurityListener.UMASK=0027 -Dignore.endorsed.dirs= -Dcatalina.base=/usr/local/tomcat -Dcatalina.home=/usr/local/tomcat -Djava.io.tmpdir=/usr/local/tomcat/temp
72 jdk.jcmd/sun.tools.jps.Jps -lvm -Dapplication.home=/usr/local/openjdk-11 -Xms8m -Djdk.module.main=jdk.jcmd
```

## jstat -gc 1

```
 S0C    S1C    S0U    S1U      EC       EU        OC         OU       MC     MU    CCSC   CCSU   YGC     YGCT    FGC    FGCT    CGC    CGCT     GCT
 0.0   3072.0  0.0   3072.0 77824.0  14336.0   50176.0     2094.5   9344.0 8672.8 1152.0 939.7       1    0.061   0      0.000   0      0.000    0.061
 ```

## jstatd -p 10086

```
Could not create remote object
java.security.AccessControlException: access denied ("java.util.PropertyPermission" "java.rmi.server.ignoreSubClasses" "write")
	at java.base/java.security.AccessControlContext.checkPermission(AccessControlContext.java:472)
	at java.base/java.security.AccessController.checkPermission(AccessController.java:897)
	at java.base/java.lang.SecurityManager.checkPermission(SecurityManager.java:322)
	at java.base/java.lang.System.setProperty(System.java:894)
	at jdk.jstatd/sun.tools.jstatd.Jstatd.main(Jstatd.java:141)
```

jstatd -J-Djava.rmi.server.hostname=127.0.0.1 -J-Djava.rmi.server.logCalls=true -J-Djava.security.policy=<(echo 'grant codebase "jrt:/jdk.jstatd" {permission java.security.AllPermission;};grant codebase "jrt:/jdk.internal.jvmstat" {permission java.security.AllPermission;};')
```
Mar 25, 2021 12:05:13 PM sun.rmi.server.UnicastServerRef oldDispatch
FINER: RMI TCP Connection(1)-172.17.0.2: [172.17.0.2: sun.rmi.registry.RegistryImpl[0:0:0, 0]: void rebind(java.lang.String, java.rmi.Remote)]
Mar 25, 2021 12:05:14 PM sun.rmi.server.UnicastServerRef oldDispatch
FINER: RMI TCP Connection(2)-127.0.0.1: [127.0.0.1: sun.rmi.transport.DGCImpl[0:0:0, 2]: java.rmi.dgc.Lease dirty(java.rmi.server.ObjID[], long, java.rmi.dgc.Lease)]
jstatd started (bound to /JStatRemoteHost)

jps localhost:10086
1 Bootstrap
54 Jstatd
92 Jps
```

## The following command works

```
jcmd 1 PerfCounter.print
jinfo 1
jmap -clstats 1
jstack -l 1
```

## jhsdb clhsdb

```
hsdb> attach 1
Attaching to process 1, please wait...
ERROR: ptrace(PTRACE_ATTACH, ..) failed for 1: Operation not permitted
Unable to connect to process ID 1:

sun.jvm.hotspot.debugger.DebuggerException: Can't attach to the process:
ptrace(PTRACE_ATTACH, ..) failed for 1: Operation not permitted
sun.jvm.hotspot.debugger.DebuggerException: sun.jvm.hotspot.debugger.DebuggerException: Can't attach to the process: ptrace(PTRACE_ATTACH, ..) failed for 1: Operation not permitted
	at jdk.hotspot.agent/sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal$LinuxDebuggerLocalWorkerThread.execute(LinuxDebuggerLocal.java:163)
	at jdk.hotspot.agent/sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal.attach(LinuxDebuggerLocal.java:274)
	at jdk.hotspot.agent/sun.jvm.hotspot.HotSpotAgent.attachDebugger(HotSpotAgent.java:672)
	at jdk.hotspot.agent/sun.jvm.hotspot.HotSpotAgent.setupDebuggerLinux(HotSpotAgent.java:612)
	at jdk.hotspot.agent/sun.jvm.hotspot.HotSpotAgent.setupDebugger(HotSpotAgent.java:338)
	at jdk.hotspot.agent/sun.jvm.hotspot.HotSpotAgent.go(HotSpotAgent.java:305)
	at jdk.hotspot.agent/sun.jvm.hotspot.HotSpotAgent.attach(HotSpotAgent.java:141)
	at jdk.hotspot.agent/sun.jvm.hotspot.CLHSDB.attachDebugger(CLHSDB.java:180)
	at jdk.hotspot.agent/sun.jvm.hotspot.CLHSDB$2.attach(CLHSDB.java:75)
	at jdk.hotspot.agent/sun.jvm.hotspot.CommandProcessor$2.doit(CommandProcessor.java:410)
	at jdk.hotspot.agent/sun.jvm.hotspot.CommandProcessor.executeCommand(CommandProcessor.java:1974)
	at jdk.hotspot.agent/sun.jvm.hotspot.CommandProcessor.executeCommand(CommandProcessor.java:1944)
	at jdk.hotspot.agent/sun.jvm.hotspot.CommandProcessor.run(CommandProcessor.java:1824)
	at jdk.hotspot.agent/sun.jvm.hotspot.CLHSDB.run(CLHSDB.java:99)
	at jdk.hotspot.agent/sun.jvm.hotspot.CLHSDB.main(CLHSDB.java:40)
	at jdk.hotspot.agent/sun.jvm.hotspot.SALauncher.runCLHSDB(SALauncher.java:224)
	at jdk.hotspot.agent/sun.jvm.hotspot.SALauncher.main(SALauncher.java:522)
Caused by: sun.jvm.hotspot.debugger.DebuggerException: Can't attach to the process: ptrace(PTRACE_ATTACH, ..) failed for 1: Operation not permitted
	at jdk.hotspot.agent/sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal.attach0(Native Method)
	at jdk.hotspot.agent/sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal$1AttachTask.doit(LinuxDebuggerLocal.java:265)
	at jdk.hotspot.agent/sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal$LinuxDebuggerLocalWorkerThread.run(LinuxDebuggerLocal.java:138)
Warning: Nashorn engine is planned to be removed from a future JDK release
javax.script.ScriptException: TypeError: sapkg.runtime.VM.getVM is not a function in sa.js at line number 54
javax.script.ScriptException: TypeError: sapkg.runtime.VM.getVM is not a function in sa.js at line number 54
Warning! JS Engine can't start, some commands will not be available.
```
