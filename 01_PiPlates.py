#!/usr/bin/python

# ------------------------------------------------------------------
# Source: https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_Raspberry/03_PiPlates/01_PiPlates.py
#
# Description: Test Script for PiPlates
#
# https://pi-plates.com/daqc-users-guide/
# https://pi-plates.com/downloads/DAQCplate%20Quick%20Reference%20Guide.pdf
#
# http://pi-plates.com/relayplate-users-guide
# https://pi-plates.com/downloads/RELAYplateQuickReferenceGuide.pdf
#
# Autor: Walter Rothlin
#
# History:
# 30-Nov-2024   Walter Rothlin      Initial Version
# ------------------------------------------------------------------
import piplates.DAQCplate                       as DAQC
import piplates.RELAYplate                      as Relay
import time

PLATE_ADDRESS = 0

print(f"Testing Plate on address {PLATE_ADDRESS}")
# Relay control
for i in range(1,8):
    Relay.relayON(PLATE_ADDRESS,i)
    print(f"Relay ON: {PLATE_ADDRESS}, {i}")
    time.sleep(1)

for i in range(1,8):
    Relay.relayOFF(PLATE_ADDRESS,i)
    print(f"Relay OFF: {PLATE_ADDRESS}, {i}")
    time.sleep(1)


print("Done")