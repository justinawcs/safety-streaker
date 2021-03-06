#!/bin/bash
# Gives time since last injury in days
#title          : daysSince.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20170701
#version        : 0.9
#usage          : bash daysSince.sh
#notes          : see below -> ##
#bash_version   : 4.3.30(1)-release
#==============================================================================
## Note:
## sed 'NUMq;d' file
## returns the Num-th line of the file

time=$(sed '1q;d' lastInjury.data)
#echo $time
now=$(date +%s)
seconds=$(expr $now - $time)

## 86400 seconds in a day
expr $seconds / 86400
