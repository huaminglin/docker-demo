#!/usr/bin/env bash

cd $(dirname $0)

export MY_ENV_VAR_1=VAR1

# ant -f task/build.xml

# ant -f task/build-dot.xml

# ant -f task/build-user-dir.xml

# ANT_OPTS="-Dbasedir=$PWD" ant -f task/build-system-property.xml

ant -Dbasedir="$PWD" -f task/build-system-property.xml
