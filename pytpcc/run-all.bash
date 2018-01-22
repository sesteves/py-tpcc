#!/usr/bin/env bash

APP='tpcc'
# number of transactions
DURATION=350
HEADER="enabled,heuristic,cachesize,ngets,hits,negets,npfetch,hitpfetch,hitmpfetch,latency,seqset,transacs,runtime,rate"

sequences_file=sequences-all-$(date +%s).txt
stats_all_file=stats-all-$APP-$(date +%s).csv
echo $HEADER >> $stats_all_file

function execute {
  ~/jython-2.7/bin/jython -J-Xmx10g -Denabled=$enabled -Dcache-size=$cache_size -Dheuristic=$heuristic -Dsequences-file=$sequences_file tpcc.py --no-load --duration $DURATION --stop-on-error --debug --warehouses 1 hbase > out
  # for p in $(jps | grep -o -E "[0-9]+"); do kill -9 $p; done

  read -r _ transacs runtime rate _ < <(grep TOTAL out)
  stats_file=$(ls stats-cache-* | tail -n 1)
  cfg="$seqset,$transacs,$runtime,$rate"
  tail -n +2 $stats_file | sed -e "s/$/,$cfg/" >> $stats_all_file
}

#for enabled in 'false' 'true'; do
for enabled in 'true'; do
  if $enabled ; then
    #seqset=1
    seqset=5
    # for f in sequences/*.txt; do
    for f in sequences/sequences.txt; do
      cat $f >> $sequences_file
      for heuristic in 'fetch-all' 'fetch-top-n' 'fetch-progressively'; do
      # for heuristic in 'fetch-progressively'; do
        for cache_size in 2000 4000 8000 16000 32000 64000 128000 256000; do
        # for cache_size in 64000; do
          echo "Executing... (enabled: true, sequence-file: $seqset, heuristic: $heuristic, cache-size: $cache_size)"
#         if [ $seqset -eq 9 ]; then
          execute
#         fi
      done
      done
      ((seqset++))
    done
  else
    echo "Executing... (enabled: false)"
    heuristic=''
    cache_size=''
    seqset=''
    execute
  fi
done
