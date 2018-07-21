#!/usr/bin/python
# Configuration Editor Script
#title          : config.py
#description    : see above
#author         : Justin A. Williams
#date           : 20180719
#version        : 0.9
#usage          : bash config.py
#notes          : see below ##
#bash_version   : 4.3.30(1)-release [bash version]
#===============================================================================
import os
import json

class Configuration:
    'Loads and saves data to config.json'
    cfg = {
        "bestStreak" : 0,
        "lastInjury": {
            "date": "", 
            "seconds": 0,
        }, 
        "target"  : "",
        "password" : {
            "activated" : False,
            "code" : "8899",
        }
    }
    
    def get(self, key):
        return self.cfg[key]
    
    def set(self, key, value):
        self.cfg[key] = value
        return self.cfg[key]
    
    def load(self):
        with open('config.json') as cfg_file:
            self.cfg = json.load(cfg_file)
            print str(self.cfg)
    
    def save(self):
        with open("config.json", "w") as cfg_file:
            json.dump(self.cfg, cfg_file, sort_keys = True, indent = 4 )
            print str(self.cfg)
    
def testing():
    #get and set
    alpha = Configuration()
    print alpha.get("bestStreak"), " -> ", alpha.set("bestStreak", 12)
    #load
    alpha.load()
    #small change
    print alpha.set("target", "here/i/am")
    #save
    alpha.save()
    
testing()