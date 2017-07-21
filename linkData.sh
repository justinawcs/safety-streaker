#!/bin/bash
# Creates linked files in all folders below current path for given file
#title          : linkData.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20170721
#version        : 0.9
#usage          : bash linkData.sh [given file]
#notes          : Necessary for .data files.
#bash_version   : 4.3.30(1)-release
#===============================================================================
for i in $(ls -d */)
do
  ln -b -f -P --suffix=".old" -v $1 $i/$1
done
