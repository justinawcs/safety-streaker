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
    
def testInput():
    print takeInput("Int?", int)
    print takeInput("Float?", float)
    print takeInput("String?", basestring)

testInput()