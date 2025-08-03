#!/usr/bin/python3

# ------------------------------------------------------------------
# Name  : 02_GPIO_In.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/01_GPIO_IN_OUT/02_GPIO_In.py
#
# Description: GPIO simple
#
# GPIO PIN Belegung:     http://www.peterliwiese.ch/img/GPIO_RPi.png
# GPIO Simple Schaltung: http://www.peterliwiese.ch/img/RPi_GPIO_LED_Switch_schema.png
#
# Autor: Walter Rothlin
#
# History:
# 05-Dec-2023   Dylan Egger       Initial Version
# 09-Dec-2023   Walter Rothlin    Integrated in Moodle course
# 03-Aug-2025   Walter Rothlin    Moved to seperate Repository
#
# ------------------------------------------------------------------

# import
import RPi.GPIO as GPIO

#gpio setup
GPIO.setmode(GPIO.BCM) # sagt welcher gpio modus gebraucht wird
GPIO.setwarnings(False)

GPIO.setup(2, GPIO.IN) # definiert gpio pin 2 als input

#loop
while True:
    print(GPIO.input(2)) # druckt den aktuellen Wert von pin 2 ins terminal