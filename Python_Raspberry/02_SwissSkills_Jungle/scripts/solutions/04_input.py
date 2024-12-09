#!/usr/bin/python3

# ------------------------------------------------------------------
# Name  : 04_input.py
# Source: https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_Raspberry/02_SwissSkills_Jungle/scripts/solutions/04_input.py
#
# Description: RGB LED-Strips
#
#
# Autor: Walter Rothlin
#
# History:
# 01-Jan-2018   Benjamin Raison   Initial Version for CS @ Swiss skills
# 09-Dec-2023   Walter Rothlin    Integrated in Moodle course
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

    if char == '1' and red >= step:
        red -= step 
    if char == '2' and green >= step:
        green -= step
    if char == '3' and blue >= step:
        blue -= step
    if char == '5':
        red = 0
        green = 0
        blue = 0
    if char == '7' and red + step <= 255:
        red += step
    if char == '8' and green + step <= 255:
        green += step
    if char == '9' and blue + step <= 255:
        blue += step

    led.setRed(red)
    led.setGreen(green)
    led.setBlue(blue)

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
