# Run Tomcat on local

## Download

https://tomcat.apache.org/download-90.cgi

$HOME/bin/apache-tomcat-9.0.41

## Verify how a variable in server.xml is resolved

<Server port="${SHUTDOWN_PORT}" shutdown="SHUTDOWN">

xx-xx-xxxx xx:xx:21.669 WARNING [main] org.apache.tomcat.util.digester.SetPropertiesRule.begin Match [Server] failed to set property [port] to [${SHUTDOWN_PORT}]

org.apache.tomcat.util.digester.Digester.startElement(String e=, e=, String value=Server, Attributes this=com.sun.org.apache.xerces.internal.parsers.AbstractSAXParser$AttributesProxy)

org.apache.tomcat.util.digester.Digester$SystemPropertySource.getProperty {String this=SHUTDOWN_PORT, ClassLoader key=java.net.URLClassLoader)

```
at org.apache.tomcat.util.digester.Digester$SystemPropertySource.getProperty(Digester.java:188)
	at org.apache.tomcat.util.IntrospectionUtils.getProperty(IntrospectionUtils.java:368)
	at org.apache.tomcat.util.IntrospectionUtils.replaceProperties(IntrospectionUtils.java:335)
	at org.apache.tomcat.util.digester.Digester.updateAttributes(Digester.java:2047)
	at org.apache.tomcat.util.digester.Digester.startElement(Digester.java:1259)
	at java.xml/com.sun.org.apache.xerces.internal.parsers.AbstractSAXParser.startElement(AbstractSAXParser.java:510)
	at java.xml/com.sun.org.apache.xerces.internal.impl.dtd.XMLDTDValidator.startElement(XMLDTDValidator.java:731)
	at java.xml/com.sun.org.apache.xerces.internal.impl.XMLDocumentFragmentScannerImpl.scanStartElement(XMLDocumentFragmentScannerImpl.java:1397)
	at java.xml/com.sun.org.apache.xerces.internal.impl.XMLDocumentScannerImpl$ContentDriver.scanRootElementHook(XMLDocumentScannerImpl.java:1292)
	at java.xml/com.sun.org.apache.xerces.internal.impl.XMLDocumentFragmentScannerImpl$FragmentContentDriver.next(XMLDocumentFragmentScannerImpl.java:3063)
	at java.xml/com.sun.org.apache.xerces.internal.impl.XMLDocumentScannerImpl$PrologDriver.next(XMLDocumentScannerImpl.java:836)
	at java.xml/com.sun.org.apache.xerces.internal.impl.XMLDocumentScannerImpl.next(XMLDocumentScannerImpl.java:605)
	at java.xml/com.sun.org.apache.xerces.internal.impl.XMLDocumentFragmentScannerImpl.scanDocument(XMLDocumentFragmentScannerImpl.java:534)
	at java.xml/com.sun.org.apache.xerces.internal.parsers.XML11Configuration.parse(XML11Configuration.java:888)
	at java.xml/com.sun.org.apache.xerces.internal.parsers.XML11Configuration.parse(XML11Configuration.java:824)
	at java.xml/com.sun.org.apache.xerces.internal.parsers.XMLParser.parse(XMLParser.java:141)
	at java.xml/com.sun.org.apache.xerces.internal.parsers.AbstractSAXParser.parse(AbstractSAXParser.java:1216)
	at java.xml/com.sun.org.apache.xerces.internal.jaxp.SAXParserImpl$JAXPSAXParser.parse(SAXParserImpl.java:635)
	at org.apache.tomcat.util.digester.Digester.parse(Digester.java:1551)
	at org.apache.catalina.startup.Catalina.parseServerXml(Catalina.java:617)
	at org.apache.catalina.startup.Catalina.load(Catalina.java:709)
	at org.apache.catalina.startup.Catalina.load(Catalina.java:746)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.base/java.lang.reflect.Method.invoke(Method.java:566)
	at org.apache.catalina.startup.Bootstrap.load(Bootstrap.java:302)
	at org.apache.catalina.startup.Bootstrap.main(Bootstrap.java:472)
```

```
org.apache.tomcat.util.digester.Digester.SystemPropertySource#getProperty
    private class SystemPropertySource implements IntrospectionUtils.PropertySource {
        @Override
        public String getProperty(String key) {
            ClassLoader cl = getClassLoader();
            if (cl instanceof PermissionCheck) {
                Permission p = new PropertyPermission(key, "read");
                if (!((PermissionCheck) cl).check(p)) {
                    return null;
                }
            }
            return System.getProperty(key);
        }
    }
```

