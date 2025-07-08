#!/usr/bin/python3
# ------------------------------------------------------------------
# Name: HAT_Event_03_Snake.py
#
# Description: Mit dem Joy-Stick kann ein Punkt auf allen Achsen
#              bewegt werden.
#
# Autor: Walter Rothlin
#
# History:
# 13-Apr-2021	Walter Rothlin		Initial Version
# ------------------------------------------------------------------

from sense_hat import SenseHat, ACTION_PRESSED, ACTION_HELD, ACTION_RELEASED
from signal import pause

x = 3
y = 3
sense = SenseHat()

# function definitions
# --------------------
def clamp(value, min_value=0, max_value=7):
    return min(max_value, max(min_value, value))

def pushed_up(event):
    global y
    if event.action != ACTION_RELEASED:
        y = clamp(y - 1)
def pushed_down(event):
    global y
    if event.action != ACTION_RELEASED:
        y = clamp(y + 1)

def pushed_left(event):
    global x
    if event.action != ACTION_RELEASED:
        x = clamp(x - 1)

def pushed_right(event):
    global x
    if event.action != ACTION_RELEASED:
        x = clamp(x + 1)

def refresh():
    sense.clear()
    sense.set_pixel(x, y, 255, 255, 255)
# register event-handlers
# -----------------------
sense.stick.direction_up = pushed_up
sense.stick.direction_down = pushed_down
sense.stick.direction_left = pushed_left
sense.stick.direction_right = pushed_right
sense.stick.direction_any = refresh
refresh()
pause()