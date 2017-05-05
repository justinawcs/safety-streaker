#!/usr/bin/python
# Assists in control over info-beamer, injury times, and streak count.
# Useable with only numerical keypad.
# May need backspace key to be user friendly
#title          : ControlMenu.py
#description    : see above
#author         : Justin A. Williams 
#date           : 20170502
#version        : 0.8    
#usage          : bash ControlMenu.py
#notes          : .
#bash_version   : ???
#==============================================================================
import os
import subprocess
#import pickTarget


def pickTarget():
    looking = True
    while looking:
        run = "find . -name node.lua"
        list = os.popen(run).read()
        #print list
        linelist = list.splitlines()
        #print linelist
        #print linelist[0]
        print "\nChoose default visual from below."
        print "0 Go back..."
        for index in range(len(linelist)):
            s = linelist[index].replace("/node.lua", "").lstrip("./")
            print " " + str(index+1) +" "+ s
        sel2 = None
        try:
            sel2 = int(input("Enter an option> "))
            #print linelist[sel2 + 1]
            if(sel2 != 0):
                #ends function if yes
                target = linelist[sel2 - 1] 
                pwd = os.popen("pwd").read().rstrip()
                tgt = target.replace(".", pwd, 1).rstrip("/node.lua")
                print "Target updated: " + tgt
                os.popen("echo " + tgt + " > target")
                print os.popen("cat target").read().rstrip()
                looking = False
            else:
                print "Going back to Control Menu..."
                looking = False
        except NameError:
                print "Bad input, try again.\n"
        except SyntaxError:
                print "Bad input, try again.\n"
        except IndexError:
                print "That number is not valid, try again.\n"
        except Exception:
                print "General Exepected Error, try again.\n"
#end pickTarget


##Main Menu
# 1 Control Info-beamer ->
# 2 Show Status: last injury, best streak, days since
# 3 Set Last Injury Time to Now
# 4 Set Last Injury Date and Time
# 5 Change Best Streak
# 6 Shutdown

