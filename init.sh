#!/bin/bash
# One-Time Setup of Safety-Streaker Boot script, in ~.bashrc
# Sets up environment for info-beamer, safety-streaker.
#title          : init.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20170528
#version        : 0.8
#usage          : bash init.sh
#notes          : see below -> ##
#bash_version   : ???
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
