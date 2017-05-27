#!/bin/bash
# Sets up environment for info-beamer, safety-streaker.
# IMPORTANT Add this script to ~/.bashrc to load at startup.
#title          : init.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20170527
#version        : 0.8
#usage          : bash init.sh
#notes          : see below -> ##
#bash_version   : ???
#==============================================================================
## ADD line below (with out ##) to ~/.bashrc
## sudo ~/safety-streaker/init.sh

export WORK=/home/pi/info-beamer/
cd $WORK
alias 00=$WORK/ControlMenu.py
pidof -x switch.py
if [[ $? == 0 ]]
  then
    echo "Injury Switch watcher already running..."
  else
    sudo $WORK/switch.py&
fi
sleep 2
sudo $WORK/ControlMenu.py
