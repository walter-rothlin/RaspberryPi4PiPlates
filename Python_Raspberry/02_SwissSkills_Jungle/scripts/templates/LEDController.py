#!/usr/bin/python3

# ------------------------------------------------------------------
# Name  : LEDController.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/02_SwissSkills_Jungle/scripts/templates/LEDController.py
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
import pigpio
import time

class LEDController:

    PIN_RED = 24
    PIN_GREEN = 22
    PIN_BLUE = 17

    pi = pigpio.pi()

    def set(self, pin, value):
        self.pi.set_PWM_dutycycle(pin, value)

    def clear(self):
        self.set(self.PIN_RED, 0)
        self.set(self.PIN_BLUE, 0)
        self.set(self.PIN_GREEN, 0)

    def setGreen(self, value):
        self.set(self.PIN_GREEN, value)

    def setBlue(self, value):
        self.set(self.PIN_BLUE, value)

    def setRed(self, value):
        self.set(self.PIN_RED, value)

    def clearRed(self):
        self.set(self.PIN_RED, 0)

    def clearBlue(self):
        self.set(self.PIN_BLUE, 0)

    def clearGreen(self):
        self.set(self.PIN_GREEN, 0)

