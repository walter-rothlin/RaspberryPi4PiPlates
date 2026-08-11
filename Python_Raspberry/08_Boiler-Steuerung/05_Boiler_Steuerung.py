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

# ------------------------------------------------------------------
#
# Name  : 02_Boiler_Steuerung.py
#
# Description:
#     Boiler Steuerung mit Raspberry Pi GPIO
#     Zeitproportionale Leistungssteuerung
#     Flask REST API + Jinja Weboberfläche
#
# GPIO:
#     GPIO 16 -> SSR
#
# Beispiele:
#
# Thread starten:
#     curl -X POST http://raspberrypi:5000/start
#
# Leistung auf 35 % setzen:
#     curl -X POST \
#       -H "Content-Type: application/json" \
#       -d '{"power":0.35}' \
#       http://raspberrypi:5000/power
#
# Zyklus auf 5 Minuten ändern:
#     curl -X POST \
#       -H "Content-Type: application/json" \
#       -d '{"cycle":300}' \
#       http://raspberrypi:5000/cycle
#
# Status:
#     curl http://raspberrypi:5000/status
#
# Thread stoppen:
#     curl -X POST http://raspberrypi:5000/stop
#
# ------------------------------------------------------------------
import threading
import time
from flask import Flask, jsonify, request, render_template
import RPi.GPIO as GPIO

# ------------------------------------------------------------------
# Boiler Controller
# ------------------------------------------------------------------
class BoilerController:

    def __init__(self, gpio_pin, cycle_time=60):
        self.gpio_pin = gpio_pin
        self.cycle_time = float(cycle_time)

        # 0.0 ... 1.0
        self.power = 0.0
        self.running = False

        # Aktuelle Phase:
        # "ON"  = GPIO HIGH
        # "OFF" = GPIO LOW
        self.phase = "OFF"

        # Restzeit der aktuellen Phase
        self.remaining = 0.0
        self.lock = threading.Lock()
        self.stop_event = threading.Event()
        self.update_event = threading.Event()
        self.thread = None
        GPIO.setup(
            self.gpio_pin,
            GPIO.OUT,
            initial=GPIO.LOW
        )

    # --------------------------------------------------------------
    # Start
    # --------------------------------------------------------------
    def start(self):
        with self.lock:
            if self.running:
                return
            self.running = True
        self.stop_event.clear()
        self.update_event.clear()
        self.thread = threading.Thread(
            target=self._worker,
            daemon=True
        )
        self.thread.start()

    # --------------------------------------------------------------
    # Stop
    # --------------------------------------------------------------
    def stop(self):
        with self.lock:
            if not self.running:
                GPIO.output(
                    self.gpio_pin,
                    GPIO.LOW
                )
                self.phase = "OFF"
                self.remaining = 0.0
                return
        self.stop_event.set()
        if self.thread is not None:
            self.thread.join()
        GPIO.output(
            self.gpio_pin,
            GPIO.LOW
        )
        with self.lock:
            self.running = False
            self.phase = "OFF"
            self.remaining = 0.0
        self.thread = None

    # --------------------------------------------------------------
    # Leistung setzen
    # --------------------------------------------------------------
    def set_power(self, power):
        power = float(power)

        # Begrenzen auf 0 ... 1
        power = max(
            0.0,
            min(1.0, power)
        )
        with self.lock:
            self.power = power
        # Worker soll seine aktuelle Phase abbrechen
        # und mit den neuen Werten neu beginnen.
        self.update_event.set()

    # --------------------------------------------------------------
    # Zykluszeit setzen
    # --------------------------------------------------------------
    def set_cycle_time(self, cycle_time):
        cycle_time = float(cycle_time)
        if cycle_time <= 0:
            raise ValueError(
                "cycle_time must be greater than 0"
            )
        with self.lock:
            self.cycle_time = cycle_time
        # Worker soll neu berechnen
        self.update_event.set()

    # --------------------------------------------------------------
    # Status
    # --------------------------------------------------------------
    def get_status(self):
        with self.lock:
            return {
                "running": self.running,
                "power": round(self.power, 3),
                "power_percent": round(
                    self.power * 100,
                    1
                ),
                "cycle_time": self.cycle_time,
                "gpio": GPIO.input(
                    self.gpio_pin
                ),
                "phase": self.phase,
                "remaining": round(
                    self.remaining,
                    1
                )
            }

    # --------------------------------------------------------------
    # Warten
    # --------------------------------------------------------------
    def _wait_with_status(self, seconds):
        start = time.monotonic()
        while True:
            elapsed = (
                time.monotonic() - start
            )
            remaining = seconds - elapsed
            with self.lock:
                self.remaining = max(
                    0.0,
                    remaining
                )
            # Zeit abgelaufen
            if remaining <= 0:
                return "timeout"
            # Stop angefordert
            if self.stop_event.wait(
                min(remaining, 0.2)
            ):
                return "stop"
            # Power oder Zykluszeit geändert
            if self.update_event.is_set():
                self.update_event.clear()
                return "update"

    # --------------------------------------------------------------
    # Worker Thread
    # --------------------------------------------------------------
    def _worker(self):
        print("Boiler Worker gestartet")
        while not self.stop_event.is_set():
            # --------------------------------------------------
            # Aktuelle Einstellungen lesen
            # --------------------------------------------------
            with self.lock:
                power = self.power
                cycle = self.cycle_time
            # --------------------------------------------------
            # EIN- und AUS-Zeit berechnen
            # --------------------------------------------------
            on_time = cycle * power
            off_time = cycle - on_time
            # ==================================================
            # EIN
            # ==================================================
            if on_time > 0:
                GPIO.output(
                    self.gpio_pin,
                    GPIO.HIGH
                )
                with self.lock:
                    self.phase = "ON"
                    self.remaining = on_time
                result = self._wait_with_status(
                    on_time
                )
                if result == "stop":
                    break
                if result == "update":
                    continue

            # ==================================================
            # AUS
            # ==================================================
            if off_time > 0:
                GPIO.output(
                    self.gpio_pin,
                    GPIO.LOW
                )
                with self.lock:
                    self.phase = "OFF"
                    self.remaining = off_time
                result = self._wait_with_status(
                    off_time
                )
                if result == "stop":
                    break
                if result == "update":
                    continue

        # ------------------------------------------------------
        # Sicherheit: GPIO immer ausschalten
        # ------------------------------------------------------
        GPIO.output(
            self.gpio_pin,
            GPIO.LOW
        )
        with self.lock:
            self.phase = "OFF"
            self.remaining = 0.0
            self.running = False
        print("Boiler Worker beendet")

