#!/usr/bin/python
# Tester for hardware button.
#title          : buttonTest.py
#description    : see above
#author         : Justin A. Williams
#date           : 20170805
#version        : 0.9
#usage          : bash buttonTest.py
#notes          : see below -> ##
#bash_version   : 4.3.30(1)-release
#===============================================================================
## Runs at boot, place reference to this file in ~/.bashrc
## External button is connected to pin 23 on this machine.
import RPi.GPIO as GPIO
import os
import time

GPIO.setmode(GPIO.BCM)

GPIO.setup(23, GPIO.IN, pull_up_down=GPIO.PUD_UP)

print "[switch.py]  Waiting for 'Injury Now' Button to be pressed..."
waiting = True
while waiting:
    input_state = GPIO.input(23)
    time.sleep(.1)
    if input_state == False:
        print('Injury Now Button Pressed!')
        #print os.popen("/home/pi/safety-streaker/injuryNow.sh").read()
        waiting = False
	time.sleep(1)