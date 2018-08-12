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
import math

def convert_seconds(seconds, time_unit="days"):
    """ Supported units: minutes, hours, days, weeks, years.
        NOTE: this function DOES NOT take any leap days into account
    """
    if seconds < 0:
        raise ValueError("Value for seconds should be positive", seconds)
    if time_unit == "minutes":
        return seconds / 60
    elif time_unit == "hours":
        return seconds / 3600 #(60 * 60)
    elif time_unit == "days":
        return seconds / 86400 #(60 * 60 * 24)
    elif time_unit == "weeks":
        return seconds / 604800 #(60 * 60 * 24 * 7)
    elif time_unit == "years":
        return seconds / 31536000 #(60 * 60 * 24 * 365)
    else:
        print "Supported units: minutes, hours, days, weeks, years."
        raise ValueError("Invalid time supported", time_unit)

def cascade_units(seconds, depth=2):
    """Flows through each unit descending to create a string of non-zero units,
        up to given depth of values. Depth = 0 will return all non-zero units.
        Example: 4000 sec -> "1 hour, 6 minutes, 40 seconds"
        Example: 4000 sec at depth=2 -> "1 hour, 6 minutes"
    """
    #units = (31536000, 604800, 86400, 3600, 60)
    #labels = ('years', 'weeks', 'days', 'hours', 'minutes')
    times = ( (31536000, 'years'), (604800, 'weeks'), (86400, 'days'),
            (3600, 'hours'), (60, 'minutes') )
    result = ""
    for item in times:
        whole = math.floor( seconds / item[0] )
        print( "Seconds: %d / Divisor: %d  = Quotient: %d" % 
                (seconds, item[0], whole) )
        #part = seconds % item[0]
        if whole > 0:
            seconds -= whole * item[0]
            result += ", %d " % whole + item[1]  
    result += ", %d seconds" % seconds 
    return result.lstrip(', ').strip() + "." 

class Configuration:
    """Loads and saves data to config.json"""
    cfg = {
        "best_streak" : 0,
        "last_injury": {
            "date": "", 
            "unix_time": 0,
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
            #touch all same-name files in folders below to update for I.Beamer
            os.popen("find . -name config.json | xargs touch")
    
    def check_streak(self):
        """Compares current time since last injury to last best streak"""
        curr_streak = self.cfg["last_injury"]["unix_time"]
        best_streak = self.cfg["best_streak"]
        print "Current Streak: ", curr_streak, "  Best Streak: ", best_streak 
        if (curr_streak > best_streak):
            return "This streak is Longer than Best Streak"
        else:
            return "This Streak is Shorter than Best Streak"
    
    def update_streak(self, new_streak=None):
        """Updates best streak. Takes number of days in new steak"""
        curr_streak = self.cfg["last_injury"]["unix_time"]
        best_streak = self.cfg["best_streak"]
        print "Current Streak: ", curr_streak, "  Best Streak: ", best_streak 
        if new_streak:
            try:
                self.cfg["best_streak"] = int(new_streak)
            except TypeError:
                print "Integer expected for best_streak value"
            print "Best Streak hard-set at: ", self.cfg["best_streak"]
            self.save()
        elif curr_streak > best_streak:
            #update object and write to file
            self.cfg["best_streak"] = curr_streak
            print "New Best Streak! Records Updated. ", curr_streak
            self.save()
        else:
            print "Time Since last injury is shorter than Best Streak."
        
    def time_since_injury(self, time_units="seconds", depth=1):
        """Displays time since last injury in given time units"""
        last = int( self.cfg["last_injury"]["unix_time"] )
        now = int( os.popen("date +%s").read().rstrip() )
        since = now - last
        print("Last: %d  Now: %d  Since: %d seconds" % (last, now, since))
        if depth != 1:
            return cascade_units(since, depth)
        elif time_units != "seconds":
            return convert_seconds(since, time_units),time_units
        else:
            return since
        
    def update_injury(self, date=None, unix_time=None, now=True):
        """Updates and saves new injury data. Pass nothing(or now=True) to set 
           to current time. Pass a date string and unix_time to set to that 
           time."""
        if date and unix_time: 
            given_time={
                "date": date,
                "unix_time": unix_time
            }
            self.cfg["last_injury"] = given_time
            self.save()
        elif date or unix_time:
            raise ValueError("Both date string and unix_time integer" \
                            "are required.", date, unix_time)
        elif now:
            now_time={
                "date": os.popen("date").read().rstrip(),
                "unix_time": os.popen("date +%s").read().rstrip()
            }
            self.cfg["last_injury"] = now_time
            self.save()
        else:
            raise ValueError("""Provide date string and unix_time to update 
                injury or now=True for current time.""")
    
    def import_old_data(self):
        """ Imports old .data  config files to this .json format. Only needs to
            runs once.
        """
        try:
            with open('bestStreak.data') as best_streak_file:
                streak_data = best_streak_file.read().strip()
                self.set("best_streak", streak_data)
                print "Load Best Streak: ", streak_data
            with open('target.data') as target_file:
                target_data = target_file.read().strip()
                self.set("target", target_data)
                print "Load Target File", target_data
            with open('lastInjury.data') as last_injury_file:
                line_list = last_injury_file.read().strip().splitlines()
                #first line -- unix time, second line -- date string
                injury_dict = { "unix_time": line_list[0], 
                                "date": line_list[1] }
                self.set("last_injury", injury_dict)
                print injury_dict
            self.save()
            return True #success
        except IOError:
            print "File not found!"
        return False #failure
        
def testing():
    #Convert seconds
    print 61, convert_seconds(61, "minutes")
    print 3601, convert_seconds( 3601, "hours")
    print 86401, convert_seconds(86401, "days")
    print 604801, convert_seconds(604801, "weeks")
    print 31536001, convert_seconds(31536001, "years")
    #Cascade units
    #print cascade_units(65)
    print cascade_units(4500)
    print cascade_units(40000000)
    #Get and set
    alpha = Configuration()
    #print alpha.get("bestStreak"), " -> ", alpha.set("bestStreak", 12)
    #load
    #alpha.load()
    #Small change
    #print alpha.set("target", "here/i/am")
    #Save
    #alpha.save()
    #Check streak
    #print alpha.check_streak()
    #Update Streak
    #alpha.update_streak()
    #alpha.update_streak(43)
    #Update Injury
    #alpha.update_injury("Monday, January 1, 2018 12:00:01 AM", 1514764801) 
    #alpha.update_injury()
    alpha.set("last_injury",  
            {"date" : "Monday, January 1, 2018 12:00:01 AM", 
            "unix_time" : 1514764801})
    print alpha.time_since_injury()
    print alpha.time_since_injury("minutes")
    print alpha.time_since_injury("hours")
    print alpha.time_since_injury(depth=0)
    alpha.import_old_data()
#testing()