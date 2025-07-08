#!/usr/bin/python3

# ------------------------------------------------------------------
# Name  : Test_DAQC_LedLine.py
# Source: https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_WaltisExamples/Code_06_Pi_Plates/Test_DAQC_LedLine.py
#
# Description: Test with PiPlate: DAQC-Plate
#
# Notepad++ Spaces instead of TAB: Settings --> Preferences... -->
#
# http://pi-plates.com/daqc-users-guide/
#
### To install the pi-plates module use:
##    Enable SPI unter einstellungen --> Interfaces
##    sudo pip3 install pi-plates
#
# Autor: Walter Rothlin
#
# History:
# 01-Dec-2023   Walter Rothlin      Initial Version
# 11-Dec-2023   Walter Rothlin      Card Adress set to 0 (all jumpers in)
#
# ------------------------------------------------------------------

import os
import sys
import time
import datetime
import piplates.DAQCplate as DAQC
from   Class_DAQC_LedLine import *

print("Test CLASS_DAQC_LedLine (Adr=0)...")
ledLine_1 = DAQC_LedLine("Test-Balken", 0)
ledLine_1.drawBalken(3)
time.sleep(1)
ledLine_1.incBalken()
time.sleep(1)
ledLine_1.incBalken()
time.sleep(1)
ledLine_1.incBalken()
time.sleep(1)
ledLine_1.incBalken()
time.sleep(5)
ledLine_1.decBalken()
time.sleep(1)
ledLine_1.decBalken()
time.sleep(1)
ledLine_1.decBalken()
time.sleep(1)
ledLine_1.decBalken()
time.sleep(1)
ledLine_1.decBalken()
time.sleep(1)
ledLine_1.decBalken()
time.sleep(1)
ledLine_1.decBalken()
time.sleep(1)
ledLine_1.decBalken()
time.sleep(1)
ledLine_1.decBalken()
time.sleep(1)
ledLine_1.decBalken()
time.sleep(1)
ledLine_1.decBalken()
time.sleep(1)
ledLine_1.decBalken()
time.sleep(1)
ledLine_1.incBalken()
time.sleep(1)
ledLine_1.incBalken()
time.sleep(1)
ledLine_1.incBalken()
time.sleep(1)
ledLine_1.incBalken()
time.sleep(1)
ledLine_1.incBalken()

ledLine_1.clearAll()
time.sleep(1)
ledLine_1.setLED(0)
ledLine_1.setLED(6)
time.sleep(1)
ledLine_1.unsetLED(0)
ledLine_1.unsetLED(6)


print("Wait 5s")
time.sleep(5)
print("Test completed")
