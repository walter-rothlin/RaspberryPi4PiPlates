#!/usr/bin/python

# ------------------------------------------------------------------
# Source: https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_Raspberry/StartUpScripts/printIP.py
#
# Description: Shows IP adress on sense_hat
#
# API Doc: https://pythonhosted.org/sense-hat/api/
#
# Autor: Walter Rothlin
#
# History:
# 30-Nov-2024   Walter Rothlin      Initial Version
# ------------------------------------------------------------------
import os
import sys

from sense_hat import SenseHat


X = [255, 0, 0]   # Red
O = [70, 70, 0]    # Yellow

question_mark = [
O, O, O, X, X, O, O, O,
O, O, X, O, O, X, O, O,
O, O, O, O, O, X, O, O,
O, O, O, O, X, O, O, O,
O, O, O, X, O, O, O, O,
O, O, O, X, O, O, O, O,
O, O, O, O, O, O, O, O,
O, O, O, X, O, O, O, O
]


sense = SenseHat()

print("\n\n")
print("# Show IP Adresse (V1.0.0.1)")
print("# --------------------------")

print(f'Set-Up rotation of LED matrix')
sense.set_pixels(question_mark)
rotation = 0
finished = False
while not finished:
    event = sense.stick.wait_for_event(emptybuffer=True)
    print(f'Joystick: {event.direction} {event.action}   Rotation:{rotation}')
    if (event.direction == "middle"):
        finished = True
    elif event.action == 'pressed':
        rotation += 90
        rotation = rotation % 360
        sense.set_rotation(rotation)

name    = "!!!!"
vorname = "Waiting for Joystick Event"
displayMsg = "Hello " + name + " " + vorname

print(displayMsg)
sense.show_message(displayMsg, text_colour=(0, 125, 125))




finished = False
while not finished:
    sense.set_pixels(question_mark)

    event = sense.stick.wait_for_event(emptybuffer=True)
    print(f'Joystick: {event.direction} {event.action}')
    if (event.direction == "middle"):
        finished = True
    elif (event.direction == "left"):
        myHostname = os.popen('/bin/hostname').read().strip()
        print("  Hostname:" + myHostname + "::")
        sense.show_message(str(myHostname), text_colour=(125, 125, 0))

    ipArray = os.popen('/bin/hostname -I').read().strip().split(" ")
    for ip in ipArray:
        ipStr = str(ip).strip('\r\n')
        print("  IP:" + ipStr + "::")
        sense.show_message(str(ipStr), text_colour=(125, 125, 125))

    sense.clear()   # clear LED matrix

sense.show_message("Done & Closed!!!", text_colour=(0, 125, 125))
