#!/bin/bash
# Replaces time of last injury with time given by prompts.
#title          : injuryTime.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20170701
#version        : 0.9
#usage          : bash injuryTime.sh
#notes          : see below -> ##
#bash_version   : 4.3.30(1)-release
#==============================================================================
## date -d "11/20/2003 12:48:00"
## would display date  November 20, 2003, 12:48 PM

cd /home/pi/safety-streaker/
echo "Enter Date of injury in MM/DD/YYYY format, then press [ENTER]"
echo "example: 02/14/12"
read day
echo "Enter Time of injury, example: 1:40pm OR 1340, then press [ENTER]"
echo "AM: 00  1   2   3   4   5   6   7   8   9   10   11"
echo "PM: 12  13  14  15  16  17  18  19  20  21  22   23"
read timer

./updateStreak.sh
date -d "$day $timer" +%s > lastInjury.data
date -d "$day $timer" >> lastInjury.data

cat lastInjury.data
# update all other lastInjury.data files
find . -name lastInjury.data | xargs touch
