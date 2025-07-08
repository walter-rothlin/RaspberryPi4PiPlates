#!/usr/bin/python3

# ------------------------------------------------------------------
# Name: HAT_07a_Simple_BlockingKeyEvents.py
#
# Description: Zeigt auf standard output die Joysticks Event an
#
# Autor: Walter Rothlin
#
# History:  
# 02-Jul-2019	Walter Rothlin		Initial Version
# ------------------------------------------------------------------

from sense_hat import *


sense = SenseHat()
while (True):
    event = sense.stick.wait_for_event(emptybuffer=True)
    print("The joystick was {} {}".format(event.action, event.direction))
