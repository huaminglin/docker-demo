# Tomcat Apache Ant-style variable substitution

## catalina.properties and -Dcatalina.config

/usr/local/tomcat/conf/catalina.properties

```
org.apache.catalina.startup.CatalinaProperties#loadProperties
        try {
            String configUrl = System.getProperty("catalina.config");
            if (configUrl != null) {
                if (configUrl.indexOf('/') == -1) {
                    // No '/'. Must be a file name rather than a URL
                    fileName = configUrl;
                } else {
                    is = (new URL(configUrl)).openStream();
                }
            }
        } catch (Throwable t) {
            handleThrowable(t);
        }

```

Note: new URL(configUrl). So we need to provide a string value to construct a URL object.

CATALINA_OPTS="-Dcatalina.config=file:///myhome/catalina.properties"

## tomcat-demo/variableconfig/update-default-location.sh

Add extra key to /usr/local/tomcat/conf/catalina.properties does work.

So it's "-Dcatalina.config=/myhome/catalina.properties" doesn't work.

```
"main@1" prio=5 tid=0x1 nid=NA runnable
  java.lang.Thread.State: RUNNABLE
	  at org.apache.catalina.startup.CatalinaProperties.<clinit>(CatalinaProperties.java:44)
	  at org.apache.catalina.startup.Bootstrap.createClassLoader(Bootstrap.java:165)
	  at org.apache.catalina.startup.Bootstrap.initClassLoaders(Bootstrap.java:147)
	  at org.apache.catalina.startup.Bootstrap.init(Bootstrap.java:254)
	  at org.apache.catalina.startup.Bootstrap.main(Bootstrap.java:461)
	  - locked <0x88a> (a java.lang.Object)
```

```
org.apache.catalina.startup.Bootstrap#main
    public static void main(String args[]) {

        synchronized (daemonLock) {
            if (daemon == null) {
                // Don't set daemon until init() has completed
                Bootstrap bootstrap = new Bootstrap();
                try {
                    bootstrap.init();

org.apache.catalina.startup.Bootstrap#init()
    public void init() throws Exception {

        initClassLoaders();
```

Conclusion: From the source code, it seems CatalinaProperties is loaded as soon as Bootstrap is created.
