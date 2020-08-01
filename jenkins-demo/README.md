# Jenkins cluster

## Master node

Make sure 1000:1000 owns /var/tmp/jenkins_home.


## Setup a slave node

1) Add a slave on management console

Manage Jenkins > Manage Nodes > New Node > Permanent Agent

http://127.0.0.1:8080/computer/slave1/

Run from agent command line:

java -jar slave.jar -jnlpUrl http://127.0.0.1:8080/computer/slave1/slave-agent.jnlp -secret 7208793d9fef46681eb51b5d3907d9046ed741c2b8cb9d19064b1373bed6b6ea

2) Run the slave.jar

Make sure 1000:1000 owns /var/tmp/jenkins_slave_home.

After the master node is ready, run "sudo docker start jenkins-demo_slave_1" to start the slave node

3) TCP connection to 50000

A slave node will keep a TCP connection to 50000 port of the master node.

sudo docker run -it --rm --net=container:jenkins-demo_slave_1 nicolaka/netshoot bash

tcp                      ESTAB                     0                          0                                              192.168.128.3:41578                                          192.168.128.2:50000

This TCP connection uses TLS.

## Create a project and limit it to run on the slave only.

Jenkins project configuration: Restrict where this job can be run

By default, builds of this project may be executed on any build agents that are available and configured to accept new builds.

When this option is checked, you have the possibility to ensure that builds of this project only occur on a certain agent, or set of agents.

For example, if your project should only be built on a certain operating system, or on machines that have a certain set of tools installed, or even one specific machine, you can restrict this project to only execute on agents that that meet those criteria.
