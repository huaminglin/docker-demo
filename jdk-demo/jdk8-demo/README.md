# Demo JDK built-in tools

jstatd is a JDK built-in daemon, and we can run it as a target Java process.

sudo docker exec -it jdk8-demo_server_1 jjs -scripting

sudo docker exec -it jdk8-demo_server_1 bash -c "export _JAVA_OPTIONS='-XX:+UnlockDiagnosticVMOptions'; jjs -scripting"

sudo docker exec -it jdk8-demo_server_1 bash

sudo docker exec -it jdk8-demo_client_1 bash

```
ls -1 /usr/local/openjdk-8/bin
appletviewer
clhsdb
extcheck
hsdb
idlj
jar
jarsigner
java
java-rmi.cgi
javac
javadoc
javah
javap
jcmd
jconsole
jdb
jdeps
jhat
jinfo
jjs
jmap
jps
jrunscript
jsadebugd
jstack
jstat
jstatd
keytool
native2ascii
orbd
pack200
policytool
rmic
rmid
rmiregistry
schemagen
serialver
servertool
tnameserv
unpack200
wsgen
wsimport
xjc
```

## jstatd

docker exec -it jdk8-demo_client01_1 jps -lvm server01:10086

```
1 sun.tools.jstatd.Jstatd -p 10086 -Dapplication.home=/usr/local/openjdk-8 -Xms8m -Djava.rmi.server.hostname=server01 -Djava.rmi.server.logCalls=true -Djava.security.policy=/jstatd.policy
```

## jar files

find / -iname "*.jar"

```
/usr/local/openjdk-8/jre/lib/security/policy/unlimited/US_export_policy.jar
/usr/local/openjdk-8/jre/lib/security/policy/unlimited/local_policy.jar
/usr/local/openjdk-8/jre/lib/security/policy/limited/US_export_policy.jar
/usr/local/openjdk-8/jre/lib/security/policy/limited/local_policy.jar
/usr/local/openjdk-8/jre/lib/jce.jar
/usr/local/openjdk-8/jre/lib/rt.jar
/usr/local/openjdk-8/jre/lib/resources.jar
/usr/local/openjdk-8/jre/lib/charsets.jar
/usr/local/openjdk-8/jre/lib/management-agent.jar
/usr/local/openjdk-8/jre/lib/ext/zipfs.jar
/usr/local/openjdk-8/jre/lib/ext/sunjce_provider.jar
/usr/local/openjdk-8/jre/lib/ext/localedata.jar
/usr/local/openjdk-8/jre/lib/ext/cldrdata.jar
/usr/local/openjdk-8/jre/lib/ext/jaccess.jar
/usr/local/openjdk-8/jre/lib/ext/dnsns.jar
/usr/local/openjdk-8/jre/lib/ext/nashorn.jar
/usr/local/openjdk-8/jre/lib/ext/sunpkcs11.jar
/usr/local/openjdk-8/jre/lib/ext/sunec.jar
/usr/local/openjdk-8/jre/lib/jsse.jar
/usr/local/openjdk-8/demo/jpda/examples.jar
/usr/local/openjdk-8/demo/jvmti/mtrace/mtrace.jar
/usr/local/openjdk-8/demo/jvmti/heapTracker/heapTracker.jar
/usr/local/openjdk-8/demo/jvmti/minst/minst.jar
/usr/local/openjdk-8/demo/jfc/SwingApplet/SwingApplet.jar
/usr/local/openjdk-8/demo/jfc/CodePointIM/CodePointIM.jar
/usr/local/openjdk-8/demo/jfc/FileChooserDemo/FileChooserDemo.jar
/usr/local/openjdk-8/demo/jfc/TransparentRuler/TransparentRuler.jar
/usr/local/openjdk-8/demo/jfc/TableExample/TableExample.jar
/usr/local/openjdk-8/demo/jfc/Font2DTest/Font2DTest.jar
/usr/local/openjdk-8/demo/jfc/SampleTree/SampleTree.jar
/usr/local/openjdk-8/demo/jfc/Notepad/Notepad.jar
/usr/local/openjdk-8/demo/jfc/Metalworks/Metalworks.jar
/usr/local/openjdk-8/demo/nio/zipfs/zipfs.jar
/usr/local/openjdk-8/demo/applets/WireFrame/WireFrame.jar
/usr/local/openjdk-8/demo/applets/MoleculeViewer/MoleculeViewer.jar
/usr/local/openjdk-8/demo/scripting/jconsole-plugin/jconsole-plugin.jar
/usr/local/openjdk-8/demo/management/JTop/JTop.jar
/usr/local/openjdk-8/demo/management/FullThreadDump/FullThreadDump.jar
/usr/local/openjdk-8/demo/management/MemoryMonitor/MemoryMonitor.jar
/usr/local/openjdk-8/demo/management/VerboseGC/VerboseGC.jar
/usr/local/openjdk-8/lib/dt.jar
/usr/local/openjdk-8/lib/jconsole.jar
/usr/local/openjdk-8/lib/tools.jar
/usr/local/openjdk-8/lib/sa-jdi.jar
```

