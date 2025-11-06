#! /usr/bin/env python3
# ------------------------------------------------------------------
# Name  : Schrittmotorensteuerung_02.py
# ------------------------------------------------------------------
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/07_Schrittmotor/Schrittmotorensteuerung_02.py
#
# Description: Schrittmotoren ansteuern
#
#
# Autor: Walter Rothlin
#
# History:
# 06-Sep-2025   Walter Rothlin      Initial Version
# ------------------------------------------------------------------
import RPi.GPIO as GPIO
import time

# Pins am Raspberry Pi (BCM-Nummern)
IN1 = 18
IN2 = 23
IN3 = 24
IN4 = 25

pins = [IN1, IN2, IN3, IN4]

# Halbschritt-Sequenz
seq = [
    [1,0,0,0],
    [1,1,0,0],
    [0,1,0,0],
    [0,1,1,0],
    [0,0,1,0],
    [0,0,1,1],
    [0,0,0,1],
    [1,0,0,1]
]

# Setup
GPIO.setmode(GPIO.BCM)
for pin in pins:
    GPIO.setup(pin, GPIO.OUT)
    GPIO.output(pin, 0)

def step_motor(delay, steps):
    for i in range(steps):
        for halfstep in range(8):
            for pin in range(4):
                GPIO.output(pins[pin], seq[halfstep][pin])
            time.sleep(delay)

try:
    while True:
        # Geschwindigkeit: delay zwischen den Halbschritten
        step_motor(0.002, 512)   # ca. 1 Umdrehung (512 Halbschritte)
        time.sleep(1)
        step_motor(0.002, -512)  # zurückdrehen
        time.sleep(1)

except KeyboardInterrupt:
    print("Abbruch durch Benutzer")

finally:
    GPIO.cleanup()
