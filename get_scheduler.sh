#!/bin/bash

source settings.cfg

cat /sys/block/$DEVICE/queue/scheduler | cut -d "[" -f2 | cut -d "]" -f1
