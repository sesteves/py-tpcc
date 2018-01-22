#!/usr/bin/env bash

for f in gets/*.txt; do
  cp $f get-ops-9.txt
  python encode.py encode | tail -n +2 > ../spmf/in.txt
  cd ../spmf/
  java -Xmx10g -jar spmf.jar run VMSP in.txt result 0.001 15 1
  cp result ../sequences/
  cd ../sequences/
  python encode.py decode > sequences-$(date +%s).txt
  rm get-ops-9.txt
done
