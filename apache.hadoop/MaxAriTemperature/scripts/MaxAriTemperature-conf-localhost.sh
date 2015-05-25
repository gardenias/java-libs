#!/bin/bash

##############################################################################
##
##  MaxAriTemperature start up script for Linux
##
##############################################################################

DEFAULT_JVM_OPTS=""

APP_NAME="MaxAriTemperature"

warn ( ) {
    echo "$*"
}

die ( ) {
    echo
    echo "$*"
    echo
    exit 1
}

excute(){
    echo "======"
    echo "exec "+"$*"
    exec "$*"
    echo "======"
}

# Attempt to set APP_HOME
PRG="$0"
SAVED="`pwd`"
cd "`dirname \"$PRG\"`/.." >&-
APP_HOME="`pwd -P`"
cd "$SAVED" >&-

CLASSPATH=$APP_HOME/build/libs/MaxAriTemperature-1.0.jar:$APP_HOME/build/classes/main

# Determine the Java command to use to start the JVM.
if [ -n "$JAVA_HOME" ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
        # IBM's JDK on AIX uses strange locations for the executables
        JAVACMD="$JAVA_HOME/jre/sh/java"
    else
        JAVACMD="$JAVA_HOME/bin/java"
    fi
    if [ ! -x "$JAVACMD" ] ; then
        die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
    fi
else
    JAVACMD="java"
    which java >/dev/null 2>&1 || die "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
fi

# Determine the Hadoop command to use to start the job.
if [ -n "$HADOOP_HOME" ] ; then
    if [ -x "$HADOOP_HOME/bin/hadoop" ] ; then
        # IBM's JDK on AIX uses strange locations for the executables

        HADOOPCMD="$HADOOP_HOME/bin/hadoop"
    fi
    if [ ! -x "$HADOOPCMD" ] ; then
        die "ERROR: HADOOP_HOME is set to an invalid directory: $HADOOP_HOME

Please set the HADOOP_HOME variable in your environment to match the
location of your Hadoop installation."
    fi
else
    HADOOPCMD="hadoop"
    which hadoop >/dev/null 2>&1 || die "ERROR: HADOOP_HOME is not set and no 'hadoop' command could be found in your PATH.

Please set the HADOOP_HOME variable in your environment to match the
location of your Hadoop installation."
fi

#-classpath "$CLASSPATH"

# conf file spe
CONF=$APP_HOME/conf/hadoop-localhost.xml
# local data input path
LOCAL_INPUT=$APP_HOME/input/ncdc/all/
# server data input path
DATANODE_INPUT=input/ncdc/all
# server hdfs output path
OUTPUT=output/max-ari-temperature-tmp-conf-localhost

## clearHDFSPath CMD
#CLEAR_HDFS_PATH_CMD="$HADOOPCMD fs -conf $CONF -rmdir $DATANODE_INPUT"
## copyFromLocal CMD
#COPY_FROM_LOCAL_CMD="$HADOOPCMD" fs -conf "$CONF" -copyFromLocal "$LOCAL_INPUT" "$DATANODE_INPUT"
## submit job CMD
#SUBMIT_JOB_CMD="$HADOOPCMD" \
#        jar "$APP_HOME"/repos/MaxAriTemperature-1.0.jar \
#        -conf "$CONF" \
#        "$DATANODE_INPUT" \
#        "$OUTPUT"

# echo "$CLEAR_HDFS_PATH_CMD"
# echo "$HADOOPCMD" fs -conf "$CONF" -rm -R "$DATANODE_INPUT"
# exec "$HADOOPCMD" fs -conf "$CONF" -rm -R "$DATANODE_INPUT"

# echo "$COPY_FROM_LOCAL_CMD"
# echo "$HADOOPCMD" fs -conf "$CONF" -copyFromLocal "$LOCAL_INPUT" "$DATANODE_INPUT"
# exec "$HADOOPCMD" fs -conf "$CONF" -copyFromLocal "$LOCAL_INPUT" "$DATANODE_INPUT"

#echo "$SUBMIT_JOB_CMD"
exec "$HADOOPCMD" \
        jar "$APP_HOME"/repos/MaxAriTemperature-1.0.jar \
        -conf "$CONF" \
        "$DATANODE_INPUT" \
        "$OUTPUT"