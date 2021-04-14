# Tomcat threads

## http-nio-8080-BlockPoller

```
java.lang.Throwable
	at java.base/java.lang.Thread.<init>(Thread.java:710)
	at java.base/java.lang.Thread.<init>(Thread.java:478)
	at org.apache.tomcat.util.net.NioBlockingSelector$BlockPoller.<init>(NioBlockingSelector.java:218)
	at org.apache.tomcat.util.net.NioBlockingSelector.open(NioBlockingSelector.java:55)
	at org.apache.tomcat.util.net.NioSelectorPool.open(NioSelectorPool.java:130)
	at org.apache.tomcat.util.net.NioEndpoint.bind(NioEndpoint.java:218)
	at org.apache.tomcat.util.net.AbstractEndpoint.bindWithCleanup(AbstractEndpoint.java:1159)
	at org.apache.tomcat.util.net.AbstractEndpoint.init(AbstractEndpoint.java:1172)
	at org.apache.coyote.AbstractProtocol.init(AbstractProtocol.java:592)
	at org.apache.coyote.http11.AbstractHttp11Protocol.init(AbstractHttp11Protocol.java:80)
	at org.apache.catalina.connector.Connector.initInternal(Connector.java:1039)
	at org.apache.catalina.util.LifecycleBase.init(LifecycleBase.java:136)
	at org.apache.catalina.core.StandardService.initInternal(StandardService.java:558)
	at org.apache.catalina.util.LifecycleBase.init(LifecycleBase.java:136)
	at org.apache.catalina.core.StandardServer.initInternal(StandardServer.java:1057)
	at org.apache.catalina.util.LifecycleBase.init(LifecycleBase.java:136)
	at org.apache.catalina.startup.Catalina.load(Catalina.java:724)
	at org.apache.catalina.startup.Catalina.load(Catalina.java:746)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.base/java.lang.reflect.Method.invoke(Method.java:566)
	at org.apache.catalina.startup.Bootstrap.load(Bootstrap.java:302)
	at org.apache.catalina.startup.Bootstrap.main(Bootstrap.java:472)
```

```
org.apache.tomcat.util.net.NioEndpoint#bind
    /**
     * Initialize the endpoint.
     */
    @Override
    public void bind() throws Exception {
        initServerSocket();

        setStopLatch(new CountDownLatch(1));

        // Initialize SSL if needed
        initialiseSsl();

        selectorPool.open(getName());
    }
```

```
java.lang.Throwable
	at java.base/java.lang.Thread.interrupt(Thread.java:985)
	at org.apache.tomcat.util.net.NioBlockingSelector.close(NioBlockingSelector.java:65)
	at org.apache.tomcat.util.net.NioSelectorPool.close(NioSelectorPool.java:117)
	at org.apache.tomcat.util.net.NioEndpoint.unbind(NioEndpoint.java:346)
	at org.apache.tomcat.util.net.AbstractEndpoint.destroy(AbstractEndpoint.java:1296)
	at org.apache.coyote.AbstractProtocol.destroy(AbstractProtocol.java:707)
	at org.apache.coyote.http11.AbstractHttp11Protocol.destroy(AbstractHttp11Protocol.java:105)
	at org.apache.catalina.connector.Connector.destroyInternal(Connector.java:1097)
	at org.apache.catalina.util.LifecycleBase.destroy(LifecycleBase.java:321)
	at org.apache.catalina.core.StandardService.destroyInternal(StandardService.java:571)
	at org.apache.catalina.util.LifecycleBase.destroy(LifecycleBase.java:321)
	at org.apache.catalina.core.StandardServer.destroyInternal(StandardServer.java:1065)
	at org.apache.catalina.util.LifecycleBase.destroy(LifecycleBase.java:321)
	at org.apache.catalina.startup.Catalina.stop(Catalina.java:850)
	at org.apache.catalina.startup.Catalina.start(Catalina.java:811)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.base/java.lang.reflect.Method.invoke(Method.java:566)
	at org.apache.catalina.startup.Bootstrap.start(Bootstrap.java:342)
	at org.apache.catalina.startup.Bootstrap.main(Bootstrap.java:473)
```

## Catalina-utility-1

