# Tomcat Apache Ant-style variable substitution

## catalina.properties and -Dcatalina.config

/usr/local/tomcat/conf/catalina.properties

It seems that catalina.properties has not been loaded at the time the connector is ceated.

So the port="${TOMCAT_HTTP_PORT}" doesn't resolve against catalina.properties.
