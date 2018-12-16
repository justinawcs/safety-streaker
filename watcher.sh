#!/bin/bash
# Shortcut to watch output each second, with change hightlights
#title          : watcher.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20181215 [year-month-day]
#version        : 0.91
#usage          : bash wacther.sh [some-output.py]
#notes          : try "./" or call the full path to call file
#bash_version   : 4.3.30(1)-release [bash version]
#===============================================================================
if [ $# -ge 1 ]
  then
    watch -cd -n 1 ./$1
  else
    echo "Error: command not found"
    exit 1
fi
