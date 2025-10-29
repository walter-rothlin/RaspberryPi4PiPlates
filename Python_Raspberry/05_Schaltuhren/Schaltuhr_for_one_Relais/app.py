from flask import Flask, render_template, request, redirect, url_for, jsonify
import json, os, threading, time
from datetime import datetime
import logging

# Try to import RPi.GPIO, fall back to a fake GPIO for development/testing on non-Pi systems.
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

from scheduler import start_scheduler, update_schedule, set_relay_state, RELAY_PIN

app = Flask(__name__, template_folder='templates', static_folder='static')

CONFIG_FILE = "config.json"

logging.basicConfig(level=logging.INFO)

# Load or create config
def ensure_config():
    if not os.path.exists(CONFIG_FILE):
        cfg = {
            "schedules": [
                # example entry:
                # {"start": "07:00", "end": "09:00", "weekdays": [0,1,2,3,4], "name": "Morgens"}
            ],
            "state": False,
            "relay_pin": RELAY_PIN
        }
        with open(CONFIG_FILE, "w") as f:
            json.dump(cfg, f, indent=4)

def load_config():
    with open(CONFIG_FILE, "r") as f:
        return json.load(f)

def save_config(cfg):
    with open(CONFIG_FILE, "w") as f:
        json.dump(cfg, f, indent=4)

ensure_config()

@app.route("/")
def index():
    cfg = load_config()
    # map weekdays numbers to names for display
    weekday_names = ["Mo","Di","Mi","Do","Fr","Sa","So"]
    return render_template("index.html", schedules=cfg["schedules"], state=cfg["state"], weekdays=weekday_names, config=cfg)

@app.route("/toggle", methods=["POST"])
def toggle():
    cfg = load_config()
    cfg["state"] = not cfg["state"]
    set_relay_state(cfg["state"])
    save_config(cfg)
    return redirect(url_for("index"))

@app.route("/add", methods=["POST"])
def add_schedule():
    start_time = request.form["start"]
    end_time = request.form["end"]
    name = request.form.get("name","")
    # weekdays sent as multiple form values; collect all ints 0-6
    weekdays = request.form.getlist("weekday")
    weekdays = [int(w) for w in weekdays]
    entry = {"start": start_time, "end": end_time, "weekdays": weekdays, "name": name}
    cfg = load_config()
    cfg["schedules"].append(entry)
    save_config(cfg)
    update_schedule(cfg["schedules"])
    return redirect(url_for("index"))

@app.route("/delete/<int:index>", methods=["POST"])
def delete_schedule(index):
    cfg = load_config()
    if 0 <= index < len(cfg["schedules"]):
        del cfg["schedules"][index]
        save_config(cfg)
        update_schedule(cfg["schedules"])
    return redirect(url_for("index"))

@app.route("/api/schedules")
def api_schedules():
    return jsonify(load_config()["schedules"])

if __name__ == "__main__":
    # start scheduler thread
    threading.Thread(target=start_scheduler, daemon=True).start()
    # ensure relay matches saved state
    cfg = load_config()
    set_relay_state(cfg.get("state", False))
    app.run(host="0.0.0.0", port=5000, debug=False)
