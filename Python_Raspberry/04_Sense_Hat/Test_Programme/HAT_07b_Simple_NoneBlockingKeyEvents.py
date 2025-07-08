#!/usr/bin/python3

# ------------------------------------------------------------------
# Name: HAT_07b_Simple_NoneBlockingKeyEvents.py
#
# Description: Zeigt auf standard output die Joysticks Event an (asynchron)
#
# Autor: Walter Rothlin
#
# History:  
# 02-Jul-2019	Walter Rothlin		Initial Version
# ------------------------------------------------------------------

from sense_hat import *
from time import sleep

sense = SenseHat()
while (True):
    for event in sense.stick.get_events():
        print("\nThe joystick was {} {}".format(event.action, event.direction))
    sleep(1)
    print(".",end = "",flush = True)


