#!/usr/bin/python3

# ------------------------------------------------------------------
# Name  : 02_colour_sequence.py
# Source: https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_Raspberry/02_SwissSkills_Jungle/scripts/templates/02_colour_sequence.py
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
    time.sleep(1)

except KeyboardInterrupt:
    pass
except: raise
finally:
    led.clear()
