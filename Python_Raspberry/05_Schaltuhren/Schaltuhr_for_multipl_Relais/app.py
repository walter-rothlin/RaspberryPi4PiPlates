from flask import Flask, render_template, request, redirect, url_for, jsonify
import json, os, threading, time
from datetime import datetime

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

from scheduler import start_scheduler, update_schedule, set_relay_state

app = Flask(__name__, template_folder='templates', static_folder='static')
CONFIG_FILE = "config.json"

# Load or create config
if not os.path.exists(CONFIG_FILE):
    cfg = {"relays": [{"name": "Licht", "pin": 17}, {"name": "Pumpe", "pin": 27}, {"name": "L\u00fcfter", "pin": 22}], "schedules": [], "states": {}}
    for r in cfg["relays"]:
        cfg["states"][r["name"]] = False
    with open(CONFIG_FILE, "w") as f:
        json.dump(cfg, f, indent=4)

def load_config():
    with open(CONFIG_FILE, "r") as f:
        return json.load(f)

def save_config(cfg):
    with open(CONFIG_FILE, "w") as f:
        json.dump(cfg, f, indent=4)

@app.route("/")
def index():
    cfg = load_config()
    weekday_names = ["Mo","Di","Mi","Do","Fr","Sa","So"]
    return render_template("index.html", cfg=cfg, weekdays=weekday_names)

@app.route("/toggle/<relay_name>", methods=["POST"])
def toggle(relay_name):
    cfg = load_config()
    cfg["states"][relay_name] = not cfg["states"][relay_name]
    set_relay_state(relay_name, cfg["states"][relay_name])
    save_config(cfg)
    return redirect(url_for("index"))

@app.route("/add", methods=["POST"])
def add_schedule():
    relay_name = request.form["relay"]
    start_time = request.form["start"]
    end_time = request.form["end"]
    weekdays = [int(w) for w in request.form.getlist("weekday")]
    entry = {"relay": relay_name, "start": start_time, "end": end_time, "weekdays": weekdays}
    cfg = load_config()
    cfg["schedules"].append(entry)
    save_config(cfg)
    update_schedule(cfg["schedules"], cfg["states"], cfg["relays"])
    return redirect(url_for("index"))

@app.route("/delete/<int:index>", methods=["POST"])
def delete_schedule(index):
    cfg = load_config()
    if 0 <= index < len(cfg["schedules"]):
        del cfg["schedules"][index]
        save_config(cfg)
        update_schedule(cfg["schedules"], cfg["states"], cfg["relays"])
    return redirect(url_for("index"))

if __name__ == "__main__":
    cfg = load_config()
    update_schedule(cfg["schedules"], cfg["states"], cfg["relays"])
    app.run(host="0.0.0.0", port=5000)
