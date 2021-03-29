#!/usr/bin/env bash

index=0
while read mycmd;
do
    index=$((index+1))
    if [ ! -d /tmp/jcmd ]; then
        mkdir /tmp/jcmd
    fi
    logfile=/tmp/jcmd/jcmd-$index.log
    echo "$index: docker exec demoattach jcmd 1 $mycmd"
    echo "docker exec demoattach jcmd 1 $mycmd" > $logfile
    eval "docker exec demoattach jcmd 1 $mycmd" >>  $logfile 2>&1
done <<-EOF
Compiler.CodeHeap_Analytics
Compiler.codecache
Compiler.codelist
Compiler.directives_add
Compiler.directives_clear
Compiler.directives_print
Compiler.directives_remove
Compiler.queue
GC.class_histogram
GC.class_stats
GC.finalizer_info
/tmp/1.hprof
GC.heap_info
GC.run
GC.run_finalization
JFR.check
JFR.configure
JFR.dump
JFR.start
JFR.stop
JVMTI.agent_load
JVMTI.data_dump
ManagementAgent.start
ManagementAgent.start_local
ManagementAgent.status
ManagementAgent.stop
Thread.print
VM.class_hierarchy
VM.classloader_stats
VM.classloaders
VM.command_line
VM.dynlibs
VM.flags
VM.info
VM.log
VM.metaspace
VM.native_memory
VM.print_touched_methods
VM.set_flag
VM.stringtable
VM.symboltable
VM.system_properties
VM.systemdictionary
VM.uptime
VM.version
help
EOF

echo "Command count: $index"
