#!/bin/bash
# Updates best streak.
# takes first number as the number of days in new steak
#title          : updateStreak.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20170504
#version        : 0.8
#usage          : bash updateStreak [set streak]
#notes          : .
#bash_version   : ???
#==============================================================================

## if custom streak number is entered, set it and exit
#cd $WORK
cd /home/pi/info-beamer/
if [ $# -ge 1 ] && [ "$1" -ge "0" ]
then
  echo "Custom set best streak: " $1
  echo $1 > bestStreak
  exit
fi

running="$(./daysSince.sh)"
best="$(cat bestStreak)"
#echo "Current streak information:"
#echo -e "New:" $running "Best:" $best "\n"

if [ $running -gt $best ]
  then
    # write running to bestStreak file
    echo "New Best Streak! Updated record!" $running "days."
    echo $running > bestStreak
    find . -name bestStreak | xargs touch
  else
    echo "Days since last injury is shorter than Best streak."
fi