#!/usr/bin/env bash

cd $(dirname $0)

echo 'javac'
sudo docker exec -it jdk8-demo_server_1 javac -d /tmp /mount/java/Class1.java

sudo docker exec -it jdk8-demo_server_1 javap -v -classpath /tmp Class1

echo
echo
echo '----------------------------------'
echo 'javac -parameters'

sudo docker exec -it jdk8-demo_server_1 javac -parameters -d /tmp /mount/java/Class1.java

sudo docker exec -it jdk8-demo_server_1 javap -v -classpath /tmp Class1

echo
echo
echo '----------------------------------'
echo 'javac -g'

sudo docker exec -it jdk8-demo_server_1 javac -g -d /tmp /mount/java/Class1.java

sudo docker exec -it jdk8-demo_server_1 javap -v -classpath /tmp Class1

echo
echo
echo '----------------------------------'
echo 'javac -g:none'

sudo docker exec -it jdk8-demo_server_1 javac -g:none -d /tmp /mount/java/Class1.java

sudo docker exec -it jdk8-demo_server_1 javap -v -classpath /tmp Class1


echo
echo
echo '----------------------------------'
echo 'javac -g -parameters'

sudo docker exec -it jdk8-demo_server_1 javac -g -parameters -d /tmp /mount/java/Class1.java

sudo docker exec -it jdk8-demo_server_1 javap -v -classpath /tmp Class1
