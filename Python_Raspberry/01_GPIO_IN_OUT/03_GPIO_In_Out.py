#!/usr/bin/python3

# ------------------------------------------------------------------
# Name  : 03_GPIO_In_Out.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/01_GPIO_IN_OUT/03_GPIO_In_Out.py
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
import time
import RPi.GPIO as GPIO

GREEN_LED_PIN = 13
TASTER_PIN = 5

#gpio setup
GPIO.setmode(GPIO.BCM)   # sagt welcher gpio modus gebraucht wird
GPIO.setwarnings(False)

GPIO.setup(TASTER_PIN, GPIO.IN)      # definiert gpio TASTER_PIN als input
GPIO.setup(GREEN_LED_PIN, GPIO.OUT)  # definiert gpio GREEN_LED_PIN als output

while True:
    if GPIO.input(TASTER_PIN) == 0:
        GPIO.output(GREEN_LED_PIN, GPIO.LOW)   # setzt GREEN_LED_PIN auf HIGH also 3.3v
        time.sleep(1)              # wartet 1s
        GPIO.output(GREEN_LED_PIN, GPIO.HIGH)  # setzt GREEN_LED_PIN auf LOW also 0v
        time.sleep(1)              # wartet 1s
