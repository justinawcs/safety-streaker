#!/bin/bash
# Compares current time since last injury to last best streak

## Note
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

