#!/bin/bash
# Sets time injury took place from given

## Note
## date -d "11/20/2003 12:48:00"
## would display date  November 20, 2003, 12:48 PM


echo "Enter Date of injury in MM/DD/YYYY format, then press [ENTER]"  
echo "example: 02/14/2001"
read day
echo "Enter Time of injury, example: 1:40pm OR 1340, then press [ENTER]" 
read time

./updateStreak.sh
date -d "$day $time" +%s > lastInjury
date -d "$day $time" >> lastInjury

cat lastInjury