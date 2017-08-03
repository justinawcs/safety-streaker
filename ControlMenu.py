#!/usr/bin/python
# Main Control Menu for info-beamer & safety-streaker.
#title          : ControlMenu.py
#description    : see above
#author         : Justin A. Williams
#date           : 20170701
#version        : 0.9
#usage          : bash ControlMenu.py
#notes          : see below -> ##
#bash_version   : 4.3.30(1)-release
#===============================================================================
## Assists in viewing and changing injury times, and streak count, system status
## Useable with only numerical keypad.
## May need backspace key to be user friendly
import os
import subprocess
import sys
#import pickTarget

def pickTarget():
    looking = True
    while looking:
        run = "find . -name node.lua"
        lis = os.popen(run).read()
        #print list
        linelist = lis.splitlines()
        #print linelist
        #print linelist[0]
        printDesc("\nChoose which visual from below.")
        visual = os.popen("cat target.data").read().rstrip()
        ind = visual.rfind("/")
        vis = visual[ind+1:]
        printDesc("Current visual: " + vis +" ( "+visual+" )")
        printOption(0, "Go back...")
        for index in range(len(linelist)):
            s = linelist[index].replace("/node.lua", "").lstrip("./")
            printOption(index+1, s)
        sel2 = None
        try:
            sel2 = int(input(printPrompt()))
            #print linelist[sel2 + 1]
            if(sel2 != 0):
                #ends function if yes
                target = linelist[sel2 - 1]
                pwd = os.popen("pwd").read().rstrip()
                tgt = target.replace(".", pwd, 1).replace("/node.lua", "")
                print "Target updated: " + tgt
                os.popen("echo " + tgt + " > target.data")
                print os.popen("cat target.data").read().rstrip()
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

def color(col, string):
    start = '\033['
    end = '\033[0m'
    colors = {'head':'4;91m', 'subhead':'31m', 'desc':'33m',
    'num':'1;32m', 'prompt':'1;30;42m'}
    ## head, sub header, desc, num, prompt
    return (start + colors[col] + string + end)
#end color()

def printOption(index, string):
    print " " + color('num', str(index)) +" "+ string
#end option

def printPrompt():
    return color('prompt', "Enter an option> ") + " "
#end prompt

def printDesc(string):
    print color('desc', string)

##Main Menu
# 1 Control Info-beamer ->
# 2 Show Status: last injury, best streak, days since
# 3 Set Last Injury Time to Now
# 4 Set Last Injury Date and Time
# 5 Change Best Streak
# 6 Shutdown

## Startup
if(len(sys.argv) > 1 and sys.argv[1] == "--test"):
    print "Testing Directory in use!"
else:
    print "Using standard directory:"
    os.chdir('/home/pi/safety-streaker')

print os.getcwd()
#start dataLink cascade on: lastInjury.dat, bestStreak
print os.popen("./linkData.sh lastInjury.data").read()
print os.popen("./linkData.sh bestStreak.data").read()
#start visual
print os.popen("./startShow.sh").read()
#after visual
## this promt is needed to clear the input line for the menu, [bug]
raw_input("Press Enter to continue...")
running = True

