#!/usr/bin/python3
# Apache error log: /var/log/apache2/error.log
import os
import sys
import time
import datetime
import piplates.DAQCplate as DAQC

print("Content-Type: text/html\n\n")
print()
print("Temperatur (1): " + str(DAQC.getTEMP(1,0,'c')) + " C")
print("<br/>")
print("Temperatur (2): " + str(DAQC.getTEMP(1,1,'c')) + " C")
print("<br/>")
