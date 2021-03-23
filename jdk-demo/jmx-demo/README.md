# JMX demo

## "-Dcom.sun.management.jmxremote.password.file": Error: Password file not found

```
server_1  | Error: Password file not found: /tmp/non-existing-password
server_1  | jdk.internal.agent.AgentConfigurationError
server_1  |     at jdk.management.agent/sun.management.jmxremote.ConnectorBootstrap.checkPasswordFile(ConnectorBootstrap.java:572)
server_1  |     at jdk.management.agent/sun.management.jmxremote.ConnectorBootstrap.startRemoteConnectorServer(ConnectorBootstrap.java:436)
server_1  |     at jdk.management.agent/jdk.internal.agent.Agent.startAgent(Agent.java:447)
server_1  |     at jdk.management.agent/jdk.internal.agent.Agent.startAgent(Agent.java:599)
```
