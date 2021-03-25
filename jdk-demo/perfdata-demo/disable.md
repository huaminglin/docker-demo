# UsePerfData Demo: "-XX:-UsePerfData"

Use "-XX:-UsePerfData" to identify JDK tools which use UsePerfData.

## "jps -lvm" doesn't list the Tomcat process.

```
74 jdk.jcmd/sun.tools.jps.Jps -lvm -Dapplication.home=/usr/local/openjdk-11 -Xms8m -Djdk.module.main=jdk.jcmd
```

## jstat -gc 1

```
sun.jvmstat.monitor.MonitorException: 1 not found
	at jdk.internal.jvmstat/sun.jvmstat.perfdata.monitor.protocol.local.PerfDataBuffer.<init>(PerfDataBuffer.java:84)
	at jdk.internal.jvmstat/sun.jvmstat.perfdata.monitor.protocol.local.LocalMonitoredVm.<init>(LocalMonitoredVm.java:68)
	at jdk.internal.jvmstat/sun.jvmstat.perfdata.monitor.protocol.local.MonitoredHostProvider.getMonitoredVm(MonitoredHostProvider.java:77)
	at jdk.jcmd/sun.tools.jstat.Jstat.logSamples(Jstat.java:107)
	at jdk.jcmd/sun.tools.jstat.Jstat.main(Jstat.java:70)
Caused by: java.lang.IllegalArgumentException: Could not map vmid to user Name
	at java.base/jdk.internal.perf.Perf.attach(Native Method)
	at java.base/jdk.internal.perf.Perf.attachImpl(Perf.java:272)
	at java.base/jdk.internal.perf.Perf.attach(Perf.java:202)
	at jdk.internal.jvmstat/sun.jvmstat.perfdata.monitor.protocol.local.PerfDataBuffer.<init>(PerfDataBuffer.java:64)
```

## jstatd

jstatd -J-Djava.rmi.server.hostname=127.0.0.1 -J-Djava.rmi.server.logCalls=true -J-Djava.security.policy=<(echo 'grant codebase "jrt:/jdk.jstatd" {permission java.security.AllPermission;};grant codebase "jrt:/jdk.internal.jvmstat" {permission java.security.AllPermission;};') -J-XX:-UsePerfData
```
jstatd -J-Djava.rmi.server.hostname=127.0.0.1 -J-Djava.rmi.server.logCalls=true -J-Djava.security.policy=<(echo 'grant codebase "jrt:/jdk.jstatd" {permission java.security.AllPermission;};grant codebase "jrt:/jdk.internal.jvmstat" {permission java.security.AllPermission;};') -J-XX:-UsePerfData
Mar 25, 2021 12:56:52 PM sun.rmi.server.UnicastServerRef oldDispatch
FINER: RMI TCP Connection(1)-172.17.0.2: [172.17.0.2: sun.rmi.registry.RegistryImpl[0:0:0, 0]: void rebind(java.lang.String, java.rmi.Remote)]
Mar 25, 2021 12:56:52 PM sun.rmi.server.UnicastServerRef oldDispatch
FINER: RMI TCP Connection(2)-127.0.0.1: [127.0.0.1: sun.rmi.transport.DGCImpl[0:0:0, 2]: java.rmi.dgc.Lease dirty(java.rmi.server.ObjID[], long, java.rmi.dgc.Lease)]
jstatd started (bound to /JStatRemoteHost)

jps localhost:10086
252 Jps
```

## jcmd 1 PerfCounter.print

```
1:
sun.jvmstat.monitor.MonitorException: 1 not found
	at jdk.internal.jvmstat/sun.jvmstat.perfdata.monitor.protocol.local.PerfDataBuffer.<init>(PerfDataBuffer.java:84)
	at jdk.internal.jvmstat/sun.jvmstat.perfdata.monitor.protocol.local.LocalMonitoredVm.<init>(LocalMonitoredVm.java:68)
	at jdk.internal.jvmstat/sun.jvmstat.perfdata.monitor.protocol.local.MonitoredHostProvider.getMonitoredVm(MonitoredHostProvider.java:77)
	at jdk.jcmd/sun.tools.jcmd.JCmd.listCounters(JCmd.java:156)
	at jdk.jcmd/sun.tools.jcmd.JCmd.main(JCmd.java:95)
Caused by: java.lang.IllegalArgumentException: Could not map vmid to user Name
	at java.base/jdk.internal.perf.Perf.attach(Native Method)
	at java.base/jdk.internal.perf.Perf.attachImpl(Perf.java:272)
	at java.base/jdk.internal.perf.Perf.attach(Perf.java:202)
	at jdk.internal.jvmstat/sun.jvmstat.perfdata.monitor.protocol.local.PerfDataBuffer.<init>(PerfDataBuffer.java:64)
	... 4 more
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
hsdb>
```
