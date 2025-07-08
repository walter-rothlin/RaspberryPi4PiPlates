#!/usr/bin/python3

# ------------------------------------------------------------------
# Name: HAT_07b_NoneBlockingKeyEvents.py
#
# Description: Bewegt den Punkt auf der Matrix. Mit dem Joy-Stick kann 
# ich die Richtung vorgeben. (asynchron)
#
# Autor: Walter Rothlin
#
# History:  
# 02-Jul-2019	Walter Rothlin		Initial Version
# ------------------------------------------------------------------

from sense_hat import *
from time      import sleep


sense = SenseHat()
x = 0
y = 0
direction = "right"
while (True):
    for event in sense.stick.get_events():
       direction = event.direction
    if (direction == "left"):
        x = x - 1
        if (x < 0):
            x = 0
    if (direction == "right"):
        x = x + 1
        if (x > 7):
            x = 7
    if (direction == "up"):
        y = y - 1
        if (y < 0):
            y = 0
    if (direction == "down"):
        y = y + 1
        if (y > 7):
            y = 7

    sense.clear()
    sense.set_pixel(x,y,255,0,0)
    sleep(0.3)





#    print("Check for Event....")
#    for event in sense.stick.get_events():
#        print("The joystick was {} {}".format(event.action, event.direction))
