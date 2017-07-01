#!/bin/bash
# Compares current time since last injury to last best streak
#title          : checkStreak.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20170701
#version        : 0.9
#usage          : bash checkStreak.sh
#notes          : .
#bash_version   : 4.3.30(1)-release
#==============================================================================

running=$(./daysSince.sh)
best=$(cat bestStreak.data)
echo  "Running Streak:" $running "Best Streak:" $best

 ## if running is greater than best
if [ $running -gt $best ]
then
  echo "This Streak is Larger than Best Streak!"
else
  echo "This Streak is Smaller than Best Streak."
fi

