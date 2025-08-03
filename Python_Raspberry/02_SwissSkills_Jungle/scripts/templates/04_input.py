#!/usr/bin/python3

# ------------------------------------------------------------------
# Name  : 04_input.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/02_SwissSkills_Jungle/scripts/templates/04_input.py
#
# Description: RGB LED-Strips
#
#
# Autor: Walter Rothlin
#
# History:
# 01-Jan-2018   Benjamin Raison   Initial Version for CS @ Swiss skills
# 09-Dec-2023   Walter Rothlin    Integrated in Moodle course
# 03-Aug-2025   Walter Rothlin    Moved to seperate Repository
#
# ------------------------------------------------------------------
import time, curses
from LEDController import LEDController

led = LEDController()

red = 0
green = 0
blue = 0

step = 15

def onInput(char):
    global red
    global green
    global blue



############################################


try:
    win = curses.initscr()
    curses.noecho()

    while True:
        char = chr(win.getch())
        if char in '1235789': onInput(char)
        # Empty spaces are to overwrite larger numbers
        win.addstr(0,0, 'R: ' + str(red) + '   ')
        win.addstr(1,0, 'G: ' + str(green) + '   ')
        win.addstr(2,0, 'B: ' + str(blue) + '   ')
        win.addstr(3,0, '') # Cursor on new line
        win.refresh()
        time.sleep(0.02)


except KeyboardInterrupt:
    pass
except: raise
finally:
    led.clear()
    curses.endwin()