```
java.lang.Throwable
	at java.base/java.lang.Thread.<init>(Thread.java:456)
	at java.base/java.lang.Thread.<init>(Thread.java:709)
	at java.base/java.lang.Thread.<init>(Thread.java:630)
	at org.apache.tomcat.util.threads.TaskThread.<init>(TaskThread.java:32)
	at org.apache.tomcat.util.threads.TaskThreadFactory.newThread(TaskThreadFactory.java:48)
	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.<init>(ThreadPoolExecutor.java:623)
	at java.base/java.util.concurrent.ThreadPoolExecutor.addWorker(ThreadPoolExecutor.java:912)
	at java.base/java.util.concurrent.ThreadPoolExecutor.ensurePrestart(ThreadPoolExecutor.java:1583)
	at java.base/java.util.concurrent.ScheduledThreadPoolExecutor.delayedExecute(ScheduledThreadPoolExecutor.java:346)
	at java.base/java.util.concurrent.ScheduledThreadPoolExecutor.scheduleWithFixedDelay(ScheduledThreadPoolExecutor.java:680)
	at org.apache.tomcat.util.threads.ScheduledThreadPoolExecutor.scheduleWithFixedDelay(ScheduledThreadPoolExecutor.java:138)
	at org.apache.catalina.core.ContainerBase.startInternal(ContainerBase.java:941)
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
org.apache.catalina.core.StandardServer#reconfigureUtilityExecutor
    private synchronized void reconfigureUtilityExecutor(int threads) {
        // The ScheduledThreadPoolExecutor doesn't use MaximumPoolSize, only CorePoolSize is available
        if (utilityExecutor != null) {
            utilityExecutor.setCorePoolSize(threads);
        } else {
            ScheduledThreadPoolExecutor scheduledThreadPoolExecutor =
                    new ScheduledThreadPoolExecutor(threads,
                            new TaskThreadFactory("Catalina-utility-", utilityThreadsAsDaemon, Thread.MIN_PRIORITY));
            scheduledThreadPoolExecutor.setKeepAliveTime(10, TimeUnit.SECONDS);
            scheduledThreadPoolExecutor.setRemoveOnCancelPolicy(true);
            scheduledThreadPoolExecutor.setExecuteExistingDelayedTasksAfterShutdownPolicy(false);
            utilityExecutor = scheduledThreadPoolExecutor;
            utilityExecutorWrapper = new org.apache.tomcat.util.threads.ScheduledThreadPoolExecutor(utilityExecutor);
        }
    }
```

```
java.lang.Throwable
	at java.base/java.lang.Thread.interrupt(Thread.java:985)
	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.interruptIfStarted(ThreadPoolExecutor.java:663)
	at java.base/java.util.concurrent.ThreadPoolExecutor.interruptWorkers(ThreadPoolExecutor.java:761)
	at java.base/java.util.concurrent.ThreadPoolExecutor.shutdownNow(ThreadPoolExecutor.java:1407)
	at java.base/java.util.concurrent.ScheduledThreadPoolExecutor.shutdownNow(ScheduledThreadPoolExecutor.java:870)
	at org.apache.catalina.core.StandardServer.destroyInternal(StandardServer.java:1075)
	at org.apache.catalina.util.LifecycleBase.destroy(LifecycleBase.java:321)
	at org.apache.catalina.startup.Catalina.stop(Catalina.java:850)
	at org.apache.catalina.startup.Catalina.start(Catalina.java:811)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.base/java.lang.reflect.Method.invoke(Method.java:566)
	at org.apache.catalina.startup.Bootstrap.start(Bootstrap.java:342)
	at org.apache.catalina.startup.Bootstrap.main(Bootstrap.java:473)
```

## http-nio-8080-exec-1

```
java.lang.Throwable
	at java.base/java.lang.Thread.<init>(Thread.java:456)
	at java.base/java.lang.Thread.<init>(Thread.java:709)
	at java.base/java.lang.Thread.<init>(Thread.java:630)
	at org.apache.tomcat.util.threads.TaskThread.<init>(TaskThread.java:32)
	at org.apache.tomcat.util.threads.TaskThreadFactory.newThread(TaskThreadFactory.java:48)
	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.<init>(ThreadPoolExecutor.java:623)
	at java.base/java.util.concurrent.ThreadPoolExecutor.addWorker(ThreadPoolExecutor.java:912)
	at java.base/java.util.concurrent.ThreadPoolExecutor.prestartAllCoreThreads(ThreadPoolExecutor.java:1597)
	at org.apache.tomcat.util.threads.ThreadPoolExecutor.<init>(ThreadPoolExecutor.java:77)
	at org.apache.tomcat.util.net.AbstractEndpoint.createExecutor(AbstractEndpoint.java:942)
	at org.apache.tomcat.util.net.NioEndpoint.startInternal(NioEndpoint.java:268)
	at org.apache.tomcat.util.net.AbstractEndpoint.start(AbstractEndpoint.java:1248)
	at org.apache.coyote.AbstractProtocol.start(AbstractProtocol.java:603)
	at org.apache.catalina.connector.Connector.startInternal(Connector.java:1064)
	at org.apache.catalina.util.LifecycleBase.start(LifecycleBase.java:183)
	at org.apache.catalina.core.StandardService.startInternal(StandardService.java:451)
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
org.apache.tomcat.util.net.AbstractEndpoint#createExecutor
    public void createExecutor() {
        internalExecutor = true;
        TaskQueue taskqueue = new TaskQueue();
        TaskThreadFactory tf = new TaskThreadFactory(getName() + "-exec-", daemon, getThreadPriority());
        executor = new ThreadPoolExecutor(getMinSpareThreads(), getMaxThreads(), 60, TimeUnit.SECONDS,taskqueue, tf);
        taskqueue.setParent( (ThreadPoolExecutor) executor);
    }
```