os.popen("./startShow")
running = True
while running == True:
    print "\nDigital Safety Signage Controller Main Menu"
    h_date = os.popen("date").read().rstrip()
    print "Current Time is " + h_date
    print "Chose a option from below:"
    print " 1 Start Info-Beamer"
    print " 2 Choose default visual"
    print " 3 Show Full Status: Last Injury, Best Streak, Time/Days Since"
    print " 4 Reset Last Injury to right now"
    print " 5 Reset Last Injury to custom time"
    print " 6 Set System Time..."
    print " 7 Change Best Streak"
    print " 8 Restart / Shutdown / Exit"
    sel = ""
    try: 
        option = str(input("Enter an option> "))
        sel = int(option)
    except NameError:
        print "Bad input, try again.\n"
    except SyntaxError:
        print "Bad input, try again.\n"
    except Exception:
        print "General Exepected Error, try again.\n"
    if sel == 8:
        print "Are you sure you want to restart/shutdown?"
        print " 0 Go Back"
        print " 1 Restart"
        print " 2 Exit, (close Control Menu, Expert users only!!)"
        print " 9 Shutdown, (need power cycle to turn back on)"
        opt = input("Enter option> ")
        sel2 = int(opt)
        if sel2 == 1:
            print "Restarting system now..."
            running = False
            os.popen("sudo shutdown -r now")
        elif sel2 == 2:
            print "Exiting..."
            running = False
            # should close
        elif sel2 == 9:
            print "WARNING - Shutdown for this device means that the device"
            print "must be DISCONNECTED from power and THEN RECONNNECTED to "
            print "turn on again. Are you sure you want to do this"
            print " 0 Go back"
            print " 9 Shutdown"
            sel3 = int(input("Enter an option> "))
            if sel3 == 9:
                print "Shutting down now..."
                running = False
                os.popen("sudo shutdown -H now")
    elif sel == 1:
        # Info-beamer block
        print "Starting Info-Beamer"
        print os.popen("./startShow.sh").read()
        #print "contro
    elif sel == 2:
        # default visual block
        pickTarget()
    elif sel == 3:
        # Status block
        curr = os.popen("date").read().rstrip()
        last = os.popen("cat lastInjury").read().rstrip()
        index = last.find("\n")
        last = last[index+1:]
        best = os.popen("cat bestStreak").read().rstrip()
        days = os.popen("./daysSince.sh").read().rstrip()
        print "Current Status:\nCurrent Time:\t\t", curr
        print "Last Injury: \t\t", last
        print "Since Injury:\t\t", days, "days"
        print "Best Streak: \t\t", best, "days"
        raw_input("Press Enter to continue...")
        # print ""
    elif sel == 4:
        # reset injury now
        curr = os.popen("date").read().rstrip()
        print "Set Last Injury to current time :", curr
        print " 0 Go Back"
        print " 1 Set Last Injury time to now"
        try:
            opt = input("Enter option> ")
            sel2 = int(opt)
        except NameError:
            print "Bad input, try again.\n"
        except SyntaxError:
            print "Bad input, try again.\n"
        except Exception:
            print "General Exepected Error, try again.\n"
        if sel2 == 1:
            print os.popen("./injuryNow.sh").read()
        else:
            print "Bad input."
        # print "injury now"
    elif sel == 5:
        # reset injury custom time
        last = os.popen("cat lastInjury").read().rstrip()
        index = last.find("\n")
        last = last[index+1:]
        print "Last Injury: ", last
        print "Set Last Injury to custom time?"
        print " 0 Go Back"
        print " 1 Set Time"
        try:
            opt = input("Enter option> ")
            sel2 = int(opt)
        except NameError:
            print "Bad input, try again.\n"
        except SyntaxError:
            print "Bad input, try again.\n"
        except Exception:
            print "General Exepected Error, try again.\n"
        if sel2 == 1:
            # print os.popen("./injuryTime.sh").read()
            # rebuilt from injuryTime.sh
            print "Enter Date of injury in MM/DD/YYYY then press [ENTER]"  
            print "example: 02/14/2001"
            day  = str(raw_input("Enter Date > "))
            print "Enter Time of injury, example: 1340 OR 1:40pm " + \
                    "then press [ENTER]" 
            time = str(raw_input("Enter Time > "))
            print os.popen("./updateStreak.sh").read()
            cmd1 = "date -d '" + day +" "+ time + "' +%s > lastInjury"
            cmd2 = "date -d '" + day +" "+ time + "' >> lastInjury"
            #print cmd1, cmd2
            os.popen(cmd1).read()
            os.popen(cmd2).read()
            print os.popen("cat lastInjury").read().rstrip()
        # print "custom time"
    elif sel == 6:
        # set system time
        print "System Time ", os.popen("date").read().rstrip()
        print "Set System clock?"
        print " 0 Go Back"
        print " 1 Set Time"
        try:
            opt = input("Enter option> ")
            sel2 = int(opt)
        except NameError:
            print "Bad input, try again.\n"
        except SyntaxError:
            print "Bad input, try again.\n"
        except Exception:
            print "General Exepected Error, try again.\n"
        if sel2 == 1:
            print "Enter Correct Date in MM/DD/YYYY then press [ENTER]"  
            print "example: 02/14/2001"
            day  = str(raw_input("Enter Date > "))
            print "Enter Time, example: 1:40pm OR 1340 then press [ENTER]" 
            time = str(raw_input("Enter Time > "))
            # print os.popen("date -s '", day, time, "'").read()
            cmd1 = "date -s '" + day +" "+ time + "'"
            # print cmd1
            print "New time:", os.popen(cmd1).read().rstrip()
            print "System clock: ", os.popen("date").read().rstrip()
        # print "new time"
    elif sel == 7:
        # set streak
        best = os.popen("cat bestStreak").read().rstrip()
        print "Best Streak: ", best
        print "Enter New Best Streak Without Injury"
        try:
            newBest  = int(input("Enter  > "))
        except NameError:
            print "Bad input, try again.\n"
        except SyntaxError:
            print "Bad input, try again.\n"
        except Exception:
            print "General Exepected Error, try again.\n"
        if newBest >= 0:
            cmd1 = "./updateStreak.sh " + str(newBest)
            print os.popen(cmd1).read().rstrip()
            # print "set streak"
        else:
            print "Number must be positive!"
    else:
        print "Unknown option. Please try again "
print "Goodbye. \nPro-tip: typing 00 at command line will open Control Menu"