## Use variable in resource declaration

context.xml

```
    <Resource name="bean/MyBeanFactory" auth="Container"
            type="com.mycompany.MyBean"
            factory="org.apache.naming.factory.BeanFactory"
            bar="${SHUTDOWN_PORT}"/>
```

```
	at org.apache.tomcat.util.digester.Digester$SystemPropertySource.getProperty(Digester.java:188)
	at org.apache.tomcat.util.IntrospectionUtils.getProperty(IntrospectionUtils.java:368)
	at org.apache.tomcat.util.IntrospectionUtils.replaceProperties(IntrospectionUtils.java:335)
	at org.apache.tomcat.util.digester.Digester.updateBodyText(Digester.java:2066)
	at org.apache.tomcat.util.digester.Digester.endElement(Digester.java:1014)
	at java.xml/com.sun.org.apache.xerces.internal.parsers.AbstractSAXParser.endElement(AbstractSAXParser.java:610)
	at java.xml/com.sun.org.apache.xerces.internal.impl.XMLDocumentFragmentScannerImpl.scanEndElement(XMLDocumentFragmentScannerImpl.java:1718)
	at java.xml/com.sun.org.apache.xerces.internal.impl.XMLDocumentFragmentScannerImpl$FragmentContentDriver.next(XMLDocumentFragmentScannerImpl.java:2883)
	at java.xml/com.sun.org.apache.xerces.internal.impl.XMLDocumentScannerImpl.next(XMLDocumentScannerImpl.java:605)
	at java.xml/com.sun.org.apache.xerces.internal.impl.XMLDocumentFragmentScannerImpl.scanDocument(XMLDocumentFragmentScannerImpl.java:534)
	at java.xml/com.sun.org.apache.xerces.internal.parsers.XML11Configuration.parse(XML11Configuration.java:888)
	at java.xml/com.sun.org.apache.xerces.internal.parsers.XML11Configuration.parse(XML11Configuration.java:824)
	at java.xml/com.sun.org.apache.xerces.internal.parsers.XMLParser.parse(XMLParser.java:141)
	at java.xml/com.sun.org.apache.xerces.internal.parsers.AbstractSAXParser.parse(AbstractSAXParser.java:1216)
	at java.xml/com.sun.org.apache.xerces.internal.jaxp.SAXParserImpl$JAXPSAXParser.parse(SAXParserImpl.java:635)
	at org.apache.tomcat.util.digester.Digester.parse(Digester.java:1551)
	at org.apache.catalina.startup.ContextConfig.processContextConfig(ContextConfig.java:735)
	at org.apache.catalina.startup.ContextConfig.contextConfig(ContextConfig.java:607)
	at org.apache.catalina.startup.ContextConfig.init(ContextConfig.java:948)
	at org.apache.catalina.startup.ContextConfig.lifecycleEvent(ContextConfig.java:314)
	at org.apache.catalina.util.LifecycleBase.fireLifecycleEvent(LifecycleBase.java:123)
	at org.apache.catalina.util.LifecycleBase.setStateInternal(LifecycleBase.java:423)
	at org.apache.catalina.util.LifecycleBase.init(LifecycleBase.java:137)
	at org.apache.catalina.util.LifecycleBase.start(LifecycleBase.java:173)
	at org.apache.catalina.core.ContainerBase.addChildInternal(ContainerBase.java:717)
	at org.apache.catalina.core.ContainerBase.addChild(ContainerBase.java:690)
	at org.apache.catalina.core.StandardHost.addChild(StandardHost.java:706)
	at org.apache.catalina.startup.HostConfig.deployDirectory(HostConfig.java:1133)
	at org.apache.catalina.startup.HostConfig$DeployDirectory.run(HostConfig.java:1866)
	at java.base/java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:515)
	at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264)
	at org.apache.tomcat.util.threads.InlineExecutorService.execute(InlineExecutorService.java:75)
	at java.base/java.util.concurrent.AbstractExecutorService.submit(AbstractExecutorService.java:118)
	at org.apache.catalina.startup.HostConfig.deployDirectories(HostConfig.java:1045)
	at org.apache.catalina.startup.HostConfig.deployApps(HostConfig.java:429)
	at org.apache.catalina.startup.HostConfig.start(HostConfig.java:1576)
	at org.apache.catalina.startup.HostConfig.lifecycleEvent(HostConfig.java:309)
	at org.apache.catalina.util.LifecycleBase.fireLifecycleEvent(LifecycleBase.java:123)
	at org.apache.catalina.util.LifecycleBase.setStateInternal(LifecycleBase.java:423)
	at org.apache.catalina.util.LifecycleBase.setState(LifecycleBase.java:366)
	at org.apache.catalina.core.ContainerBase.startInternal(ContainerBase.java:936)
	at org.apache.catalina.core.StandardHost.startInternal(StandardHost.java:843)
	at org.apache.catalina.util.LifecycleBase.start(LifecycleBase.java:183)
	at org.apache.catalina.core.ContainerBase$StartChild.call(ContainerBase.java:1384)
	at org.apache.catalina.core.ContainerBase$StartChild.call(ContainerBase.java:1374)
	at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264)
	at org.apache.tomcat.util.threads.InlineExecutorService.execute(InlineExecutorService.java:75)
	at java.base/java.util.concurrent.AbstractExecutorService.submit(AbstractExecutorService.java:140)
	at org.apache.catalina.core.ContainerBase.startInternal(ContainerBase.java:909)
	at org.apache.catalina.core.StandardEngine.startInternal(StandardEngine.java:262)
	at org.apache.catalina.util.LifecycleBase.start(LifecycleBase.java:183)
	at org.apache.catalina.core.StandardService.startInternal(StandardService.java:434)
	at org.apache.catalina.util.LifecycleBase.start(LifecycleBase.java:183)
	at org.apache.catalina.core.StandardServer.startInternal(StandardServer.java:930)
	at org.apache.catalina.util.LifecycleBase.start(LifecycleBase.java:183)
	at org.apache.catalina.startup.Catalina.start(Catalina.java:772)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.base/java.lang.reflect.Method.invoke(Method.java:566)
	at org.apache.catalina.startup.Bootstrap.start(Bootstrap.java:342)
	at org.apache.catalina.startup.Bootstrap.main(Bootstrap.java:473)
```

