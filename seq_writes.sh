#!/bin/bash

total=0
scheduler=$(./get_scheduler.sh)
output=results/${scheduler}_${NUM_FILES}f_${SIZE}b_${NUM_THREADS}t
> $output
for i in $(seq 1 $1); do
    rm -rf generated/*
    start=$SECONDS
    ./target/seq_writes.o $NUM_FILES $SIZE $NUM_THREADS generated 4096 >/dev/null 
    time=$((SECONDS-start))
    echo $time >> ${output}
    total=$((total+time))
    echo "Run $i of $1 done, took $time seconds."
done

echo $((total/$i)) > ${output}_avg
