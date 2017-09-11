#!/bin/bash
workloads=("workloadd" "workloade" "workloadf")

repeatrun=3
records=300000000
operations=10000000
threads=400
driver="cassandra-cql"
hosts="host.ip.address"

for work in "${workloads[@]}"
do
        echo "Loading data for" $work
        ./bin/ycsb load $driver -P ./workloads/$work -p hosts=$hosts -p recordcount=$records -threads 40 > $work"_load.log"

        echo "Running tests"
        for r in `seq 1 $repeatrun`
        do
                ./bin/ycsb run $driver -P ./workloads/$work -p hosts=$hosts -p recordcount=$records -p operationcount=$operations -threads $threads > $work"_run_"$r".log"
        done
        #Truncate table and start over
        cqlsh -f cassandra_truncate $hosts
done
