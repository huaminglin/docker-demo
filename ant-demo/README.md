# Ant Demo

## Download

https://ant.apache.org/bindownload.cgi

Ant 1.10.9 has been released on 30-Sep-2020 and may not be available on all mirrors for a few days.

https://apache.mirrors.nublue.co.uk//ant/binaries/apache-ant-1.10.9-bin.zip

Add ${ANT_HOME}/bin to the PATH.

## task/build.xml

```
     [echo] basedir: /.../docker-demo/ant-demo/task
     [echo] user.dir: /.../docker-demo/ant-demo
     [echo] env.MY_ENV_VAR_1: VAR1
     [echo] env.MY_ENV_VAR_2: ${env.MY_ENV_VAR_2}
     [echo] var3: VAR1
     [echo] var4: 4
     [echo] var5: 5
```

Note:

A non-existing property is kept: "${env.MY_ENV_VAR_2}".

The default basedir is the folder where build.xml is in, not the current working folder.

## task/build-dot.xml

```
info:
     [echo] basedir: /.../docker-demo/ant-demo/task
     [echo] user.dir: /.../docker-demo/ant-demo
```

Note:
The "." in <project basedir="." >" is resolved against the build file floder.

## task/build-user-dir.xml

```
BUILD FAILED
Basedir /.../docker-demo/ant-demo/task/${user.dir} does not exist
```

Note: "${user.dir} doesn't get resolved.

## task/build-system-property.xml

```
     [echo] basedir: /.../docker-demo/ant-demo
     [echo] user.dir: /.../docker-demo/ant-demo
```

Note: 'ANT_OPTS="-Dbasedir=$PWD"' or 'ant -Dbasedir="$PWD"' can be used to change the basedir for the ant build.
