#!/bin/bash
# Sets time injury took place when run

## date -d "11/20/2003 12:48:00"
## would display date  November 20, 2003, 12:48 PM

./updateStreak.sh
date +%s > lastInjury
date >> lastInjury

cat lastInjury