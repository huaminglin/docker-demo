# DisableAttachMechanism demo

docker exec -it demoattach bash

## "-XX:+DisableAttachMechanism" demo

jinfo, jmap and jstack use the attach mechanism

```
jinfo 1
1: The VM does not support the attach mechanism
```

```
jmap -clstats 1
Exception in thread "main" com.sun.tools.attach.AttachNotSupportedException: The VM does not support the attach mechanism
        at jdk.attach/sun.tools.attach.HotSpotAttachProvider.testAttachable(HotSpotAttachProvider.java:153)
        at jdk.attach/sun.tools.attach.AttachProviderImpl.attachVirtualMachine(AttachProviderImpl.java:56)
        at jdk.attach/com.sun.tools.attach.VirtualMachine.attach(VirtualMachine.java:207)
        at jdk.jcmd/sun.tools.jmap.JMap.executeCommandForPid(JMap.java:128)
        at jdk.jcmd/sun.tools.jmap.JMap.main(JMap.java:118)
```

```
jstack -l 1
1: The VM does not support the attach mechanism
```


## "-XX:-DisableAttachMechanism" demo

docker exec demoattach jcmd 1 help
```
1:
com.sun.tools.attach.AttachNotSupportedException: The VM does not support the attach mechanism
	at jdk.attach/sun.tools.attach.HotSpotAttachProvider.testAttachable(HotSpotAttachProvider.java:153)
	at jdk.attach/sun.tools.attach.AttachProviderImpl.attachVirtualMachine(AttachProviderImpl.java:56)
	at jdk.attach/com.sun.tools.attach.VirtualMachine.attach(VirtualMachine.java:207)
	at jdk.jcmd/sun.tools.jcmd.JCmd.executeCommandForPid(JCmd.java:114)
	at jdk.jcmd/sun.tools.jcmd.JCmd.main(JCmd.java:98)
```

Conclusion: jcmd attachs to the target VM for any command, even the command is help.

## "-XX:-UsePerfData" demo

No jcmd command required "-XX:-UsePerfData" is found.
