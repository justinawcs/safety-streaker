#!/bin/bash
# Gives time since last injury in days

## Note:
## sed 'NUMq;d' file
## returns the Num-th line of the file

time=$(sed '1q;d' lastInjury) 
#echo $time
now=$(date +%s)
seconds=$(expr $now - $time)

## 86400 seconds in a day
expr $seconds / 86400 