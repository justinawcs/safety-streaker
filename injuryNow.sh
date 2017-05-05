#!/bin/bash
# Replaces time of last injury with current time.
#title          : injuryNow.sh
#description    : see above
#author         : Justin A. Williams 
#date           : 20170501
#version        : 0.8    
#usage          : bash injuryNow.sh
#notes          : .
#bash_version   : ???
#==============================================================================

## date -d "11/20/2003 12:48:00"
## would display date  November 20, 2003, 12:48 PM

cd $WORK
./updateStreak.sh
date +%s > lastInjury
date >> lastInjury

cat lastInjury
# update all other lastInjury files
find . -name lastInjury | xargs touch -c 