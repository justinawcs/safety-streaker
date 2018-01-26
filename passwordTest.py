#!/usr/bin/python
# Test of a simple password system for ControlMenu.py
#title          : passwordTest.py
#description    : see above
#author         : Justin A. Williams
#date           : 20180124
#version        : 0.9
#usage          : bash passwordTest.py
#notes          : see below ##
#bash_version   : 4.3.30(1)-release [bash version]
#===============================================================================
## no secuirty password
import sys

print "Password Tester"
code = "4021"
user_input = raw_input("Enter passcode: ")
if user_input != code:
	sys.exit("Wrong Passcode...bye!")
print "Code accepted."
