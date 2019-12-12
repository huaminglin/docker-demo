# ansible-demo

Create a ubuntu container as the ansible control node;
Docker host is treaded as ansible managed node.

## Create a Ubuntu container to setup ansible manually

docker create -it --name demoansible ubuntu:18.04 bash
docker start demoansible
docker exec -it demoansible bash

apt-get update

apt install software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt install ansible

## Setup SSH access from docker container to docker host

ssh-keygen
ssh-copy-id user1@172.17.0.1

## Set up /etc/ansible/hosts to config docker host as testmanagedservers

docker cp demoansible:/etc/ansible/hosts .

docker cp ./hosts demoansible:/etc/ansible/hosts

## Ansible ad hoc CLI

ansible all -m ping
ansible all -a "/bin/echo hello"

ansible testmanagedservers -m setup
ansible testmanagedservers -m ping

## Ansible Playbook

docker cp ./playbook-test.yml demoansible:/playbook-test.yml

ansible-playbook /playbook-test.yml
