#!/usr/bin/python
# Shows program/system status from ControlMenu
#title          : status.py
#description    : see above
#author         : Justin A. Williams
#date           : 20181215 [year-month-day]
#version        : 0.91
#usage          : python status.py (--live)
#notes          : [see below ##]
#bash_version   : 4.3.30(1)-release [bash version]
#===============================================================================
import ControlMenu
import config
import sys
import os

config = config.Configuration()
config.load()
ControlMenu.print_status(config)

if(len(sys.argv) > 1 and sys.argv[1] == "--live"):
    print os.popen("watch -d -n 1 ./status.py")
