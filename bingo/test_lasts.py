#!/usr/bin/python
# Tests the last bingo numbers in sequence for visual spacing problems
#title          : test_last_bingos.py
#description    : see above
#author         : Justin A. Williams
#date           : 20190204 [year-month-day]
#version        : 0.9
#usage          : python test_last_nums.py
#notes          : This progam will destroy all bingo number data!!
#bash_version   : 4.3.30(1)-release [bash version]
#===============================================================================
import sys
sys.path.append("../")
import os
import bingo

os.chdir("..")
a = bingo.BingoGame()
a.load()
a.reset()

list = range(1, 76)
for i in list:
    a.add_item(i)
    a.add_item(i-1)
    a.save()
    raw_input(str(i)+" Press enter for next>")
a.reset()
