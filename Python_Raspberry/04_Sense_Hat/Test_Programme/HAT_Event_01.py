#!/usr/bin/python3


# ------------------------------------------------------------------
# Name: HAT_Event_01.py
#
# Description: Zeigt auf standard output die Joysticks Event an
#
# Autor: Walter Rothlin
#
# History:
# 13-Apr-2021	Walter Rothlin		Initial Version
# ------------------------------------------------------------------

from sense_hat import *

sense = SenseHat()
while (True):
    event = sense.stick.wait_for_event(emptybuffer=True)
    print("The joystick was {action:10s} {key:10s}".format(action=event.action, key=event.direction))

