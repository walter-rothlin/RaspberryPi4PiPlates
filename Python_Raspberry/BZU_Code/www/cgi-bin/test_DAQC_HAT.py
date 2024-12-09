#!/usr/bin/python3
# Apache error log: /var/log/apache2/error.log
import os
import sys
import time
import datetime
import piplates.DAQCplate as DAQC

print("Content-Type: text/html\n\n")
print()
print("Hello from Raspberry!!!!!")
print("<br/>")

print("LED 1..7 on...")
for i in range(0,7):
    DAQC.setDOUTbit(1,i)
    time.sleep(1)

print("LED 1..7 off!")
for i in range(0,7):
    DAQC.clrDOUTbit(1,i)
    time.sleep(1)