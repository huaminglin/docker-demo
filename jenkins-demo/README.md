# Jenkins cluster

## Master node

Make sure 1000:1000 owns /var/tmp/jenkins_home.


Check /usr/local/bin/jenkins.sh for more configuration

JENKINS_OPTS is used to pass parameters to jenkins.war

## Setup a slave node

1) Add a slave on management console

Manage Jenkins > Manage Nodes > New Node > Permanent Agent

http://127.0.0.1:8080/computer/slave1/

Run from agent command line:

java -jar slave.jar -jnlpUrl http://127.0.0.1:8080/computer/slave1/slave-agent.jnlp -secret 7208793d9fef46681eb51b5d3907d9046ed741c2b8cb9d19064b1373bed6b6ea

2) Run the slave.jar

Make sure 1000:1000 owns /var/tmp/jenkins_slave_home.

After the master node is ready, run "sudo docker start jenkins-demo_slave_1" to start the slave node

3) TCP connection to 50000

A slave node will keep a TCP connection to 50000 port of the master node.

sudo docker run -it --rm --net=container:jenkins-demo_slave_1 nicolaka/netshoot bash

tcp                      ESTAB                     0                          0                                              192.168.128.3:41578                                          192.168.128.2:50000

This TCP connection uses TLS.

## Create a project and limit it to run on the slave only.

Jenkins project configuration: Restrict where this job can be run

By default, builds of this project may be executed on any build agents that are available and configured to accept new builds.

When this option is checked, you have the possibility to ensure that builds of this project only occur on a certain agent, or set of agents.

For example, if your project should only be built on a certain operating system, or on machines that have a certain set of tools installed, or even one specific machine, you can restrict this project to only execute on agents that that meet those criteria.

## Logs on the system

Jenkins uses java.util.logging for logging.

The java.util.logging system by default sends every log above INFO to stdout.

1) Manage Jenkins > System Log: Log Recorders

2) Support Core Plugin,

3) -Djava.util.logging.config.file=<pathTo>/logging.properties

Note: it seems logger level configuration doesn't work.


## JDK tools inside Docker container and /proc/sys/kernel/yama/ptrace_scope

```
jinfo 6
sun.jvm.hotspot.debugger.DebuggerException: sun.jvm.hotspot.debugger.DebuggerException: Can't attach to the process: ptrace(PTRACE_ATTACH, ..) failed for 6: Operation not permitted
        at sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal$LinuxDebuggerLocalWorkerThread.execute(LinuxDebuggerLocal.java:163)
        at sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal.attach(LinuxDebuggerLocal.java:278)
        at sun.jvm.hotspot.HotSpotAgent.attachDebugger(HotSpotAgent.java:671)
        at sun.jvm.hotspot.HotSpotAgent.setupDebuggerLinux(HotSpotAgent.java:611)
        at sun.jvm.hotspot.HotSpotAgent.setupDebugger(HotSpotAgent.java:337)
        at sun.jvm.hotspot.HotSpotAgent.go(HotSpotAgent.java:304)
        at sun.jvm.hotspot.HotSpotAgent.attach(HotSpotAgent.java:140)
        at sun.jvm.hotspot.tools.Tool.start(Tool.java:185)
        at sun.jvm.hotspot.tools.Tool.execute(Tool.java:118)
        at sun.jvm.hotspot.tools.PMap.main(PMap.java:72)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.lang.reflect.Method.invoke(Method.java:498)
        at sun.tools.jmap.JMap.runTool(JMap.java:201)
        at sun.tools.jmap.JMap.main(JMap.java:130)
Caused by: sun.jvm.hotspot.debugger.DebuggerException: Can't attach to the process: ptrace(PTRACE_ATTACH, ..) failed for 6: Operation not permitted
        at sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal.attach0(Native Method)
        at sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal.access$100(LinuxDebuggerLocal.java:62)
        at sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal$1AttachTask.doit(LinuxDebuggerLocal.java:269)
        at sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal$LinuxDebuggerLocalWorkerThread.run(LinuxDebuggerLocal.java:138)
```

```
jinfo 6
Attaching to process ID 6, please wait...
Error attaching to process: sun.jvm.hotspot.debugger.DebuggerException: cannot open binary file
sun.jvm.hotspot.debugger.DebuggerException: sun.jvm.hotspot.debugger.DebuggerException: cannot open binary file
        at sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal$LinuxDebuggerLocalWorkerThread.execute(LinuxDebuggerLocal.java:163)
        at sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal.attach(LinuxDebuggerLocal.java:278)
        at sun.jvm.hotspot.HotSpotAgent.attachDebugger(HotSpotAgent.java:671)
        at sun.jvm.hotspot.HotSpotAgent.setupDebuggerLinux(HotSpotAgent.java:611)
        at sun.jvm.hotspot.HotSpotAgent.setupDebugger(HotSpotAgent.java:337)
        at sun.jvm.hotspot.HotSpotAgent.go(HotSpotAgent.java:304)
        at sun.jvm.hotspot.HotSpotAgent.attach(HotSpotAgent.java:140)
        at sun.jvm.hotspot.tools.Tool.start(Tool.java:185)
        at sun.jvm.hotspot.tools.Tool.execute(Tool.java:118)
        at sun.jvm.hotspot.tools.JInfo.main(JInfo.java:138)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.lang.reflect.Method.invoke(Method.java:498)
        at sun.tools.jinfo.JInfo.runTool(JInfo.java:108)
        at sun.tools.jinfo.JInfo.main(JInfo.java:76)
Caused by: sun.jvm.hotspot.debugger.DebuggerException: cannot open binary file
        at sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal.attach0(Native Method)
        at sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal.access$100(LinuxDebuggerLocal.java:62)
        at sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal$1AttachTask.doit(LinuxDebuggerLocal.java:269)
        at sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal$LinuxDebuggerLocalWorkerThread.run(LinuxDebuggerLocal.java:138)
```

sudo docker exec --user root jenkins-demo_master_1 bash -c 'echo 0 > /proc/sys/kernel/yama/ptrace_scope'

```
bash: /proc/sys/kernel/yama/ptrace_scope: Read-only file system
```

Note: Need "privileged: true" in the docker-compose.yml

"cap_add:      - SYS_PTRACE" is not required.

sudo docker exec -it jenkins-demo_master_1 bash

## VisualVM JMX Connection

-Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false

VisualVM > Add Remote Host

VisualVM > Remote > Add JMX Connection

## VisualVM jstatd Connection (The target Jenkins JVM runs Java 8)

sudo docker exec jenkins-demo_master_1 jstatd -p 1099 -J-Djava.security.policy=/jstatd.all.policy

VisualVM > Add Remote Host

VisualVM > Remote > Add JMX Connection

```
jstatd
Could not create remote object
access denied ("java.util.PropertyPermission" "java.rmi.server.ignoreSubClasses" "write")
java.security.AccessControlException: access denied ("java.util.PropertyPermission" "java.rmi.server.ignoreSubClasses" "write")
        at java.security.AccessControlContext.checkPermission(AccessControlContext.java:472)
        at java.security.AccessController.checkPermission(AccessController.java:886)
        at java.lang.SecurityManager.checkPermission(SecurityManager.java:549)
        at java.lang.System.setProperty(System.java:794)
        at sun.tools.jstatd.Jstatd.main(Jstatd.java:139)
```

Note: ""privileged: true"" fixes the above issue.
