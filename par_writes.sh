#!/bin/bash

source settings.cfg
total=0
scheduler=$(./get_scheduler.sh)
output=$RESULTS_DIR/${scheduler}_${NUM_FILES}f_${SIZE}b_${NUM_THREADS}t
> $output
for i in $(seq 1 $1); do
    rm -rf generated/*
    start=$SECONDS
    ./target/par_writes $NUM_FILES $SIZE $NUM_THREADS $OUTPUT_DIR $BUF_SIZE >/dev/null 
    time=$((SECONDS-start))
    echo $time >> ${output}
    total=$((total+time))
    echo "Run $i of $1 done, took $time seconds."
done

echo $((total/$i)) > ${output}_avg