```
INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deploying web application directory [/.../apache-tomcat-9.0.41/webapps/docs]
org.apache.tomcat.util.digester.Digester$SystemPropertySource.getProperty(String this=catalina.base, )
org.apache.tomcat.util.digester.Digester$SystemPropertySource.getProperty {String this=SHUTDOWN_PORT, )
INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deploying web application directory [/home/myname/bin/apache-tomcat-9.0.41/webapps/manager]
org.apache.tomcat.util.digester.Digester$SystemPropertySource.getProperty(String this=catalina.base, )
org.apache.tomcat.util.digester.Digester$SystemPropertySource.getProperty(String this=SHUTDOWN_PORT, )
```

Conclusion:

${CATALINA_HOME}/conf/context.xml is a template for every webapp deployed.
The variable used in it is resolved for every webapp.


## Digester resolves "${xxx}"

```
org.apache.tomcat.util.digester.Digester#updateAttributes
   /**
     * Returns an attributes list which contains all the attributes
     * passed in, with any text of form "${xxx}" in an attribute value
     * replaced by the appropriate value from the system property.
     */
    private Attributes updateAttributes(Attributes list) {

        if (list.getLength() == 0) {
            return list;
        }

        AttributesImpl newAttrs = new AttributesImpl(list);
        int nAttributes = newAttrs.getLength();
        for (int i = 0; i < nAttributes; ++i) {
            String value = newAttrs.getValue(i);
            try {
                newAttrs.setValue(i, IntrospectionUtils.replaceProperties(value, null, source).intern());
            } catch (Exception e) {
                log.warn(sm.getString("digester.failedToUpdateAttributes", newAttrs.getLocalName(i), value), e);
            }
        }

        return newAttrs;
    }


    /**
     * Return a new StringBuilder containing the same contents as the
     * input buffer, except that data of form ${varname} have been
     * replaced by the value of that var as defined in the system property.
     */
    private StringBuilder updateBodyText(StringBuilder bodyText) {
        String in = bodyText.toString();
        String out;
        try {
            out = IntrospectionUtils.replaceProperties(in, null, source);
        } catch (Exception e) {
            return bodyText; // return unchanged data
        }

        if (out == in) {
            // No substitutions required. Don't waste memory creating
            // a new buffer
            return bodyText;
        } else {
            return new StringBuilder(out);
        }
    }

```

## How does Digester load Rule

