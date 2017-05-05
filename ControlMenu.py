#!/usr/bin/python
# Assists in control over info-beamer, injury times, and streak count.
# Useable with only numerical keypad.

import os
import subprocess


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
    print "Chose a option below:"
    print " 1 Start Info-Beamer..."
    print " 2 Choose default visual"
    print " 3 Show Full Status: Last Injury, Best Streak, Time/Days Since"
    print " 4 Reset Last Injury to right now"
    print " 5 Reset Last Injury to custom time"
    print " 6 Set System Time..."
    print " 7 Change Best Streak"
    print " 8 Restart / Shutdown"
    option = str(raw_input("Enter option> "))
    sel = int(option.lower())
    if sel == 8:
        print "Are you sure you want to restart/shutdown?"
        print " 0 Go Back"
        print " 1 Restart"
        print " 2 Shutdown"
        opt = input("Enter option> ")
        sel2 = int(opt)
        if sel2 == 1:
            print "Restarting system now..."
            running = False
            os.popen("sudo shutdown -h now")
        elif sel2 == 2:
            print "Shutting down now..."
            running = False
            os.popen("sudo shutdown -r now")
    elif sel == 1:
        # Info-beamer block
        print "Starting Info-Beamer"
        os.popen("./startShow").read()
        #print "control"
    elif sel == 2:
        # default visual
        print "Currently Non-functional."
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
        # print ""
    elif sel == 4:
        # reset injury now
        curr = os.popen("date").read().rstrip()
        print "Set Last Injury to current time :", curr
        print " 0 Go Back"
        print " 1 Set Time"
        opt = input("Enter option> ")
        sel2 = int(opt)
        if sel2 == 1:
            print os.popen("./injuryNow.sh").read()
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
        opt = input("Enter option> ")
        sel2 = int(opt)
        if sel2 == 1:
            # print os.popen("./injuryTime.sh").read()
            # rebuilt from injuryTime.sh
            print "Enter Date of injury in MM/DD/YYYY then press [ENTER]"  
            print "example: 02/14/2001"
            day  = str(raw_input("Enter Date > "))
            print "Enter Time of injury, example: 1:40pm OR 1340 then press [ENTER]" 
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
        opt = input("Enter option> ")
        sel2 = int(opt)
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
        newBest  = str(input("Enter  > "))
        cmd1 = "./updateStreak.sh " + newBest
        print os.popen(cmd1).read().rstrip()
        # print "set streak"
    else:
        print "Unknown option. Please try again "
