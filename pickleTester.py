#!/usr/bin/python
# Example and Test Script for pickle saving and loading
#title          : pickleTester.py
#description    : see above
#author         : Justin A. Williams
#date           : 20180207
#version        : 0.9
#usage          : bash pickleTester.py
#notes          : see below ##
#bash_version   : 4.3.30(1)-release [bash version]
#===============================================================================
import os, pickle

class PickleTester:
    name = "Justin"
    age = 32
    fav = ["a", "b", "d"]
    about_me = {"name":name, "age":age, "fav":fav}
    
    def __init__(self):
        print "SETUP: "
        print self.about_me.values()
        self.load()
    
    def update(self):
        #print about_me
        #print zip["fav"]
        #about_me = {"Russ", 36}
        print "CHANGE: "
        self.about_me["fav"].append("xyz")
        print self.about_me
        self.save()
        
    def save(self):
        #save
        pickle.dump( self.about_me, open( "me.data", "wb" ) )
        ##print os.popen("cat me.data").read()
    
    def load(self):
        #load
        load_me = pickle.load( open( "me.data", "rb" ) )
        print "OUT: "
        print load_me
        self.name = load_me["name"]
        self.age = load_me["age"]
        self.fav = load_me["fav"]
        print (self.name, self.age, self.fav)
    #end PickleTester

tt = PickleTester()