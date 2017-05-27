#!/bin/bash
# Compares current time since last injury to last best streak
#title          : checkStreak.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20170527
#version        : 0.8
#usage          : bash checkStreak.sh
#notes          : .
#bash_version   : ???
#==============================================================================

running=$(./daysSince.sh)
best=$(cat bestStreak)
echo  "Running Streak:" $running "Best Streak:" $best

 ## if running is greater than best
if [ $running -gt $best ]
then
  echo "This Streak is Larger than Best Streak!"
else
  echo "This Streak is Smaller than Best Streak."
fi

