#!/usr/bin/python3

# ------------------------------------------------------------------
# Name  : thermometer.py
# Source: https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_WaltisExamples/Code_06_Pi_Plate/thermometer.py
#
# Description: Thermometer
#
# http://pi-plates.com/daqc-users-guide
# Run with watch to get updating results e.g.
# watch thermometer.py
#
# Autor: Walter Rothlin
#
# History:
# 01-Dec-2023   Walter Rothlin      Initial Version
#
# ------------------------------------------------------------------
import piplates.DAQCplate as DAQC
print("Thermometer 1\tThermometer 2")

print(str(DAQC.getTEMP(2, 0, 'c'))+"°C\t"+str(DAQC.getTEMP(2, 1, 'c'))+"°C")
print(str(DAQC.getTEMP(2, 0, 'k'))+"°K\t"+str(DAQC.getTEMP(2, 1, 'k'))+"°K")
print(str(DAQC.getTEMP(2, 0, 'f'))+"°F\t"+str(DAQC.getTEMP(2, 1, 'f'))+"°F")
