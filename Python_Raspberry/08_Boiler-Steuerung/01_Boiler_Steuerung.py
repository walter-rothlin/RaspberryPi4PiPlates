#!/usr/bin/python

# ------------------------------------------------------------------
# Name  : 01_Boiler_Steuerung.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/08_Boiler_Steuerung/01_Boiler_Steuerung.py
#
# Description: GPIO simple
#
# GPIO PIN Belegung:     http://www.peterliwiese.ch/img/GPIO_RPi.png
# GPIO Simple Schaltung: http://www.peterliwiese.ch/img/RPi_GPIO_LED_Switch_schema.png
#
# Autor: Walter Rothlin
#
# History:
# 01-Aug_2026   Walter Rothlin    Initial Version
#
# ------------------------------------------------------------------

import time
import RPi.GPIO as GPIO

RED_LED_PIN = 6
GREEN_LED_PIN = 13
TASTER_PIN = 5

# gpio setup
GPIO.setmode(GPIO.BCM)  # sagt welcher gpio modus gebraucht wird
GPIO.setwarnings(False)

GPIO.setup(RED_LED_PIN, GPIO.OUT)  # definiert gpio pin RED_LED_PIN als output
GPIO.setup(GREEN_LED_PIN, GPIO.OUT)  # definiert gpio pin GREEN_LED_PIN als output

# loop
while True:
    print(f"Set GPIO {RED_LED_PIN} to High")
    GPIO.output(RED_LED_PIN, GPIO.HIGH)  # setzt pin RED_LED_PIN auf HIGH also 3.3v
    # GPIO.output(GREEN_LED_PIN, GPIO.LOW)  # setzt pin GREEN_LED_PIN auf LOW also 0v
    time.sleep(1)  # wartet 1s

    print(f"Set GPIO {RED_LED_PIN} to Low")
    GPIO.output(RED_LED_PIN, GPIO.LOW)  # setzt pin RED_LED_PIN auf LOW also 0v
    # GPIO.output(GREEN_LED_PIN, GPIO.HIGH) # setzt pin GREEN_LED_PIN auf HIGH also 3.3v

    time.sleep(1)  # wartet 1s