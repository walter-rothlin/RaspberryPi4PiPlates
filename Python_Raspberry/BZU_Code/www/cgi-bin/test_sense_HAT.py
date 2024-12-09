#!/usr/bin/python3

# Apache error log: /var/log/apache2/error.log
from sense_hat import SenseHat
import os
import sys
import time
import datetime

print("Content-Type: text/html\n")
print("<H1>Python greift auf SenseHat zu</H1>")
sense = SenseHat()
currentTemp = sense.temp

logstr_2 = '-->{:%Y-%m-%d %H:%M:%S}'.format(datetime.datetime.now())
logstr_2 = logstr_2 + "<br/>"
logstr_2 = logstr_2 + " Temp:<b>{Temp:10.2f}</b>,".format(Temp=currentTemp)

print("Log:" + logstr_2 + "<BR/>")
print("<BR/>Noch alle LED loeschen!<BR/>")
sense.clear()
print("geloescht!!!<BR/>")