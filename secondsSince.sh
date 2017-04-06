#!/bin/bash
# Gives time since last injury

## Note:
## sed 'NUMq;d' file
## returns the Num-th line of the file

time=$(sed '1q;d' lastInjury) 
#echo $time
now=$(date +%s)
expr $now - $time