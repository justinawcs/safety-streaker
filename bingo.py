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
import os
import pickle
#from ControlMenu import printDesc, printOption, printPrompt
## add method need to take in lists

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

def tokenizer(str):
    if str.find("+") > 0:
        return str.split("+") #numpad implementation may use + for multi entry
    else:
        return str.split() #will split at whitespace chars
#end tokenizer

class BingoGame:
    date = "" ## os.popen("date").read().rstrip() ## date created
    date_int = None ## os.popen("date +%s").read().rstrip() ##date in seconds(unix)
    pickedList = []
    
#    def __init__(self):
#        #self.date = date
#        #self.date_int = date_int
#        #self.pickedList = pickedList
#        self.load()

    def add(self, num):
        #print(num + len(num))
        #for i in num:
        number = int(num)
        if 1 <= int(number) <= 75: 
            if number in self.pickedList: #remove if already on list
                self.pickedList.remove(number)
                return(formatBingo(number) + " was removed from list.")
            else: #add to list
                self.pickedList.append(number)  
                return(formatBingo(number) + " was added to list.")
        else:
            return "Number out of range!"
    #end add

    def length(self):
        return len(self.pickedList)
    
    def save(self):
        save_data = { "date":self.date, \
                    "date_int":self.date_int, \
                    "pickedList":self.pickedList}
        print "Save Data: ", save_data
        pickle.dump( save_data, open( "bingo.data", "wb" ) )
    #end save
    
    def load(self): #open and read file
        try:
            load_data = pickle.load( open( "bingo.data", "rb" ) )
            self.date = load_data["date"]
            self.date_int = load_data["date_int"]
            self.pickedList = load_data["pickedList"]
        except IOError: # file not there, so create blank
            self.reset()
        #print data
        print "Load Data: ", self.date, self.date_int, self.pickedList
        #print self.pickedList
    #end load
    
    def reset(self): #clears enetered data and saves new file
        blank_date = os.popen("date").read().rstrip() #pulls current time
        blank_date_int = os.popen("date +%s").read().rstrip() 
        blank_list = []
        self.date = blank_date
        self.date_int = blank_date_int
        self.pickedList = blank_list
        print "Reset Data: ", blank_date, blank_date_int, blank_list
        self.save()
    #end reset
    
    def getHeader(self):
        return "Bingo Game started at: " + self.date
    #end bingoHeader
    
    def getList(self):
        hold_string = ""
        for i in self.pickedList:
            hold_string += formatBingo(i) + ", "
        return hold_string # Replace with period at end


## Run/Test Section
def testing():
    #print formatBingo(1) +", "+ formatBingo(16) +", "+ formatBingo(32) \
    #        +", "+ formatBingo(47) +", "+ formatBingo(64)
    ex = BingoGame()
#    ex.load()
#    ex.reset()
    print "Current Data: ",  ex.date, ex.date_int, ex.pickedList
    
    #print "Empty List: ",   ex.pickedList
    print ex.add(4)
    print ex.add(72)
    #print ex.add(13)
    print ex.save()

    #print ex.date
    #print ex.add(4)
    #print ex.pickedList
    #print ex.add(32)
    #print ex.pickedList
    #print ex.add("4")
    #print ex.pickedList
    #print ex.add("74")
    #print ex.pickedList

    #given1 = "23+45+90"
    #given2 = "23 45 90"
    #print tokenizer(given1)
    #print tokenizer(given2)
    #print add(tokenizer(given1))  #add does not currently accept lists

    #ex.save()
    #ex.load()
#end testing