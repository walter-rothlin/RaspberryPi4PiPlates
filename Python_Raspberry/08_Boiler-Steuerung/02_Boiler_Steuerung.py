#!/usr/bin/python

# ------------------------------------------------------------------
# Name  : 02_Boiler_Steuerung.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/08_Boiler_Steuerung/02_Boiler_Steuerung.py
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
import threading
import time
import RPi.GPIO as GPIO


class BoilerController:
    def __init__(self, gpio_pin, base_time=60):
        self.gpio_pin = gpio_pin
        self.base_time = base_time
        self.leistung = 0.0          # 0 ... 1
        self.running = False

        GPIO.setup(self.gpio_pin, GPIO.OUT, initial=GPIO.LOW)

        self.thread = threading.Thread(target=self._worker, daemon=True)

    def start(self):
        if not self.running:
            self.running = True
            self.thread.start()

    def stop(self):
        self.running = False
        self.thread.join()

        GPIO.output(self.gpio_pin, GPIO.LOW)

    def set_leistung(self, leistung):
        """Leistung zwischen 0.0 und 1.0"""
        self.leistung = max(0.0, min(1.0, leistung))

    def _worker(self):
        while self.running:

            on_time = self.base_time * self.leistung
            off_time = self.base_time - on_time

            if on_time > 0:
                GPIO.output(self.gpio_pin, GPIO.HIGH)
                time.sleep(on_time)

            if off_time > 0:
                GPIO.output(self.gpio_pin, GPIO.LOW)
                time.sleep(off_time)


# -------------------------------------

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

boiler = BoilerController(gpio_pin=16, base_time=60)
boiler.start()

try:

    boiler.set_leistung(0.2)
    time.sleep(120)

    boiler.set_leistung(0.5)
    time.sleep(120)

    boiler.set_leistung(0.8)
    time.sleep(120)

finally:
    boiler.stop()
    GPIO.cleanup()