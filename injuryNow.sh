#!/bin/bash
# Replaces time of last injury with current time.
#title          : injuryNow.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20170701
#version        : 0.9
#usage          : bash injuryNow.sh
#notes          : see below -> ##
#bash_version   : 4.3.30(1)-release
#==============================================================================
## date -d "11/20/2003 12:48:00"
## would display date  November 20, 2003, 12:48 PM

cd /home/pi/safety-streaker/
./updateStreak.sh
date +%s > lastInjury.data
date >> lastInjury.data

cat lastInjury.data
# update all other lastInjury.data files
find . -name lastInjury.data | xargs touch
