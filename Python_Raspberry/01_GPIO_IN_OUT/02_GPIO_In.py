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
# 27-Jul-2026   Walter Rothlin    Changes for Levin Hofmann
# ------------------------------------------------------------------

# import
import RPi.GPIO as GPIO
import time

TASTER_PIN = 5

#gpio setup
GPIO.setmode(GPIO.BCM) # sagt welcher gpio modus gebraucht wird
GPIO.setwarnings(False)

GPIO.setup(TASTER_PIN, GPIO.IN) # definiert gpio TASTER_PIN als input

#loop
while True:
    pin_value = GPIO.input(TASTER_PIN)
    pin_status = 'off'
    if pin_value == 0:
        pin_status = 'on'
    print(f"Taster-Pin:{TASTER_PIN} --> {pin_value} {pin_status}") # druckt den aktuellen Wert von TASTER_PIN ins terminal
    time.sleep(0.1)