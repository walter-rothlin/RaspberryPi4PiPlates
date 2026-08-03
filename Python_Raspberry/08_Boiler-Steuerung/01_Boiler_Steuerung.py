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

BoilerON_PIN = 16


# gpio setup
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(BoilerON_PIN, GPIO.OUT)

base_time = 60
leistung = 0.5
on_time = base_time * leistung
off_time = base_time * (1 - leistung)


# loop
while True:
    print(f"Set GPIO {BoilerON_PIN} to High")
    GPIO.output(BoilerON_PIN, GPIO.HIGH)  # setzt pin RED_LED_PIN auf HIGH also 3.3v
    time.sleep(on_time)  # wartet 1s

    print(f"Set GPIO {BoilerON_PIN} to Low")
    GPIO.output(BoilerON_PIN, GPIO.LOW)  # setzt pin RED_LED_PIN auf LOW also 0v
    time.sleep(off_time)  # wartet 1s