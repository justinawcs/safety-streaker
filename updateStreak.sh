#!/bin/bash
# Updates best streak. takes first number as the number of days in new steak
#title          : updateStreak.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20170701
#version        : 0.9
#usage          : bash updateStreak [set streak]
#notes          : see below -> ##
#bash_version   : 4.3.30(1)-release
#==============================================================================
## if custom streak number is entered, set it and exit
#cd $WORK

cd /home/pi/safety-streaker/
if [ $# -ge 1 ] && [ "$1" -ge "0" ]
then
  echo "Custom set best streak: " $1
  echo $1 > bestStreak.data
  exit
fi

running="$(./daysSince.sh)"
best="$(cat bestStreak.data)"
#echo "Current streak information:"
#echo -e "New:" $running "Best:" $best "\n"

if [ $running -gt $best ]
  then
    # write running to bestStreak.data file
    echo "New Best Streak! Updated record!" $running "days."
    echo $running > bestStreak.data
    find . -name bestStreak.data | xargs touch
  else
    echo "Days since last injury is shorter than Best streak."
fi
