import time
from datetime import datetime
import json, os

try:
    import RPi.GPIO as GPIO
except Exception:
    class _FakeGPIO:
        BCM = 'BCM'
        OUT = 'OUT'
        LOW = False
        HIGH = True
        def setmode(self, *_): pass
        def setup(self, *_): pass
        def output(self, *_): pass
        def cleanup(self): pass
    GPIO = _FakeGPIO()

CONFIG_FILE = "config.json"
schedules = []
relay_pins = {}
relay_states = {}

def set_relay_state(relay_name, on):
    pin = relay_pins.get(relay_name)
    if pin is not None:
        GPIO.output(pin, GPIO.HIGH if on else GPIO.LOW)
    relay_states[relay_name] = on

def update_schedule(new_schedules, states, relays):
    global schedules, relay_pins, relay_states
    schedules = new_schedules
    relay_pins = {{r["name"]: r["pin"] for r in relays}}
    relay_states = states
    GPIO.setmode(GPIO.BCM)
    for pin in relay_pins.values():
        GPIO.setup(pin, GPIO.OUT)
    # Set initial states
    for name, state in relay_states.items():
        set_relay_state(name, state)
    # Start scheduler thread
    import threading
    def loop():
        last_min = None
        while True:
            now = datetime.now()
            current_hm = now.strftime("%H:%M")
            weekday = now.weekday()
            global schedules
            if last_min != current_hm:
                last_min = current_hm
                for s in schedules:
                    if weekday in s["weekdays"]:
                        if s["start"] == current_hm:
                            set_relay_state(s["relay"], True)
                        if s["end"] == current_hm:
                            set_relay_state(s["relay"], False)
            time.sleep(5)
    threading.Thread(target=loop, daemon=True).start()
