#!/usr/bin/env python

# ------------------------------------------------------------------
# Name  : 01_Relais_schalten.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/01_GPIO_IN_OUT/01_Relais_schalten.py
#
# Description: Schaltet ein Relais, welches direkt an einem GPIO PIN angängt ist.
#
# Autor: Walter Rothlin
#
# History:  
# 03-Aug-2025   Walter Rothlin      Initial Version
# ------------------------------------------------------------------
import RPi.GPIO as GPIO
import time

'''
Varianten der GPIO PIN Definition
---------------------------------
GPIO.setmode(GPIO.BOARD)  # Pysische Board PIN Nr
GPIO.setup(11, GPIO.OUT)  # Nutzt physischen Pin 11 => GPIO17

GPIO.setmode(GPIO.BCM)    # BCM Broadcom SOC-Nummerierung
GPIO.setup(17, GPIO.OUT)  # Nutzt GPIO17 => physisch Pin 11
'''



GPIO.setmode(GPIO.BCM)          # Verwende das physische Pin-Layout (BOARD) oder BCM (GPIO-Nummer)
RELAY_PIN = 17                  # GPIO-Nummer, an dem das Relais angeschlossen ist
GPIO.setup(RELAY_PIN, GPIO.OUT) # GPIO vorbereiten

# Relais einschalten (je nach Modul LOW oder HIGH – hier gehen wir von LOW-Aktiv aus)
print("Relais EIN")
GPIO.output(RELAY_PIN, GPIO.LOW)
time.sleep(5)

# Relais ausschalten
print("Relais AUS")
GPIO.output(RELAY_PIN, GPIO.HIGH)
time.sleep(1)

# GPIO aufräumen
GPIO.cleanup()
