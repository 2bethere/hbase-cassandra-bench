#!/bin/bash
workloads=("workloada" "workloadb" "workloadc" "workloadd" "workloade" "workloadf")

repeatrun=3
records=300000000
operations=10000000
threads=400
driver="hbase10"

for work in "${workloads[@]}"
do
        echo "Loading data for" $work
        ./bin/ycsb load $driver -P ./workloads/$work -p columnfamily=cf -p hbase.zookeeper.znode.parent=/hbase-unsecure -p recordcount=$records -threads 40 > $work"_load.log"
        echo "Running tests"
        for r in `seq 1 $repeatrun`
        do
                ./bin/ycsb run $driver -P ./workloads/$work -p columnfamily=cf -p hbase.zookeeper.znode.parent=/hbase-unsecure -p recordcount=$records -p operationcount=$operations -threads $threads > $work"_run_"$r".log"
        done
        #Truncate table and start over
        hbase shell ./hbase_truncate
done