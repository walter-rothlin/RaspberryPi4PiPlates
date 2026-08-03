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
#!/usr/bin/env python3

import threading
import time

from flask import Flask, jsonify, request

import RPi.GPIO as GPIO

'''
REST-Aufrufe
============

Thread starten:
curl -X POST http://raspberrypi:5000/start

Leistung auf 35 % setzen:
curl -X POST \
     -H "Content-Type: application/json" \
     -d '{"power":0.35}' \
     http://raspberrypi:5000/power

Zyklus auf 5 Minuten ändern:
curl -X POST \
     -H "Content-Type: application/json" \
     -d '{"cycle":300}' \
     http://raspberrypi:5000/cycle

Status:     
curl http://raspberrypi:5000/status

Thread stoppen:
curl -X POST http://raspberrypi:5000/stop
'''

# --------------------------------------------------------
# Boiler Controller
# --------------------------------------------------------

class BoilerController:

    def __init__(self, gpio_pin, cycle_time=60):

        self.gpio_pin = gpio_pin
        self.cycle_time = cycle_time
        self.power = 0.0

        self.running = False

        self.lock = threading.Lock()

        self.stop_event = threading.Event()
        self.update_event = threading.Event()

        self.thread = None

        GPIO.setup(self.gpio_pin, GPIO.OUT, initial=GPIO.LOW)

    # ----------------------------------------------------

    def start(self):

        if self.running:
            return

        self.running = True

        self.stop_event.clear()
        self.update_event.clear()

        self.thread = threading.Thread(
            target=self._worker,
            daemon=True)

        self.thread.start()

    # ----------------------------------------------------

    def stop(self):

        if not self.running:
            return

        self.stop_event.set()
        self.thread.join()

        GPIO.output(self.gpio_pin, GPIO.LOW)

        self.running = False

    # ----------------------------------------------------

    def set_power(self, power):

        power = max(0.0, min(1.0, float(power)))

        with self.lock:
            self.power = power

        self.update_event.set()

    # ----------------------------------------------------

    def set_cycle_time(self, cycle_time):

        with self.lock:
            self.cycle_time = float(cycle_time)

        self.update_event.set()

    # ----------------------------------------------------

    def get_status(self):

        with self.lock:

            return {
                "running": self.running,
                "power": self.power,
                "cycle_time": self.cycle_time,
                "gpio": GPIO.input(self.gpio_pin)
            }

    # ----------------------------------------------------

    def _wait(self, seconds):

        start = time.monotonic()

        while True:

            remaining = seconds - (time.monotonic() - start)

            if remaining <= 0:
                return "timeout"

            if self.stop_event.wait(min(remaining, 0.2)):
                return "stop"

            if self.update_event.is_set():
                self.update_event.clear()
                return "update"

    # ----------------------------------------------------

    def _worker(self):

        print("Worker gestartet")

        while not self.stop_event.is_set():

            with self.lock:
                power = self.power
                cycle = self.cycle_time

            on_time = cycle * power
            off_time = cycle - on_time

            # ---------- EIN -----------------

            if on_time > 0:

                GPIO.output(self.gpio_pin, GPIO.HIGH)

                result = self._wait(on_time)

                if result == "stop":
                    break

                if result == "update":
                    continue

            # ---------- AUS -----------------

            if off_time > 0:

                GPIO.output(self.gpio_pin, GPIO.LOW)

                result = self._wait(off_time)

                if result == "stop":
                    break

                if result == "update":
                    continue

        GPIO.output(self.gpio_pin, GPIO.LOW)

        print("Worker beendet")


# --------------------------------------------------------
# Flask
# --------------------------------------------------------

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

controller = BoilerController(
    gpio_pin=16,
    cycle_time=60)

app = Flask(__name__)


@app.route("/status")
def status():

    return jsonify(controller.get_status())


@app.route("/start", methods=["POST"])
def start():

    controller.start()

    return jsonify(
        success=True,
        status=controller.get_status())


@app.route("/stop", methods=["POST"])
def stop():

    controller.stop()

    return jsonify(
        success=True,
        status=controller.get_status())


@app.route("/power", methods=["POST"])
def power():

    data = request.get_json()

    controller.set_power(data["power"])

    return jsonify(
        success=True,
        status=controller.get_status())


@app.route("/cycle", methods=["POST"])
def cycle():

    data = request.get_json()

    controller.set_cycle_time(data["cycle"])

    return jsonify(
        success=True,
        status=controller.get_status())


# --------------------------------------------------------

if __name__ == "__main__":

    try:
        app.run(
            host="0.0.0.0",
            port=5000)

    finally:

        controller.stop()
        GPIO.cleanup()

