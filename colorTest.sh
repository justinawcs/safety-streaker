#!/bin/bash
# Test of the color scheme for ControlMenu
#title          : colorTest.sh
#description    : see above
#author         : Justin A. Williams
#date           : 20180118
#version        : 0.9
#usage          : bash colorTest.sh
#notes          : None
#bash_version   : 4.3.30(1)-release
#===============================================================================
#Text effect: underline and light red
echo -e "\e[4;91mFirst\e[0m"

#Text effect: red
echo -e "\e[31mSecond\e[0m"

#Text effect: yellow
echo -e "\e[33mThird\e[0m"

#Text effect: bold and green text then just normal text
echo -e "\e[1;32mNum\e[0m Option"

#Text effect: bold/bright text
echo -e "\e[1mOption\e[0m"

#Text effect: bold with greeb backround and black text
echo -e "\e[1;30;42mPrompt\e[0m"
