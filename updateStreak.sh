#!/bin/bash
# Updates best streak. 
# takes first number as the number of days in new steak

## if custom streak number is entered, set it and exit
if [ $# -ge 1 ] && [ "$1" -gt "0" ] 
then
  echo "Custom set best streak: " $1
  echo $1 > bestStreak
  exit
fi

running="$(./secondsSince.sh)"
best="$(cat bestStreak)"
#echo "Current streak information:"
#echo -e "New:" $running "Best:" $best "\n"

if [ $running -gt $best ]
  then
    # write running to bestStreak file
    echo "New Best Streak! Updated record!" $running "days."
    echo $running > bestStreak
  else
    echo "Days since last injury is shorter than Best streak."
fi