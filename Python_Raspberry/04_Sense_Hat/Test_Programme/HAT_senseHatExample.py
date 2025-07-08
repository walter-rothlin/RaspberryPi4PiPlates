#!/usr/bin/python3

from __future__ import print_function
from sense_hat import SenseHat
import os
import sys
import time


sense = SenseHat()


print("\n\n")
print("# HAT Example Joystick + LED-Matrix ")
print("# --------------------------------- ")
name    = "BZU:"
vorname = ""
displayMsg = "Hello " + name + " " + vorname
print(displayMsg)

sense.show_message(displayMsg, text_colour=(0,125,125))



X = [255, 0, 0]   # Red
O = [70,70, 0]    # Yellow

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

question_gt = [
O, O, O, X, O, O, O, O,
O, O, O, O, X, O, O, O,
O, O, O, O, O, X, O, O,
O, O, O, O, O, O, X, O,
O, O, O, O, O, X, O, O,
O, O, O, O, X, O, O, O,
O, O, O, X, O, O, O, O,
O, O, O, O, O, O, O, O
]

finished = False
while not finished:
    sense.set_pixels(question_mark)
    event = sense.stick.wait_for_event(emptybuffer=True)   # wait for events, but delete all events happen before this call
    sense.clear()   # clear LED matrix
    print("The joystick was {} {}".format(event.action, event.direction))
    if (event.direction == "right"):
        sense.set_pixels(question_gt)
        finished = True
    elif (event.direction == "up"):
        # examples using (x, y, r, g, b)
        sense.set_pixel(4, 0, 255, 0, 0)
    elif (event.direction == "left"):
        # examples using (x, y, r, g, b)
        sense.set_pixel(0, 4, 255, 255, 0)
    elif (event.direction == "down"):
        # examples using (x, y, r, g, b)
        sense.set_pixel(4, 7, 0, 255, 0)
    elif (event.direction == "middle"):
        # examples using (x, y, r, g, b)
        sense.set_pixel(4, 4, 0, 0, 255)
    time.sleep(1)  # sleeps for 1s

sense.show_message("Closed!!!", text_colour=(0,125,125))