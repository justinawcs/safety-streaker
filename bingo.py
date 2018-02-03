#!/usr/bin/python
# Bingo Controller Script file
#title          : bingo.py
#description    : see above
#author         : Justin A. Williams
#date           : 20180202
#version        : 0.9
#usage          : bash bingo.py
#notes          : see below ##
#bash_version   : 4.3.30(1)-release [bash version]
#===============================================================================
import os, time
#from ControlMenu import printDesc, printOption, printPrompt

def formatBingo(number):
    if 1 <= number <= 15:
        return "B-" + str(number)
    elif 16 <= number <= 30:
        return "I-" + str(number)
    elif 31 <= number <= 45:
        return "N-" + str(number)
    elif 46 <= number <= 60:
        return "G-" + str(number)
    elif 61 <= number <= 75:
        return "O-" + str(number)
    else:
        return "Error. Not a bingo number"
#end formatBingo

def bingoHeader():
    time = os.popen("date").read().rstrip()
    return "##Bingo Game started at: " + time
#end bingoHeader

class BingoGame:
    date = os.popen("date").read().rstrip()
    pickedList = []
    
    def add(self, *num):
        
        if num in self.pickedList:
            self.pickedList.remove(num)
            return(formatBingo(num) + " was removed from list.")
        else:
            self.pickedList.append(num)
            return(formatBingo(num) + " was added to list.")
            
    def length(self):
        return len(self.pickedList)
        
    def load(self):
        #open and read file
        try:
            bingo_file = open("bingo.data", "r+")
            bingo_raw = bingo_file.readlines()
            #bingo_raw
            print bingo_raw
            bingo = ""
        except IOError: # file not there, so create blank
            bingo_file = open("bingo.data", "w")
            #pull date string and add to first line of file
            bingo_file.write(bingoHeader())
            bingo = ""
        #print bingo list
        print(bingo)
        return(bingo)
    #end load
    

## Run Section
#print formatBingo(1) +", "+ formatBingo(16) +", "+ formatBingo(32) \
#        +", "+ formatBingo(47) +", "+ formatBingo(64)
ex = BingoGame()
print ex.date
print ex.add(4)
print ex.pickedList
print ex.add(32)
print ex.pickedList
print ex.add(4)
print ex.pickedList