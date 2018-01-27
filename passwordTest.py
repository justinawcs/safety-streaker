#!/usr/bin/python
# Test of a simple password system for ControlMenu.py
#title          : passwordTest.py
#description    : see above
#author         : Justin A. Williams
#date           : 20180127
#version        : 0.9
#usage          : python passwordTest.py
#notes          : see below ##
#bash_version   : 4.3.30(1)-release [bash version]
#===============================================================================
## low security password file, in progress needs minimum for passodes
## next step: hashed password
import sys

#open and read file
code_file = open("passcode.data", "r+")
code = code_file.readline().rstrip()

#passcode reminder
print "Password Tester. Code is: '" + code + "'"

#get user input
user_input = raw_input("Enter passcode: ")
if user_input != code:
	sys.exit("Wrong Passcode...bye!")
print "Code accepted."

#change passcode
user_input =raw_input("Press enter to close, or enter new passcode: ")
print "Entered code: '" + user_input + "'"
if user_input == '':
    sys.exit("Goodbye.")

#write to file
code = user_input
code_file.seek(0)
code_file.write(code)
code_file.truncate()
print "Current passcode: '"+ code + "'\n Goodbye."
code_file.close()

