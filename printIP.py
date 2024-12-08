#!/usr/bin/python

# ------------------------------------------------------------------
# Name: printIP.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/refs/heads/main/printIP.py
# 
# Description: Zeigt die IP-Adresse auf der Sense-Hat LED Matrix
#
# API HAT: https://pythonhosted.org/sense-hat/api/
#
# Autor: Walter Rothlin
#
# History:
# 01-Dec-2024   Walter Rothlin      Added header to initial version
# ------------------------------------------------------------------
import os
import sys

from sense_hat import SenseHat


sense = SenseHat()


print("\n\n")
print("# Show IP Adresse (V1.0.0.1)")
print("# --------------------------")
sense.show_message('Pls wait....', text_colour=(0, 125, 125))


X = [255, 0, 0]    # Red
O = [70, 70, 0]    # Yellow

arrow_mark = [
O, O, O, X, O, O, O, O,
O, O, X, X, X, O, O, O,
O, X, X, X, X, X, O, O,
O, O, O, X, O, O, O, O,
O, O, O, X, O, O, O, O,
O, O, O, X, O, O, O, O,
O, O, O, X, O, O, O, O,
O, O, O, X, O, O, O, O
]

rotation = 0
finished = False
while not finished:
    sense.set_pixels(arrow_mark)
    event = sense.stick.wait_for_event(emptybuffer=True)
    print(f'Joystick:{event.direction} {event.action}    Rotation:{rotation}')
    if event.action == 'pressed':
        if event.direction == "middle":
            finished = True
        else:
            rotation += 90
            rotation = rotation % 360
            sense.set_rotation(rotation)



X = [255, 0, 0]    # Red
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

finished = False
while not finished:
    sense.set_pixels(question_mark)
    
    event = sense.stick.wait_for_event(emptybuffer=True)
    print(f'Joystick:{event.direction} {event.action}')
    if event.action == 'pressed':
        if event.direction == 'middle':
            finished = True
        elif event.direction == 'left':
            myHostname = os.popen('/bin/hostname').read().strip()
            print(f'  Hostname:{myHostname}::')
            sense.show_message(str(myHostname), text_colour=(125, 125, 0))

        ipArray = os.popen('/bin/hostname -I').read().strip().split(" ")
        for ip in ipArray:
            ipStr = str(ip).strip('\r\n')
            print(f'  IP:{ipStr}:: {len(ipStr)}')
            if len(ipStr) < 20:
                sense.show_message(str(ipStr), text_colour=(125, 125, 125))

    sense.clear()   # clear LED matrix

sense.show_message("Done & Closed!!!", text_colour=(0, 125, 125))