## Java .so

```
ls -al /usr/local/openjdk-8/jre/lib/amd64/
total 5888
drwxrwxr-x 4 root root   4096 Jul 27 11:49 .
drwxrwxr-x 9 root root   4096 Jul 27 11:49 ..
drwxrwxr-x 2 root root   4096 Jul 27 11:49 jli
-rw-rw-r-- 1 root root   1624 Jul 27 11:49 jvm.cfg
-rwxr-xr-x 1 root root  19231 Jul 27 11:49 libattach.so
-rwxr-xr-x 1 root root 776125 Jul 27 11:49 libawt.so
-rwxr-xr-x 1 root root  39483 Jul 27 11:49 libawt_headless.so
-rwxr-xr-x 1 root root 492469 Jul 27 11:49 libawt_xawt.so
-rwxr-xr-x 1 root root  24618 Jul 27 11:49 libdt_socket.so
-rwxr-xr-x 1 root root 496999 Jul 27 11:49 libfontmanager.so
-rwxr-xr-x 1 root root 179974 Jul 27 11:49 libhprof.so
-rwxr-xr-x 1 root root  51785 Jul 27 11:49 libinstrument.so
-rwxr-xr-x 1 root root  47773 Jul 27 11:49 libj2gss.so
-rwxr-xr-x 1 root root  18424 Jul 27 11:49 libj2pcsc.so
-rwxr-xr-x 1 root root  90132 Jul 27 11:49 libj2pkcs11.so
-rwxr-xr-x 1 root root   8320 Jul 27 11:49 libjaas_unix.so
-rwxr-xr-x 1 root root 207397 Jul 27 11:49 libjava.so
-rwxr-xr-x 1 root root  26146 Jul 27 11:49 libjava_crw_demo.so
-rwxr-xr-x 1 root root   8285 Jul 27 11:49 libjawt.so
-rwxr-xr-x 1 root root 276977 Jul 27 11:49 libjdwp.so
-rwxr-xr-x 1 root root 265564 Jul 27 11:49 libjpeg.so
-rwxr-xr-x 1 root root  12906 Jul 27 11:49 libjsdt.so
-rwxr-xr-x 1 root root  13173 Jul 27 11:49 libjsig.so
-rwxr-xr-x 1 root root   8454 Jul 27 11:49 libjsound.so
-rwxr-xr-x 1 root root  83366 Jul 27 11:49 libjsoundalsa.so
-rwxr-xr-x 1 root root 433611 Jul 27 11:49 liblcms.so
-rwxr-xr-x 1 root root  52305 Jul 27 11:49 libmanagement.so
-rwxr-xr-x 1 root root 892464 Jul 27 11:49 libmlib_image.so
-rwxr-xr-x 1 root root 122056 Jul 27 11:49 libnet.so
-rwxr-xr-x 1 root root  99007 Jul 27 11:49 libnio.so
-rwxr-xr-x 1 root root  17502 Jul 27 11:49 libnpt.so
-rwxr-xr-x 1 root root  52127 Jul 27 11:49 libsaproc.so
-rwxr-xr-x 1 root root  29835 Jul 27 11:49 libsctp.so
-rwxr-xr-x 1 root root 449755 Jul 27 11:49 libsplashscreen.so
-rwxr-xr-x 1 root root 266268 Jul 27 11:49 libsunec.so
-rwxr-xr-x 1 root root 172216 Jul 27 11:49 libunpack.so
-rwxr-xr-x 1 root root  70245 Jul 27 11:49 libverify.so
-rwxr-xr-x 1 root root 126886 Jul 27 11:49 libzip.so
drwxrwxr-x 2 root root   4096 Jul 27 11:49 server
```