```
org.apache.catalina.startup.Catalina#createStartDigester


    protected Digester createStartDigester() {
        long t1=System.currentTimeMillis();
        // Initialize the digester
        Digester digester = new Digester();
        digester.setValidating(false);
        digester.setRulesValidation(true);
        Map<Class<?>, List<String>> fakeAttributes = new HashMap<>();
        // Ignore className on all elements
        List<String> objectAttrs = new ArrayList<>();
        objectAttrs.add("className");
        fakeAttributes.put(Object.class, objectAttrs);
        // Ignore attribute added by Eclipse for its internal tracking
        List<String> contextAttrs = new ArrayList<>();
        contextAttrs.add("source");
        fakeAttributes.put(StandardContext.class, contextAttrs);
        // Ignore Connector attribute used internally but set on Server
        List<String> connectorAttrs = new ArrayList<>();
        connectorAttrs.add("portOffset");
        fakeAttributes.put(Connector.class, connectorAttrs);
        digester.setFakeAttributes(fakeAttributes);
        digester.setUseContextClassLoader(true);

        // Configure the actions we will be using
        digester.addObjectCreate("Server",
                                 "org.apache.catalina.core.StandardServer",
                                 "className");
        digester.addSetProperties("Server");
        digester.addSetNext("Server",
                            "setServer",
                            "org.apache.catalina.Server");

        digester.addObjectCreate("Server/GlobalNamingResources",
                                 "org.apache.catalina.deploy.NamingResourcesImpl");
        digester.addSetProperties("Server/GlobalNamingResources");
        digester.addSetNext("Server/GlobalNamingResources",
                            "setGlobalNamingResources",
                            "org.apache.catalina.deploy.NamingResourcesImpl");

        digester.addRule("Server/Listener",
                new ListenerCreateRule(null, "className"));
        digester.addSetProperties("Server/Listener");
        digester.addSetNext("Server/Listener",
                            "addLifecycleListener",
                            "org.apache.catalina.LifecycleListener");

        digester.addObjectCreate("Server/Service",
                                 "org.apache.catalina.core.StandardService",
                                 "className");
        digester.addSetProperties("Server/Service");
        digester.addSetNext("Server/Service",
                            "addService",
                            "org.apache.catalina.Service");

        digester.addObjectCreate("Server/Service/Listener",
                                 null, // MUST be specified in the element
                                 "className");
        digester.addSetProperties("Server/Service/Listener");
        digester.addSetNext("Server/Service/Listener",
                            "addLifecycleListener",
                            "org.apache.catalina.LifecycleListener");

        //Executor
        digester.addObjectCreate("Server/Service/Executor",
                         "org.apache.catalina.core.StandardThreadExecutor",
                         "className");
        digester.addSetProperties("Server/Service/Executor");

        digester.addSetNext("Server/Service/Executor",
                            "addExecutor",
                            "org.apache.catalina.Executor");


        digester.addRule("Server/Service/Connector",
                         new ConnectorCreateRule());
        digester.addRule("Server/Service/Connector", new SetAllPropertiesRule(
                new String[]{"executor", "sslImplementationName", "protocol"}));
        digester.addSetNext("Server/Service/Connector",
                            "addConnector",
                            "org.apache.catalina.connector.Connector");

        digester.addRule("Server/Service/Connector", new AddPortOffsetRule());

        digester.addObjectCreate("Server/Service/Connector/SSLHostConfig",
                                 "org.apache.tomcat.util.net.SSLHostConfig");
        digester.addSetProperties("Server/Service/Connector/SSLHostConfig");
        digester.addSetNext("Server/Service/Connector/SSLHostConfig",
                "addSslHostConfig",
                "org.apache.tomcat.util.net.SSLHostConfig");

        digester.addRule("Server/Service/Connector/SSLHostConfig/Certificate",
                         new CertificateCreateRule());
        digester.addRule("Server/Service/Connector/SSLHostConfig/Certificate",
                         new SetAllPropertiesRule(new String[]{"type"}));
        digester.addSetNext("Server/Service/Connector/SSLHostConfig/Certificate",
                            "addCertificate",
                            "org.apache.tomcat.util.net.SSLHostConfigCertificate");

        digester.addObjectCreate("Server/Service/Connector/SSLHostConfig/OpenSSLConf",
                                 "org.apache.tomcat.util.net.openssl.OpenSSLConf");
        digester.addSetProperties("Server/Service/Connector/SSLHostConfig/OpenSSLConf");
        digester.addSetNext("Server/Service/Connector/SSLHostConfig/OpenSSLConf",
                            "setOpenSslConf",
                            "org.apache.tomcat.util.net.openssl.OpenSSLConf");

        digester.addObjectCreate("Server/Service/Connector/SSLHostConfig/OpenSSLConf/OpenSSLConfCmd",
                                 "org.apache.tomcat.util.net.openssl.OpenSSLConfCmd");
        digester.addSetProperties("Server/Service/Connector/SSLHostConfig/OpenSSLConf/OpenSSLConfCmd");
        digester.addSetNext("Server/Service/Connector/SSLHostConfig/OpenSSLConf/OpenSSLConfCmd",
                            "addCmd",
                            "org.apache.tomcat.util.net.openssl.OpenSSLConfCmd");

        digester.addObjectCreate("Server/Service/Connector/Listener",
                                 null, // MUST be specified in the element
                                 "className");
        digester.addSetProperties("Server/Service/Connector/Listener");
        digester.addSetNext("Server/Service/Connector/Listener",
                            "addLifecycleListener",
                            "org.apache.catalina.LifecycleListener");

        digester.addObjectCreate("Server/Service/Connector/UpgradeProtocol",
                                  null, // MUST be specified in the element
                                  "className");
        digester.addSetProperties("Server/Service/Connector/UpgradeProtocol");
        digester.addSetNext("Server/Service/Connector/UpgradeProtocol",
                            "addUpgradeProtocol",
                            "org.apache.coyote.UpgradeProtocol");

        // Add RuleSets for nested elements
        digester.addRuleSet(new NamingRuleSet("Server/GlobalNamingResources/"));
        digester.addRuleSet(new EngineRuleSet("Server/Service/"));
        digester.addRuleSet(new HostRuleSet("Server/Service/Engine/"));
        digester.addRuleSet(new ContextRuleSet("Server/Service/Engine/Host/"));
        addClusterRuleSet(digester, "Server/Service/Engine/Host/Cluster/");
        digester.addRuleSet(new NamingRuleSet("Server/Service/Engine/Host/Context/"));

        // When the 'engine' is found, set the parentClassLoader.
        digester.addRule("Server/Service/Engine",
                         new SetParentClassLoaderRule(parentClassLoader));
        addClusterRuleSet(digester, "Server/Service/Engine/Cluster/");

        long t2=System.currentTimeMillis();
        if (log.isDebugEnabled()) {
            log.debug("Digester for server.xml created " + ( t2-t1 ));
        }
        return digester;

    }
```

