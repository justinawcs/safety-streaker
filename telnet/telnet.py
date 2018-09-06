#!/usr/bin/python
# Telnet tester
#title          : telnet.py
#description    : see above
#author         : Justin A. Williams
#date           : 20180906 [year-month-day]
#version        : 0.9
#usage          : bash telnet.py "Text to send"
#notes          : Sends given text string to port 4444, to be read by I-B visual
#bash_version   : 4.3.30(1)-release [bash version]
#===============================================================================
import sys
import socket

msg = ""
try:
    msg = sys.argv[1]
except:
    msg = ""
    print "Error. No input provided."

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.sendto('telnet/msg:%s' % msg, ('127.0.0.1', 4444))
