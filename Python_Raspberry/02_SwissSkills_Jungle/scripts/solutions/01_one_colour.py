#!/usr/bin/python3

# ------------------------------------------------------------------
# Name  : 01_one_colour.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/02_SwissSkills_Jungle/scripts/solutions/01_one_colour.py
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

import time
from LEDController import LEDController

led = LEDController()

try:
    
    led.setRed(255)
    led.setGreen(0)
    led.setBlue(0)
    
    time.sleep(5)

except KeyboardInterrupt:
    pass
except: raise
finally:
    led.clear()

