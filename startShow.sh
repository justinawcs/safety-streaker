#!/bin/bash
# Starts info-beamer with given target
#title          : startShow.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20170527
#version        : 0.8
#usage          : bash startShow.sh
#notes          : .
#bash_version   : ???
#==============================================================================

tgt=$(cat /home/pi/info-beamer/target)
sudo /home/pi/info-beamer/info-beamer $tgt
