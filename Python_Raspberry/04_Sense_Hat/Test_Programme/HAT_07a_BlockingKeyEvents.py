#!/usr/bin/python3

# ------------------------------------------------------------------
# Name: HAT_07a_BlockingKeyEvents.py
#
# Description: Der Punkt (LED) wird auf der Matrix in Richtung des Joy-Sticks bewegt (synchron)
#
# Autor: Walter Rothlin
#
# History:  
# 02-Jul-2019	Walter Rothlin		Initial Version
# ------------------------------------------------------------------

from   sense_hat import *
from   time      import sleep


sense = SenseHat()
sense.clear()
yCount = 4
xCount = 4
while (True):
    print("Wait for Event....")
    event = sense.stick.wait_for_event(emptybuffer=True)
    # print("The joystick was {} {}".format(event.action, event.direction))
    if ((event.direction == "up") and (event.action == "pressed")):
        yCount = yCount - 1
        if (yCount < 0):
            yCount = 0
    if ((event.direction == "down") and (event.action != "released")):
        yCount = yCount + 1
        if (yCount > 7):
            yCount = 7
    if ((event.direction == "left") and (event.action != "released")):
        xCount = xCount - 1
        if (xCount < 0):
            xCount = 0
    if ((event.direction == "right") and (event.action != "released")):
        xCount = xCount + 1
        if (xCount > 7):
            xCount = 7
    if ((event.direction == "middle") and (event.action != "released")):
        yCount = 4
        xCount = 4

    sense.clear()
    sense.set_pixel(xCount,yCount,255,0,0)
