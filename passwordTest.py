#!/usr/bin/python
# Test of a simple password system for ControlMenu.py
#title          : passwordTest.py
#description    : see above
#author         : Justin A. Williams
#date           : 20180131
#version        : 0.9
#usage          : python passwordTest.py
#notes          : see below ##
#bash_version   : 4.3.30(1)-release [bash version]
#===============================================================================
## low security password file
## next step: looping, hashed password
import sys
import getpass

#open and read file
try:
    code_file = open("passcode.data", "r+")
    code = code_file.readline().rstrip()
except IOError: # file not there, so create and fill
    code_file = open("passcode.data", "w")
    code = "1234"
    code_file.write(code)

#passcode reminder
print "Password Tester. Code is: '" + code + "'"

#get passcode attempt
user_input = getpass.getpass("Enter passcode: ")
if user_input != code:
	sys.exit("Wrong Passcode...bye!")
print "Code accepted."

#change passcode
user_input = getpass.getpass("Press enter to close, or enter new passcode" +
                        "(min. length is 4): ")

#close script on no input
if user_input == '':
    sys.exit("Goodbye.")

#check passcode length, exit on too short
if len(user_input) < 4:
    sys.exit("Passcode too short. Goodbye.")

#reenter password, cause password entry cannot be seen
check_user_input = getpass.getpass("Please enter passcode again to verify: ")
if check_user_input != user_input:
    sys.exit("Passcodes do not match. Goodbye")

#write new passcode to file
code = user_input
code_file.seek(0)
code_file.write(code)
code_file.truncate()
print "Current passcode: '"+ code + "'\nGoodbye."
code_file.close()
