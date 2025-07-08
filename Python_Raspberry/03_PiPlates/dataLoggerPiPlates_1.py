#!/usr/bin/python3

# ------------------------------------------------------------------
# Name  : dataLoggerPiPlates_1.py
# Source: https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_WaltisExamples/Code_06_Pi_Plate/dataLoggerPiPlates_1.py
#
# Description: Data-Logger
#
#
# Autor: Walter Rothlin
#
# History:
# 01-Dec-2023   Walter Rothlin      Initial Version
#
# ------------------------------------------------------------------

import os
import sys
import time
import datetime
from waltisLibrary import *

import piplates.DAQCplate      as DAQC 
import piplates.RELAYplate     as RELAY 
from   Class_DAQC_LedLine      import *
from   Class_TemperaturSensor  import *

finished = False
dataFileName = "DataFile.txt"
logFileName  = "DataFile.log"


i = 0
isOn = True
DAQC.setDOUTbit(1, 0)

temp1 = TemperaturSensor("Vorlauf", 1, 0)
temp2 = TemperaturSensor("Aussen", 1, 1, 1, 10, 3)

dataFile = open(dataFileName, "+w")
dataFile.write("{tm:14s}|{Temp1:10s}|{Temp2:10s}\n".format(tm="Timestamp", Temp1=temp1.getName(), Temp2=temp2.getName()))
dataFile.close()


while not finished:
    writeToLog = False
    if (isOn):
        DAQC.clrDOUTbit(1, 0)
        isOn = False
    else:
        DAQC.setDOUTbit(1, 0)
        isOn = True

    logstr_2 = getTimestamp(preStr = "", postStr="", formatString="")

    tempStr = temp1.getValueIfOverToleranz(True)
    logstr_2 = logstr_2 + "|" + tempStr
    writeToLog = (temp1.hasTempratureChanged() or writeToLog)

    tempStr = temp2.getValueIfOverToleranz(True)
    logstr_2 = logstr_2 + "|" + tempStr
    writeToLog = (temp2.hasTempratureChanged() or writeToLog)


    if (writeToLog):
       dataFile = open(dataFileName, "a+")
       dataFile.write(logstr_2 + "\n")
       dataFile.close()
       print("\n" + logstr_2)
    else:
       print(".", end="", flush=True)


    # if (temp1.getCurrentValue() >= 27):
    #    RELAY.relayON(3,1)
    # else:
    #   RELAY.relayOFF(3,1)


    time.sleep(1)  # sleeps for 1s
