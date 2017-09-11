# HBase Cassandra Benchmark

## Overview
This benchmark is designed to run with HBase and Cassandra and automates the steps in benchmark to make sure the result is reproducible

## Pre-requisites
* **HBase or Cassandra installed**. The benchmark is designed to run on dedicated cluster.
* **Dedicated hardware**. AWS can have noisy neighbours and thus is not a reliable place for benchmark, unless you are using dedicated instances.
* **Maven**. YCSB depends on maven to run
* **YCSB** [Repo here](https://github.com/brianfrankcooper/YCSB/)

## Command steps
Clone YCSB and download code from this repo, place into the same YCSB root folder.
So you should see bench.sh under your YCSB folder

## HBase steps
Place hbase-site.xml (Usually found under /etc/hbase/hbase.conf/hbase-site.xml) into ./YCSB/hbase10/conf

*Note:* You'll likely have to create the conf directory by yourself.

In HBase shell ($>hbase shell) run the follwoing command to create tables
```
create 'usertable', 'cf', {SPLITS => (1..200).map {|i| "user#{1000+i*(9999-1000)/200}"}, MAX_FILESIZE => 
4*1024**3}
```
Run
./bench_hbase.sh to start benchmark
Results will be logged in individual log files

For more details, see here:
https://github.com/brianfrankcooper/YCSB/tree/master/hbase10

## Cassandra steps
Open bench_cassandra.sh, edit "hosts" (line 9) variable. Replace it with your cassandra instance's IP or hostname

Run cqlsh host to get into cql shell.
Then run 
```
cqlsh> create keyspace ycsb
    WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor': 3 };
cqlsh> USE ycsb;
cqlsh> create table usertable (
    y_id varchar primary key,
    field0 varchar,
    field1 varchar,
    field2 varchar,
    field3 varchar,
    field4 varchar,
    field5 varchar,
    field6 varchar,
    field7 varchar,
    field8 varchar,
    field9 varchar);
```
Run
./bench_cassandra.sh to start benchmark
Results will be logged in individual log files.

For more details, see here: https://github.com/brianfrankcooper/YCSB/tree/master/cassandra

## Questions?
Reach out to me via message or leave a comment. I'll help you out!