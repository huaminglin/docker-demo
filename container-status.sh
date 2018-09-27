#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo Please provide a docker container id.
    echo "Usage container-status.sh <container id> [environ][cmdline][lsof][network]"
    exit 1
fi

echo "/////////////////exe////////////////////"
docker exec -it "$1" sh -c 'readlink /proc/1/exe'

echo "/////////////////host pid////////////////////"
cid=$(docker ps -aqf "name=$1")
echo cid: $cid
host_pids=$(ps -e -o pid,comm,cgroup | grep "/docker/$cid" | cut -f1 -d " ")
if [ -z "$host_pids" ]; then
    host_pids=$(ps -e -o pid,comm,cgroup | grep "/docker/$cid" | cut -f2 -d " ")
fi
echo host_pids: $host_pids

case "$*" in
*network*)
    echo "/////////////////ip////////////////////"
    docker exec -it "$1" sh -c 'ip addr'
    ;;
esac

for host_pid in $host_pids; do
    for var in "$@"; do
        case "$var" in
        *environ*)
            echo "/////////////////environ: $host_pid////////////////////"
            cat /proc/$host_pid/environ | tr \\0 \\n
            ;;
        *cmdline*)
            echo "/////////////////cmdline: $host_pid////////////////////"
            cat /proc/$host_pid/cmdline | tr \\0 \\n
            ;;
        *lsof*)
            echo "/////////////////lsof: $host_pid////////////////////"
            lsof -p $host_pid
            ;;
        *network*)
            echo "/////////////////tcp: $host_pid////////////////////"
            cat /proc/$host_pid/net/tcp
            ;;
        esac
    done
done