## Loop -- Main Menu
while running == True:
    print "\n\n" + color('head', "Safety-Streaker")
    print color('subhead',"Digital Signage Controller Main Menu")
    h_date = os.popen("date").read().rstrip()
    print color('subhead', "Current Time is: ") + h_date
    printDesc("Choose a option from below:")
    printOption(1, "Start the visual")
    printOption(2, "Choose which visual")
    printOption(3, "Show System Status: Last Injury, Best Streak,"\
        + " Time/Days Since")
    printOption(4, "Reset Last Injury to right now")
    printOption(5, "Reset Last Injury to another date/time")
    printOption(6, "Set System Time")
    printOption(7, "Set Best Streak")
    printOption(8, "Set ForEvergreen/Kermit Percent")
    printOption(9, "Exit / Restart / Shutdown")
    sel = ""
    try:
        option = str(input(printPrompt()))
        sel = int(option)
    except NameError:
        print "Bad input, try again.\n"
    except SyntaxError:
        print "Bad input, try again.\n"
    except Exception:
        print "General Exepected Error, try again.\n"
    if sel == 9:
        printDesc("\nAre you sure you want to exit/restart/shutdown?")
        printOption(0, "Go Back")
        printOption(1, "Exit, (close Control Menu, Expert users only!!)")
        printOption(2, "Restart")
        printOption(9, "Shutdown, (need power cycle to turn back on)")
        opt = input(printPrompt())
        sel2 = int(opt)
        if sel2 == 1:
            print "Exiting..."
            running = False
            # should close
        elif sel2 == 2:
            print "Restarting system now..."
            running = False
            os.popen("sudo shutdown -r now")
        elif sel2 == 9:
            printDesc("\nWARNING - Shutdown for this device requires this device")
            printDesc("be DISCONNECTED from power and THEN RECONNNECTED to ")
            printDesc("turn on again. Are you sure you wish to continue??")
            printOption(0, "Go back")
            printOption(9, "Shutdown")
            sel3 = int(input(printPrompt()))
            if sel3 == 9:
                print "Shutting down now..."
                running = False
                os.popen("sudo shutdown -H now")
    elif sel == 1:
        # Info-beamer block
        print "Starting Info-Beamer"
        print os.popen("./startShow.sh").read()
        raw_input("Press Enter to return to menu...")
        #print "contro
    elif sel == 2:
        # default visual block
        pickTarget()
    elif sel == 3:
        # Status block
        curr = os.popen("date").read().rstrip()
        last = os.popen("cat lastInjury.data").read().rstrip()
        index = last.find("\n")
        last = last[index+1:]
        best = os.popen("cat bestStreak.data").read().rstrip()
        days = os.popen("./daysSince.sh").read().rstrip()
        trgt = os.popen("cat target.data").read().rstrip()
        ind = trgt.rfind("/")
        vis = trgt[ind+1:]
        secs = int(os.popen("./secondsSince.sh").read().rstrip())
        hours = (secs / 3600) - int(days)
        temp = os.popen("cat /sys/class/thermal/thermal_zone0/temp") \
                .read().rstrip()
        temp2 = float(temp) / 1000
        uptm = os.popen("uptime -p").read().rstrip()
        perc = os.popen("cat kermit/percent.data").read().rstrip()
        print "Current Status:\nCurrent Time:\t\t", curr
        print "System Uptime:\t\t", uptm
        print "CPU Temp:    \t\t", temp2, "degrees Celcius"
        print "Last Injury: \t\t", last
        print "Since Injury:\t\t", days, "days ",hours, "hours"
        print "             \t\t", secs, "total seconds"
        print "Best Streak: \t\t", best, "days"
        print "ForEvergreen %:\t\t", perc, "%"
        print "Visual:      \t\t", vis , " (",trgt, ")"
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
        last = os.popen("cat lastInjury.data").read().rstrip()
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
            print "AM: 00  1   2   3   4   5   6   7   8   9   10   11"
            print "PM: 12  13  14  15  16  17  18  19  20  21  22   23"
            time = str(raw_input("Enter Time > "))
            print os.popen("./updateStreak.sh").read()
            cmd1 = "date -d '" + day +" "+ time + "' +%s > lastInjury.data"
            cmd2 = "date -d '" + day +" "+ time + "' >> lastInjury.data"
            #print cmd1, cmd2
            os.popen(cmd1).read()
            os.popen(cmd2).read()
            print os.popen("cat lastInjury.data").read().rstrip()
            print os.popen("find . -name lastInjury.data | xargs touch").read()
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
            print "AM: 00  1   2   3   4   5   6   7   8   9   10   11"
            print "PM: 12  13  14  15  16  17  18  19  20  21  22   23"
            time = str(raw_input("Enter Time > "))
            # print os.popen("date -s '", day, time, "'").read()
            cmd1 = "date -s '" + day +" "+ time + "'"
            # print cmd1
            print "New time:", os.popen(cmd1).read().rstrip()
            print "System clock: ", os.popen("date").read().rstrip()
        # print "new time"
    elif sel == 7:
        # set streak
        best = os.popen("cat bestStreak.data").read().rstrip()
        print "Best Streak: ", best
        print "Enter New Best Streak Without Injury"
        try:
            newBest  = int(input("Enter > "))
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
    elif sel ==8:
        #set ForEvergreen/Kermit Percent
        old = os.popen("cat kermit/percent.data").read().rstrip()
        print "Old Percent: " + old
        print "Enter New Percent(program will add % symbol): "
        try:
            perc = input("Enter > ")
        except NameError:
            print "Bad input, try again.\n"
        except SyntaxError:
            print "Bad input, try again.\n"
        except Exception:
            print "General Exepected Error, try again.\n"
        if perc >= 0:
            cmd1 = "echo '" + str(perc) + "' > kermit/percent.data"
            os.popen(cmd1).read().rstrip()
            print "New ForEvergreen percent set: ", perc, "%"
            print os.popen("cat kermit/percent.data").read().rstrip()
    else:
        print "Unknown option. Please try again "
print "Goodbye. \nPro-tip: typing 00 at command line will open Control Menu"
