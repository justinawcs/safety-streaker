#!/bin/bash
# Creates linked files in folders below current path for given file
#title          : cascadeData.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20170715
#version        : 0.9
#usage          : bash cascadeData.sh [given file]
#notes          : Necessary for .data files.
#bash_version   : 4.3.30(1)-release
#===============================================================================
for i in $(ls -d */)
do
  ln -P  $1 $i/$1
done
