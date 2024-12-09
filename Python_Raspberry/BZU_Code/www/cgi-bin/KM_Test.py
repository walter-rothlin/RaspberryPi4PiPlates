#!/usr/bin/python3
# Apache error log: /var/log/apache2/error.log
import os
import sys
import time
import datetime
import piplates.DAQCplate as DAQC

from Class_KaelteMacherMaschine import *
from waltisLibrary              import *

print("Content-Type: text/html\n\n")

hsrKaelteMaschine = KaelteMacherMaschine()


print("<H1>Kaeltemacher Solar-Steuerung</H1>")
print("<img src=\"/Kaeltemacher_Logo.jpg\"><BR>")
print(hsrKaelteMaschine.toString())

