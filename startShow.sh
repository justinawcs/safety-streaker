#!/bin/bash
# Starts info-beamer with given target
tgt=$(cat /home/pi/info-beamer/target)
sudo /home/pi/info-beamer/info-beamer $tgt