```
java.lang.Throwable
	at java.base/java.lang.Thread.interrupt(Thread.java:985)
	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.interruptIfStarted(ThreadPoolExecutor.java:663)
	at java.base/java.util.concurrent.ThreadPoolExecutor.interruptWorkers(ThreadPoolExecutor.java:761)
	at java.base/java.util.concurrent.ThreadPoolExecutor.shutdownNow(ThreadPoolExecutor.java:1407)
	at org.apache.tomcat.util.net.AbstractEndpoint.shutdownExecutor(AbstractEndpoint.java:953)
	at org.apache.tomcat.util.net.NioEndpoint.stopInternal(NioEndpoint.java:307)
	at org.apache.tomcat.util.net.AbstractEndpoint.stop(AbstractEndpoint.java:1287)
	at org.apache.coyote.AbstractProtocol.stop(AbstractProtocol.java:695)
	at org.apache.catalina.connector.Connector.stopInternal(Connector.java:1084)
	at org.apache.catalina.util.LifecycleBase.stop(LifecycleBase.java:257)
	at org.apache.catalina.core.StandardService.stopInternal(StandardService.java:512)
	at org.apache.catalina.util.LifecycleBase.stop(LifecycleBase.java:257)
	at org.apache.catalina.core.StandardServer.stopInternal(StandardServer.java:992)
	at org.apache.catalina.util.LifecycleBase.stop(LifecycleBase.java:257)
	at org.apache.catalina.startup.Catalina.stop(Catalina.java:849)
	at org.apache.catalina.startup.Catalina.start(Catalina.java:811)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.base/java.lang.reflect.Method.invoke(Method.java:566)
	at org.apache.catalina.startup.Bootstrap.start(Bootstrap.java:342)
	at org.apache.catalina.startup.Bootstrap.main(Bootstrap.java:473)
```

## http-nio-8080-ClientPoller

```
java.lang.Throwable
	at java.base/java.lang.Thread.<init>(Thread.java:456)
	at java.base/java.lang.Thread.<init>(Thread.java:709)
	at java.base/java.lang.Thread.<init>(Thread.java:582)
	at org.apache.tomcat.util.net.NioEndpoint.startInternal(NioEndpoint.java:275)
	at org.apache.tomcat.util.net.AbstractEndpoint.start(AbstractEndpoint.java:1248)
	at org.apache.coyote.AbstractProtocol.start(AbstractProtocol.java:603)
	at org.apache.catalina.connector.Connector.startInternal(Connector.java:1064)
	at org.apache.catalina.util.LifecycleBase.start(LifecycleBase.java:183)
	at org.apache.catalina.core.StandardService.startInternal(StandardService.java:451)
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
org.apache.tomcat.util.net.NioEndpoint#startInternal
    /**
     * Start the NIO endpoint, creating acceptor, poller threads.
     */
    @Override
    public void startInternal() throws Exception {

        if (!running) {
            running = true;
            paused = false;

            if (socketProperties.getProcessorCache() != 0) {
                processorCache = new SynchronizedStack<>(SynchronizedStack.DEFAULT_SIZE,
                        socketProperties.getProcessorCache());
            }
            if (socketProperties.getEventCache() != 0) {
                eventCache = new SynchronizedStack<>(SynchronizedStack.DEFAULT_SIZE,
                        socketProperties.getEventCache());
            }
            if (socketProperties.getBufferPool() != 0) {
                nioChannels = new SynchronizedStack<>(SynchronizedStack.DEFAULT_SIZE,
                        socketProperties.getBufferPool());
            }

            // Create worker collection
            if (getExecutor() == null) {
                createExecutor();
            }

            initializeConnectionLatch();

            // Start poller thread
            poller = new Poller();
            Thread pollerThread = new Thread(poller, getName() + "-ClientPoller");
            pollerThread.setPriority(threadPriority);
            pollerThread.setDaemon(true);
            pollerThread.start();

            startAcceptorThread();
        }
    }

```

