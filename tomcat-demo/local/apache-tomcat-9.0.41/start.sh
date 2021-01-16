#!/usr/bin/env bash
set -x
tmp_working_folder=/tmp/catalina

if [ ! -d "$tmp_working_folder" ]; then
    mkdir "$tmp_working_folder"
fi

export CATALINA_BASE="$(dirname $(realpath -s "$0"))"
export CATALINA_OUT=$tmp_working_folder/catalina.out
export CATALINA_TMPDIR=$tmp_working_folder

export CATALINA_OPTS="$CATALINA_OPTS -Dcatalina.log.folder=$tmp_working_folder -DSHUTDOWN_PORT=8125 -Dvar_mycgi=mycgi2"
$CATALINA_HOME/bin/startup.sh
