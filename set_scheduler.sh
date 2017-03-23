#!/bin/bash

source settings.cfg

if [ "$EUID" -ne 0 ]; then
   echo "Forgot sudo!"
   exit 1
fi

echo $1 > /sys/block/$DEVICE/queue/scheduler 2> /dev/null || (echo "Invalid scheduler" && exit 2)
echo "Current sheduler:"
./get_scheduler.sh