## jinfo

1) Start a JVM and keep it running
sudo docker exec -it jdk8-demo_server_1 jjs -scripting
de
"jjs> "

2) Try to call jinfo from the same container

a. "Operation not permitted"

sudo docker exec jdk8-demo_server_1 jps

212 Shel

sudo docker exec jdk8-demo_server_1 jinfo 212

```
Attaching to process ID 96, please wait...
ERROR: ptrace(PTRACE_ATTACH, ..) failed for 96: Operation not permitted
Error attaching to process: sun.jvm.hotspot.debugger.DebuggerException: Can't attach to the process: ptrace(PTRACE_ATTACH, ..) failed for 96: Operation not permitted
sun.jvm.hotspot.debugger.DebuggerException: sun.jvm.hotspot.debugger.DebuggerException: Can't attach to the process: ptrace(PTRACE_ATTACH, ..) failed for 96: Operation not permitted
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
Caused by: sun.jvm.hotspot.debugger.DebuggerException: Can't attach to the process: ptrace(PTRACE_ATTACH, ..) failed for 96: Operation not permitted
        at sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal.attach0(Native Method)
        at sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal.access$100(LinuxDebuggerLocal.java:62)
        at sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal$1AttachTask.doit(LinuxDebuggerLocal.java:269)
        at sun.jvm.hotspot.debugger.linux.LinuxDebuggerLocal$LinuxDebuggerLocalWorkerThread.run(LinuxDebuggerLocal.java:138)
```

b. /proc/sys/kernel/yama/ptrace_scope

sudo docker exec --user root jdk8-demo_server_1 bash -c 'echo 0 > /proc/sys/kernel/yama/ptrace_scope'

bash: /proc/sys/kernel/yama/ptrace_scope: Read-only file system

Add "privileged: true" to docker-compose.yml and retry

```
sudo docker exec jdk8-demo_server_1 jinfo 212
Attaching to process ID 212, please wait...
Debugger attached successfully.
Server compiler detected.
JVM version is 25.265-b01
```

Note: It seems "privileged: true" alone works, "/proc/sys/kernel/yama/ptrace_scope" to 0 is not needed.

Note: "Debugger attached successfully.". Interesting. What mechnism does jinfo use?

sudo docker exec jdk8-demo_server_1 cat /proc/sys/kernel/yama/ptrace_scope

## jdeps

jdeps /usr/local/openjdk-8/lib/tools.jar

jdeps java.lang.String

## jhat

http://127.0.0.1:7000/oqlhelp/

Object Query Language (OQL)

http://127.0.0.1:7000/oql/

## jcmd vs. jmap: class statistics

jcmd <pid> GC.class_stats: GC.class_stats command requires -XX:+UnlockDiagnosticVMOptions

At the same time, "jmap -clstats 7" can work: Debugger attached successfully.

So jcmd and jmap use different mechnism.

jmap -clstats PID to dump class loader statistics;

jcmd PID GC.class_stats to print the detailed information about memory usage of each loaded class. The latter requires -XX:+UnlockDiagnosticVMOptions.

## jsadebugd

```
jps server
RMI Server JStatRemoteHost not available
```

Note: It seems jps tries to find "JStatRemoteHost" on the RMI Server.

```
jinfo server
Attaching to remote server server, please wait...
Debugger attached successfully.
Server compiler detected.
JVM version is 25.265-b01
Java System Properties:
```

```
jmap -heap server
Attaching to remote server server, please wait...
Debugger attached successfully.
Server compiler detected.
JVM version is 25.265-b01

using thread-local object allocation.
Parallel GC with 8 thread(s)
```

```
jstack server
Attaching to remote server server, please wait...
Debugger attached successfully.
Server compiler detected.
JVM version is 25.265-b01
Deadlock Detection:

No deadlocks found
```

```
jstat -gc 6@server
RMI Server JStatRemoteHost not available
```

Conclusion: jmap and jstack work well with jsadebugd; jps and jstat need "RMI Server JStatRemoteHost".

From the remote access, we know jmap/jstack use different mechnism from jps/jstat.
