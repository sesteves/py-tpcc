#!/usr/bin/env bash

export CLASSPATH=lib/cache-mining.jar:lib/commons-codec-1.9.jar:lib/commons-collections-3.2.2.jar:lib/commons-configuration-1.6.jar:lib/commons-lang-2.6.jar:lib/commons-logging-1.2.jar:lib/guava-12.0.1.jar:lib/hadoop-auth-2.5.1.jar:lib/hadoop-client-2.5.1.jar:lib/hadoop-common-2.5.1.jar:lib/hbase-client-1.2.4.jar:lib/hbase-common-1.2.4.jar:lib/hbase-protocol-1.2.4.jar:lib/hbase-server-1.2.4.jar:lib/htrace-core-3.1.0-incubating.jar:lib/log4j-1.2.17.jar:lib/metrics-core-2.2.0.jar:lib/netty-all-4.0.23.Final.jar:lib/protobuf-java-2.5.0.jar:lib/slf4j-api-1.7.7.jar:lib/slf4j-log4j12-1.7.5.jar:lib/zookeeper-3.4.3.jar:resources/cachemining-log4j.properties:resources/cachemining.properties:resources/:.

~/jython-2.7/bin/jython  tpcc.py --no-load --debug hbase
