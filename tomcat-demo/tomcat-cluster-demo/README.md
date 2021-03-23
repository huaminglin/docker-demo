# tomcat-cluster-demo

## -Dcom.sun.management.jmxremote.host=${DOCKER_HOST_IP}

## server.xml

docker cp tomcat-cluster-demo_server01_1:/usr/local/tomcat/conf/server.xml /tmp

## Use JConsole to view the cluster members

```
Catalina:type=Cluster,component=Member,name="tcp://192.168.192.3:20001"
Catalina:type=Cluster,component=Member,name="tcp://{192, 168, 192, 2}:20001"
```

##

```
java -jar jmxterm-1.0.2-uber.jar
Welcome to JMX terminal. Type "help" for available commands.
$>help
#following commands are available to use:
about    - Display about page
bean     - Display or set current selected MBean.
beans    - List available beans under a domain or all domains
bye      - Terminate console and exit
close    - Close current JMX connection
domain   - Display or set current selected domain.
domains  - List all available domain names
exit     - Terminate console and exit
get      - Get value of MBean attribute(s)
help     - Display available commands or usage of a command
info     - Display detail information about an MBean
jvms     - List all running local JVM processes
open     - Open JMX session or display current connection
option   - Set options for command session
quit     - Terminate console and exit
run      - Invoke an MBean operation
set      - Set value of an MBean attribute
subscribe - Subscribe to the notifications of a bean
unsubscribe - Unsubscribe the notifications of an earlier subscribed bean
watch    - Watch the value of one MBean attribute constantly
$>open x.x.x.x:9999
#Connection to x.x.x.x:9999 is opened
$>domains
#following domains are available
Catalina
ClusterChannel
JMImplementation
Users
com.sun.management
java.lang
java.nio
java.util.logging
jdk.management.jfr
$>domain Catalina
#domain is set to Catalina
$>
$>
$>beans
#domain = Catalina:
Catalina:J2EEApplication=none,J2EEServer=none,WebModule=//localhost/manager,j2eeType=Filter,name=Tomcat WebSocket (JSR356) Filter
Catalina:J2EEApplication=none,J2EEServer=none,WebModule=//localhost/manager,j2eeType=Servlet,name=default
Catalina:J2EEApplication=none,J2EEServer=none,WebModule=//localhost/manager,j2eeType=Servlet,name=jsp
Catalina:J2EEApplication=none,J2EEServer=none,WebModule=//localhost/manager,name=jsp,type=JspMonitor
Catalina:J2EEApplication=none,J2EEServer=none,j2eeType=WebModule,name=//localhost/manager
Catalina:class=org.apache.catalina.UserDatabase,name="UserDatabase",resourcetype=Global,type=Resource
Catalina:component=Deployer,type=Cluster
Catalina:component=Member,name="tcp://192.168.192.3:20001",type=Cluster
Catalina:component=Member,name="tcp://{192, 168, 192, 2}:20001",type=Cluster
Catalina:context=/manager,host=localhost,name=Cache,type=WebResourceRoot
Catalina:context=/manager,host=localhost,name=NonLoginAuthenticator,type=Valve
Catalina:context=/manager,host=localhost,name=RemoteAddrValve,type=Valve
Catalina:context=/manager,host=localhost,name=StandardContextValve,type=Valve
Catalina:context=/manager,host=localhost,type=Loader
Catalina:context=/manager,host=localhost,type=Manager
Catalina:context=/manager,host=localhost,type=NamingResources
Catalina:context=/manager,host=localhost,type=ParallelWebappClassLoader
Catalina:context=/manager,host=localhost,type=WebResourceRoot
Catalina:host=localhost,name=AccessLogValve,type=Valve
Catalina:host=localhost,name=ErrorReportValve,type=Valve
Catalina:host=localhost,name=StandardHostValve,type=Valve
Catalina:host=localhost,type=Deployer
Catalina:host=localhost,type=Host
Catalina:name="http-nio-8080",type=GlobalRequestProcessor
Catalina:name="http-nio-8080",type=SocketProperties
Catalina:name="http-nio-8080",type=ThreadPool
Catalina:name=JvmRouteBinderValve,type=Valve
Catalina:name=ReplicationValve,type=Valve
Catalina:name=StandardEngineValve,type=Valve
Catalina:port=8080,type=Connector
Catalina:port=8080,type=ProtocolHandler
Catalina:realmPath=/realm0,type=Realm
Catalina:realmPath=/realm0/realm0,type=Realm
Catalina:type=Cluster
Catalina:type=Engine
Catalina:type=MBeanFactory
Catalina:type=Mapper
Catalina:type=NamingResources
Catalina:type=Server
Catalina:type=Service
Catalina:type=StringCache
Catalina:type=UtilityExecutor
$>
```

Note: "
Catalina:component=Deployer,type=Cluster
Catalina:component=Member,name="tcp://192.168.192.3:20001",type=Cluster
Catalina:component=Member,name="tcp://{192, 168, 192, 2}:20001",type=Cluster" is in the "beans" output.