Note: When is the acceptor thread closed?

## http-nio-8080-Acceptor

```
java.lang.Throwable
	at java.base/java.lang.Thread.<init>(Thread.java:456)
	at java.base/java.lang.Thread.<init>(Thread.java:709)
	at java.base/java.lang.Thread.<init>(Thread.java:582)
	at org.apache.tomcat.util.net.AbstractEndpoint.startAcceptorThread(AbstractEndpoint.java:1256)
	at org.apache.tomcat.util.net.NioEndpoint.startInternal(NioEndpoint.java:280)
	at org.apache.tomcat.util.net.AbstractEndpoint.start(AbstractEndpoint.java:1248)
	at org.apache.coyote.AbstractProtocol.start(AbstractProtocol.java:603)
	at org.apache.catalina.connector.Connector.startInternal(Connector.java:1064)
	at org.apache.catalina.util.LifecycleBase.start(LifecycleBase.java:183)
	at org.apache.catalina.core.StandardService.startInternal(StandardService.java:451)
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
org.apache.tomcat.util.net.AbstractEndpoint#startAcceptorThread
    protected void startAcceptorThread() {
        acceptor = new Acceptor<>(this);
        String threadName = getName() + "-Acceptor";
        acceptor.setThreadName(threadName);
        Thread t = new Thread(acceptor, threadName);
        t.setPriority(getAcceptorThreadPriority());
        t.setDaemon(getDaemon());
        t.start();
    }
```

```
java.lang.Throwable
	at huaminglin.bba.run.BbaRunManager.recordThread(BbaRunManager.java:130)
	at java.base/java.lang.Thread.interrupt(Thread.java:985)
	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.interruptIfStarted(ThreadPoolExecutor.java:663)
	at java.base/java.util.concurrent.ThreadPoolExecutor.interruptWorkers(ThreadPoolExecutor.java:761)
	at java.base/java.util.concurrent.ThreadPoolExecutor.shutdownNow(ThreadPoolExecutor.java:1407)
	at org.apache.tomcat.util.net.AbstractEndpoint.shutdownExecutor(AbstractEndpoint.java:953)
	at org.apache.tomcat.util.net.NioEndpoint.stopInternal(NioEndpoint.java:307)
	at org.apache.tomcat.util.net.AbstractEndpoint.stop(AbstractEndpoint.java:1287)
	at org.apache.coyote.AbstractProtocol.stop(AbstractProtocol.java:695)
	at org.apache.catalina.connector.Connector.stopInternal(Connector.java:1084)
	at org.apache.catalina.util.LifecycleBase.stop(LifecycleBase.java:257)
	at org.apache.catalina.core.StandardService.stopInternal(StandardService.java:512)
	at org.apache.catalina.util.LifecycleBase.stop(LifecycleBase.java:257)
	at org.apache.catalina.core.StandardServer.stopInternal(StandardServer.java:992)
	at org.apache.catalina.util.LifecycleBase.stop(LifecycleBase.java:257)
	at org.apache.catalina.startup.Catalina.stop(Catalina.java:849)
	at org.apache.catalina.startup.Catalina.start(Catalina.java:811)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.base/java.lang.reflect.Method.invoke(Method.java:566)
	at org.apache.catalina.startup.Bootstrap.start(Bootstrap.java:342)
	at org.apache.catalina.startup.Bootstrap.main(Bootstrap.java:473)
```

## org.apache.catalina.startup.Catalina$CatalinaShutdownHook

```
    protected class CatalinaShutdownHook extends Thread {

        @Override
        public void run() {
            try {
                if (getServer() != null) {
                    Catalina.this.stop();
                }
            } catch (Throwable ex) {
                ExceptionUtils.handleThrowable(ex);
                log.error(sm.getString("catalina.shutdownHookFail"), ex);
            } finally {
                // If JULI is used, shut JULI down *after* the server shuts down
                // so log messages aren't lost
                LogManager logManager = LogManager.getLogManager();
                if (logManager instanceof ClassLoaderLogManager) {
                    ((ClassLoaderLogManager) logManager).shutdown();
                }
            }
        }
    }
```
