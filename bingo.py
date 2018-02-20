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
import json
#import pickle


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



class BingoGame:
    'Controller for a bingo game, does not pick  numbers'
    date = "" ## os.popen("date").read().rstrip() ## date created
    date_int = None 
    game_count = 0
    ##os.popen("date +%s").read().rstrip() ##date in seconds(unix-time)
    pickedList = []
    
#    def __init__(self):
#        #self.date = date
#        #self.date_int = date_int
#        #self.pickedList = pickedList
#        self.load()

    def add_item(self, num):
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
    
    def add(self, string):
        if string.find("+") > 0:
            result = string.split("+") #numpad implem. may use + for multi entry
        else:
            result = string.split() #will split at whitespace chars
        for i in result: 
            #print int(i)
            try:
                print self.add_item(int(i))
            except ValueError:
                print "Not a valid number. "
        self.save()
        return result
    #end tokenizer

    def length(self):
        return len(self.pickedList)
    
    def save(self):
        save_data = { "date":self.date, \
                    "date_int":self.date_int, \
                    "game_count":self.game_count, \
                    "pickedList":self.pickedList}
        #print "Save Data: ", save_data
        json.dump( save_data, open( "bingo/bingo.json", "wb" ) )
    #end save
    
    def load(self): #open and read file
        try:
            load_data = json.load( open( "bingo/bingo.json", "rb" ) )
            self.date = load_data["date"]
            self.date_int = load_data["date_int"]
            self.game_count = load_data["game_count"]
            self.pickedList = load_data["pickedList"]
        except IOError: # file not there, so create blank
            self.reset()
        #print data
        print "Load Data: ", self.date, self.date_int, \
                            self.game_count, self.pickedList
        #print self.pickedList
    #end load
    
    def reset(self): #clears enetered data and saves new file
        blank_date = os.popen("date").read().rstrip() #pulls current time
        blank_date_int = os.popen("date +%s").read().rstrip() 
        blank_list = []
        self.date = blank_date
        self.date_int = blank_date_int
        self.pickedList = blank_list
        self.incr_game_count()
        print "Reset Data: ",  blank_date, blank_date_int, \
                            self.game_count, blank_list
        self.save()
    #end reset
    
    def incr_game_count(self):
        self.game_count += 1
        self.save()
        
    def set_game_count(self, given):
        self.game_count = given
        self.save()
    
    def getHeader(self):
        return "Bingo Game #" + str(self.game_count) + " started at: " + self.date
    #end bingoHeader
    
    def getList(self):
        hold_string = ""
        for i in self.pickedList:
            hold_string += formatBingo(i) + ", "
        add_period = hold_string[:-2] + "."
        #print add_period
        return add_period # Replace with period at end


## Run/Test Section
def testing():
    #print formatBingo(1) +", "+ formatBingo(16) +", "+ formatBingo(32) \
    #        +", "+ formatBingo(47) +", "+ formatBingo(64)
    #ex = BingoGame()
#    ex.load()
#    ex.reset()
    #print "Current Data: ",  ex.date, ex.date_int, ex.pickedList
    
    #print "Empty List: ",   ex.pickedList
    #print ex.add(4)
    #print ex.add(72)
    #print ex.add(ex.add("16+23"))
    #print ex.pickedList
    #print ex.save()

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
    
    #ex = BingoGame()
    #print ex.add("23+34+56")
    #print ex.add(1)

    one = BingoGame()
    one.reset()
    print one.add("23+34+56")
    print one.add("72")
    print one.add("")
    print one.pickedList
    print one.getList()
    one.save()
    
    two = BingoGame()
    two.load()
#end testing

#testing()
