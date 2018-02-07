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
    print "SETUP: "
    about_me = {"name":name, "age":age, "fav":fav}
    print about_me
    #print zip["fav"]
    #about_me = {"Russ", 36}
    print "CHANGE: "
    about_me["fav"].append("xyz")
    print about_me
    #save
    pickle.dump( about_me, open( "me.data", "wb" ) )
    ##print os.popen("cat me.data").read()
    #load
    load_me = pickle.load( open( "me.data", "rb" ) )
    print "OUT: "
    print load_me
    name = load_me["name"]
    age = load_me["age"]
    fav = load_me["fav"]
    print (name, age, fav)
#end PickleTester

tt = PickleTester()