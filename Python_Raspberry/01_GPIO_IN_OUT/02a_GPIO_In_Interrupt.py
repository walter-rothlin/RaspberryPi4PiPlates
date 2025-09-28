#!/usr/bin/python3

# ------------------------------------------------------------------
# Name  : 02a_GPIO_In_Interrupt.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/01_GPIO_IN_OUT/02a_GPIO_In_Interrupt.py
#
# Description: GPIO simple
#
# GPIO PIN Belegung:     http://www.peterliwiese.ch/img/GPIO_RPi.png
# GPIO Simple Schaltung: http://www.peterliwiese.ch/img/RPi_GPIO_LED_Switch_schema.png
#
# Autor: Walter Rothlin
#
# History:
# 28-Sep-2025   Walter Rothlin    Initial Version
#
# ------------------------------------------------------------------
import RPi.GPIO as GPIO
import time

# GPIO Setup
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

TASTER_PIN = 5
LED_PIN = 6

# Taster als Eingang mit Pull-Up
GPIO.setup(TASTER_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)

# LED als Ausgang
GPIO.setup(LED_PIN, GPIO.OUT)
GPIO.output(LED_PIN, GPIO.LOW)

# Callback-Funktion, die beim Tastendruck ausgelöst wird
def taster_callback(channel):
    print("Taster gedrückt!")
    # LED kurz ein- und wieder ausschalten
    GPIO.output(LED_PIN, GPIO.HIGH)
    time.sleep(0.5)
    GPIO.output(LED_PIN, GPIO.LOW)

# Interrupt: steige von HIGH zu LOW (Taster gedrückt)
GPIO.add_event_detect(TASTER_PIN, GPIO.FALLING, callback=taster_callback, bouncetime=200)

try:
    print("Programm läuft. Drücke den Taster...")
    while True:
        time.sleep(1)  # Hauptloop macht nichts, alles läuft über Interrupt

except KeyboardInterrupt:
    GPIO.cleanup()
