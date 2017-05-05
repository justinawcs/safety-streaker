#!/bin/bash
# Replaces time of last injury with time given by prompts.
#title          : injuryTime.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20170501
#version        : 0.8
#usage          : bash injuryTime.sh
#notes          : see below ##
#bash_version   : ???
#==============================================================================
## date -d "11/20/2003 12:48:00"
## would display date  November 20, 2003, 12:48 PM

cd /home/pi/info-beamer/
echo "Enter Date of injury in MM/DD/YYYY format, then press [ENTER]"
echo "example: 02/14/12"
read day
echo "Enter Time of injury, example: 1:40pm OR 1340, then press [ENTER]"
echo "   1   2   3   4   5   6   7   8   9   10   11  12"
echo "   13  14  15  16  17  18  19  20  21  22   23  24"
read timer

./updateStreak.sh
date -d "$day $timer" +%s > lastInjury
date -d "$day $timer" >> lastInjury

cat lastInjury
# update all other lastInjury files
find . -name lastInjury | xargs touch