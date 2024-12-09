#!/usr/bin/python3

# ------------------------------------------------------------------
# Name  : 03_gradient.py
# Source: https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_Raspberry/02_SwissSkills_Jungle/scripts/solutions/03_gradient.py
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
import time
from LEDController import LEDController

led = LEDController()

try:
    led.setRed(255)
    for i in range(255):
        led.setRed(255 - i)
        led.setBlue(i)
        time.sleep(0.02)

    for i in range(255):
        led.setBlue(255 - i)
        led.setGreen(i)
        time.sleep(0.02)

    for i in range(255):
        led.setGreen(255 - i)
        led.setRed(i)
        time.sleep(0.02)

    time.sleep(0.5)

except KeyboardInterrupt:
    pass
except: raise
finally:
    led.clear()

