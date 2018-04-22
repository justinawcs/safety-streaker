#!/usr/bin/python
# Test for new input implementation.
#title          : inputTest.py
#description    : see above
#author         : Justin A. Williams
#date           : 20180411 [year-month-day]
#version        : 0.9
#usage          : python inputTest.py
#notes          : Goal: return only integer, float, string 
#bash_version   : 4.3.30(1)-release [bash version]
#===============================================================================
import os
# print int("7")
# print int("seven")
# print float("6")
# print str(5+5)

def takeInput(prompt, expectedType):
    if expectedType == int or expectedType == float:
        try:
            sel = input(prompt + "> ") # use input to pre-check types
        except NameError:
            print expectedType,  "was expected, not string"
            return None
    else: # expectedType == string-type
        sel = raw_input(prompt + "> ")
    if isinstance(sel, expectedType):
        # just return it
        return sel
    elif isinstance(sel, int): # force float
        print expectedType,  "was expected, forced: float"
        return float(sel)
    elif isinstance(sel, float): #force int
        print expectedType,  "was expected, forced: int"
        return int(sel)
    else:
        print expectedType,  "was expected, not: ",  type(sel) 
        return None

def takeDate(promptType):
    #take date
    print "%s in MM/DD/YYYY then press [ENTER]" % promptType
    print "example: 02/14/2001"
    day  = str(takeInput("Enter Date", basestring))
    #take time
    print "Enter Time in HHMM or HH:MM(am/pm) then press [ENTER]"
    print "example: 1:40pm -> 1340"
    print "AM: 00  01  02  03  04  05  06  07  08  09  10  11"
    print "PM: 12  13  14  15  16  17  18  19  20  21  22  23"
    time = str(takeInput("Enter Time", basestring))
    #check date and time as valid
    cmd1 = "date -d '" + day +" "+ time + "'"
    cmd2 = "date -d '" + day +" "+ time + "' +%s"
    cmdCheck = str(cmd1 + "; echo $?")
    result = str(os.popen(cmd1).read()).rstrip()
    result_err = str(os.popen(cmdCheck).read()).rstrip()
    get_err = result_err.splitlines()
    error_code = get_err[-1]
    #print(error_code, type(error_code))
    if(error_code == "0"): #Zero is success
        return "Date Accecpted: "+ result
    else:
        return "Date Rejected: "+ result_err

def takeBinary(prompt):
    None
    
def testInput():
    #print takeInput("Int?", int)
    #print takeInput("Float?", float)
    #print takeInput("String?", basestring)
    #print lines_arr[-1]
    print takeDate("Test a GOOD Date")
    print takeDate("Test a BAD Date")

#testInput()