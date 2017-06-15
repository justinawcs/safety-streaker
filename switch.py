#!/usr/bin/python
import RPi.GPIO as GPIO
import os
import time

GPIO.setmode(GPIO.BCM)

GPIO.setup(23, GPIO.IN, pull_up_down=GPIO.PUD_UP)

print "[switch.py]  Waiting for 'Injury Now' Button to be pressed..."
while True:
    input_state = GPIO.input(23)
    time.sleep(.1)
    if input_state == False:
        print('Injury Now Button Pressed!')
        print os.popen("/home/pi/safety-streaker/injuryNow.sh").read()
        time.sleep(1)