## ${} in web.xml

http://127.0.0.1:8080/app01/mycgi2/


org.apache.catalina.servlets.CGIServlet

```
<!doctype html><html lang="en"><head><title>HTTP Status 500 – Internal Server Error</title><style type="text/css">body {font-family:Tahoma,Arial,sans-serif;} h1, h2, h3, b {color:white;background-color:#525D76;} h1 {font-size:22px;} h2 {font-size:16px;} h3 {font-size:14px;} p {font-size:12px;} a {color:black;} .line {height:1px;background-color:#525D76;border:none;}</style></head><body><h1>HTTP Status 500 – Internal Server Error</h1><hr class="line" /><p><b>Type</b> Exception Report</p><p><b>Message</b> Error instantiating servlet class [org.apache.catalina.servlets.CGIServlet]</p><p><b>Description</b> The server encountered an unexpected condition that prevented it from fulfilling the request.</p><p><b>Exception</b></p><pre>javax.servlet.ServletException: Error instantiating servlet class [org.apache.catalina.servlets.CGIServlet]
	org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:542)
	org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)
	org.apache.catalina.valves.AbstractAccessLogValve.invoke(AbstractAccessLogValve.java:690)
	org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)
	org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:374)
	org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)
	org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:888)
	org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1597)
	org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)
	java.base&#47;java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)
	java.base&#47;java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)
	org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)
	java.base&#47;java.lang.Thread.run(Thread.java:834)
</pre><p><b>Root Cause</b></p><pre>java.lang.SecurityException: Access to class [class org.apache.catalina.servlets.CGIServlet] is forbidden. It is a restricted class. A web application must be configured as privileged to be able to load it
	org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:542)
	org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)
	org.apache.catalina.valves.AbstractAccessLogValve.invoke(AbstractAccessLogValve.java:690)
	org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)
	org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:374)
	org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)
	org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:888)
	org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1597)
	org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)
	java.base&#47;java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)
	java.base&#47;java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)
	org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)
	java.base&#47;java.lang.Thread.run(Thread.java:834)
</pre><p><b>Note</b> The full stack trace of the root cause is available in the server logs.</p><hr class="line" /><h3>Apache Tomcat/9.0.41</h3></body></html>
```

Note: The first request receives the above 500 page, the following requests receive 404 instead.

## org.apache.catalina.servlets.DefaultServlet

-Dvar_readme=readme

http://127.0.0.1:8080/app01/a/

Config DefaultServlet and demo variable in web.xml is resolved.