# ------------------------------------------------------------------
# GPIO
# ------------------------------------------------------------------
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

# ------------------------------------------------------------------
# Controller
# ------------------------------------------------------------------
controller = BoilerController(
    gpio_pin=16,
    cycle_time=60
)

# ------------------------------------------------------------------
# Flask
# ------------------------------------------------------------------
app = Flask(__name__)

# ------------------------------------------------------------------
# Jinja Weboberfläche
# ------------------------------------------------------------------
@app.route("/")
def index():
    return render_template(
        "boiler_05.html",
        status=controller.get_status()
    )

# ------------------------------------------------------------------
# Status
# ------------------------------------------------------------------
@app.route("/status")
def status():
    return jsonify(
        controller.get_status()
    )

# ------------------------------------------------------------------
# Start
# ------------------------------------------------------------------
@app.route("/start", methods=["POST"])
def start():
    controller.start()
    return jsonify(
        success=True,
        status=controller.get_status()
    )

# ------------------------------------------------------------------
# Stop
# ------------------------------------------------------------------
@app.route("/stop", methods=["POST"])
def stop():
    controller.stop()
    return jsonify(
        success=True,
        status=controller.get_status()
    )

# ------------------------------------------------------------------
# Power
# ------------------------------------------------------------------
@app.route("/power", methods=["POST"])
def power():
    data = request.get_json(
        silent=True
    )
    if not data or "power" not in data:
        return jsonify(
            success=False,
            error="Missing parameter: power"
        ), 400
    try:
        controller.set_power(
            data["power"]
        )
    except (TypeError, ValueError):
        return jsonify(
            success=False,
            error="Invalid power value"
        ), 400
    return jsonify(
        success=True,
        status=controller.get_status()
    )

# ------------------------------------------------------------------
# Cycle
# ------------------------------------------------------------------
@app.route("/cycle", methods=["POST"])
def cycle():
    data = request.get_json(
        silent=True
    )
    if not data or "cycle" not in data:
        return jsonify(
            success=False,
            error="Missing parameter: cycle"
        ), 400
    try:
        controller.set_cycle_time(
            data["cycle"]
        )
    except (TypeError, ValueError):
        return jsonify(
            success=False,
            error="Invalid cycle value"
        ), 400
    return jsonify(
        success=True,
        status=controller.get_status()
    )

# ------------------------------------------------------------------
# Main
# ------------------------------------------------------------------
if __name__ == "__main__":
    try:
        app.run(
            host="0.0.0.0",
            port=5000
        )
    finally:
        controller.stop()
        GPIO.cleanup()