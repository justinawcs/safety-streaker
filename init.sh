#!/bin/bash
# One-Time Setup of Safety-Streaker Boot script, in ~.bashrc
#title          : init.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20170701
#version        : 0.9
#usage          : bash init.sh
#notes          : Sets up environment for info-beamer, safety-streaker.
#bash_version   : 4.3.30(1)-release
#==============================================================================
# echo ~

export WORK=/home/pi/safety-streaker/
cd $WORK
alias 00='sudo $WORK/ControlMenu.py'
pidof -x switch.py
if [[ $? == 0 ]]
  then
    echo "Injury Switch watcher already running..."
  else
    sudo $WORK/switch.py&
fi
sleep 2
sudo $WORK/ControlMenu.py
