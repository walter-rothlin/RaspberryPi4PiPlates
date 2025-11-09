#!/usr/bin/python

# ------------------------------------------------------------------
# Name  : scheduler.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/05_Schaltuhren/Schaltuhr_for_multipl_Relais/scheduler.py
#
# Description: Schaltuhr Frontend
#
#
# Autor: Walter Rothlin
#
# History:
# 09-Nov-2025   Walter Rothlin    Initial Version
#
# ------------------------------------------------------------------
import time
from datetime import datetime
import json, os
import logging
import RPi.GPIO as GPIO


RELAY_PIN = 21
CONFIG_FILE = "config.json"
schedules = []

logging.basicConfig(level=logging.INFO)

GPIO.setmode(GPIO.BCM)
GPIO.setup(RELAY_PIN, GPIO.OUT)

def set_relay_state(on: bool):
    GPIO.output(RELAY_PIN, GPIO.HIGH if on else GPIO.LOW)
    logging.info(f"Relay set to {'ON' if on else 'OFF'}")

def update_schedule(new_schedules):
    global schedules
    schedules = new_schedules
    logging.info("Schedules updated: %s", schedules)

def load_config():
    if os.path.exists(CONFIG_FILE):
        with open(CONFIG_FILE, 'r') as f:
            return json.load(f)
    return {"schedules": [], "state": False}

def start_scheduler():
    global schedules
    # initialize schedules from config
    cfg = load_config()
    schedules = cfg.get("schedules", [])
    logging.info("Scheduler started with schedules: %s", schedules)
    last_min = None
    while True:
        now = datetime.now()
        current_hm = now.strftime("%H:%M")
        weekday = now.weekday()  # 0=Mon .. 6=Sun
        # only act when minute changes to avoid repeated toggles in same minute
        if last_min != current_hm:
            last_min = current_hm
            # check schedules
            for entry in schedules:
                try:
                    if weekday in entry.get("weekdays", []):
                        if entry.get("start") == current_hm:
                            set_relay_state(True)
                            logging.info("Scheduled ON - %s", entry)
                        if entry.get("end") == current_hm:
                            set_relay_state(False)
                            logging.info("Scheduled OFF - %s", entry)
                except Exception as e:
                    logging.exception("Error processing schedule entry: %s", e)
        time.sleep(5)
