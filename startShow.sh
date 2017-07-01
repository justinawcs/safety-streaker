#!/bin/bash
# Starts info-beamer with given target
#title          : startShow.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20170701
#version        : 0.9
#usage          : bash startShow.sh
#notes          : .
#bash_version   : 4.3.30(1)-release
#==============================================================================

tgt=$(cat /home/pi/safety-streaker/target.data)
sudo info-beamer $tgt
