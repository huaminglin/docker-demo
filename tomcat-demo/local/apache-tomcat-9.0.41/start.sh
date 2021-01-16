#!/usr/bin/env bash

export CATALINA_OPTS="$CATALINA_OPTS -DSHUTDOWN_PORT=8125"
$CATALINA_HOME/bin/startup.sh
