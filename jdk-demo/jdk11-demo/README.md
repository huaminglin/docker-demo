# Demo JDK built-in tools

sudo docker exec -it jdk11-demo_server_1 bash

```
ls -1 /usr/local/openjdk-11/bin/
jaotc
jar
jarsigner
java
javac
javadoc
javap
jcmd
jconsole
jdb
jdeprscan
jdeps
jfr
jhsdb
jimage
jinfo
jjs
jlink
jmap
jmod
jps
jrunscript
jshell
jstack
jstat
jstatd
keytool
pack200
rmic
rmid
rmiregistry
serialver
unpack200
```

## jar files

find / -iname "*.jar"

```
/usr/local/openjdk-11/demo/jfc/CodePointIM/CodePointIM.jar
/usr/local/openjdk-11/demo/jfc/Stylepad/Stylepad.jar
/usr/local/openjdk-11/demo/jfc/FileChooserDemo/FileChooserDemo.jar
/usr/local/openjdk-11/demo/jfc/TransparentRuler/TransparentRuler.jar
/usr/local/openjdk-11/demo/jfc/TableExample/TableExample.jar
/usr/local/openjdk-11/demo/jfc/Font2DTest/Font2DTest.jar
/usr/local/openjdk-11/demo/jfc/SwingSet2/SwingSet2.jar
/usr/local/openjdk-11/demo/jfc/SampleTree/SampleTree.jar
/usr/local/openjdk-11/demo/jfc/Notepad/Notepad.jar
/usr/local/openjdk-11/demo/jfc/Metalworks/Metalworks.jar
/usr/local/openjdk-11/demo/jfc/J2Ddemo/J2Ddemo.jar
/usr/local/openjdk-11/lib/jrt-fs.jar
```

## jinfo

1) Start a JVM and keep it running
sudo docker exec -it jdk11-demo_server_1 jjs -scripting

"jjs> "
