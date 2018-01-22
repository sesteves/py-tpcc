#!/usr/bin/env bash

DURATION=700

for i in {1..10}; do

  ~/jython-2.7/bin/jython tpcc.py --no-load --duration $DURATION --warehouses 1 --debug hbase

  python encode.pyencode | tail -n +2 > spmf/in.txt
  cd spmf
  java -Xmx10g -jar spmf.jar run VMSP in.txt result 0.001 15 1
  cp result ..
  cd ..
  python encode.py decode >> $seqf
done 

