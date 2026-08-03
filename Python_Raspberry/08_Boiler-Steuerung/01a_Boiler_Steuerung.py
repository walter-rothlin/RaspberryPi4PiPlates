#!/usr/bin/python

# ------------------------------------------------------------------
# Name  : 01a_Boiler_Steuerung.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/08_Boiler_Steuerung/01a_Boiler_Steuerung.py
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

BOILER_ON_PIN = 16

# GPIO initialisieren
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(BOILER_ON_PIN, GPIO.OUT, initial=GPIO.LOW)

BASE_TIME = 60.0      # Sekunden
leistung = 0.5        # 0.0 bis 1.0

try:
    while True:
        on_time = BASE_TIME * leistung
        off_time = BASE_TIME - on_time

        if on_time > 0:
            print(f"GPIO {BOILER_ON_PIN} EIN ({on_time:.1f}s)")
            GPIO.output(BOILER_ON_PIN, GPIO.HIGH)
            time.sleep(on_time)

        if off_time > 0:
            print(f"GPIO {BOILER_ON_PIN} AUS ({off_time:.1f}s)")
            GPIO.output(BOILER_ON_PIN, GPIO.LOW)
            time.sleep(off_time)

except KeyboardInterrupt:
    print("Programm beendet.")

finally:
    GPIO.output(BOILER_ON_PIN, GPIO.LOW)
    GPIO.cleanup()