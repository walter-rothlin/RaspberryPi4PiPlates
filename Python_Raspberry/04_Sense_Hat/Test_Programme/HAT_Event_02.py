#!/usr/bin/python3

# ------------------------------------------------------------------
# Name: HAT_Event_02.py
#
# Description: Zeigt auf standard output die Joysticks Event an (asynchron)
#
# Autor: Walter Rothlin
#
# History:
# 13-Apr-2021	Walter Rothlin		Initial Version
# ------------------------------------------------------------------
from sense_hat import *
from time import sleep


sense = SenseHat()
doLoop = True
while (doLoop):
	for event in sense.stick.get_events():
		print("The joystick was {action:10s} {key:10s}".format(action=event.action, key=event.direction))
		if (event.action == "pressed") and (event.direction == "middle"):
			doLoop = False
	sleep(1)
	print("Hallo")
print("Beendet!!!")
