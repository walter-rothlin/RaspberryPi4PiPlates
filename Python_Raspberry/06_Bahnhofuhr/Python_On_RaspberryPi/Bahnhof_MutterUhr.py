#!/usr/bin/python
#
# ------------------------------------------------------------------
# Name  : Bahnhof_MutterUhr.py
# ------------------------------------------------------------------
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/Bahnhofuhr/Python_On_RaspberryPi/Bahnhof_MutterUhr.py
#
# Description: Mutteruhr ohne Drift und mit REST-Services zum richten und start/stop
# 
# Autostarrt after boot:
#    mkdir -p /home/pi/logs
#    crontab -e
#    @reboot /usr/bin/python3 /home/pi/bin/Bahnhof_Mutter_Uhr.py >> /home/pi/logs/mutter_uhr.log 2>&1 &

#
# Autor: Walter Rothlin
#
# History:
# 03-Aug-2025   Walter Rothlin      Initial Version based on https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_WaltisExamples/Code_02_BasicPython/pythonBasics_08j_repeating_timer_REST_Controlled.py
# 25-Aug-2025   Walter Rothlin      GPIO Test
# 28-Aug-2025   Walter Rothlin      Added nice Frontend
# 29-Aug-2025   Walter Rothlin      Startable via crontab, Uhr richten
# 26-Sep-2025   Walter Rothlin      Added Lampe on/off Relais
# ------------------------------------------------------------------
import RPi.GPIO as GPIO
import time
import threading
from datetime import datetime
from flask import Flask, request, jsonify, render_template, redirect, url_for
import socket

# === Globale Variablen ===
GPIO_PIN_Min_Clock = 26  # Pin-Definition for Min-Clock Relais (BCM-Nummerierung)
GPIO_PIN_Lampe_On_Off = 19  # Pin-Definition for Lampe on/off     (BCM-Nummerierung)
current_state = False  # Anfangszustand
tick_controler = None
aktion_aktiv = True

last_timer_config = {
    "func": None,
    "interval_seconds": 60,
    "args": (),
    "kwargs": {"name": "SBB-Uhr", "wert": 0}
}


def switchGPIO():
    global current_state
    current_state = not current_state
    if current_state:
        GPIO.output(GPIO_PIN_Min_Clock, GPIO.LOW)
    else:
        GPIO.output(GPIO_PIN_Min_Clock, GPIO.HIGH)


def tickArgs(count=10, delay=1):
    print('tick ', end='', flush=True)
    for x in range(count):
        print('.', end='', flush=True)
        switchGPIO()
        time.sleep(delay)
    print()
    return "done"


def TEST_01():
    print('TEST_01 running....')
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(GPIO_PIN_Min_Clock, GPIO.OUT)
    print(f'Set GPIO_PIN_Min_Clock:{GPIO_PIN_Min_Clock} to HIGH (Off)')
    GPIO.output(GPIO_PIN_Min_Clock, GPIO.HIGH)
    do_loop = True
    while do_loop:
        antwort = input('Weiter (s=stopp):')
        if antwort == 's':
            do_loop = False
        else:
            switchGPIO()

    time.sleep(5)

    tickArgs(count=5, delay=1)

    print(f'Set GPIO_PIN_Min_Clock:{GPIO_PIN_Min_Clock} to LOW (on)')
    GPIO.output(GPIO_PIN_Min_Clock, GPIO.LOW)


# === Timer-Klasse ===
class timer_controler:
    def __init__(self, func, interval_seconds=60, *args, **kwargs):
        self.func = func
        self.interval_seconds = interval_seconds
        self.args = args
        self.kwargs = kwargs
        self.stop_event = threading.Event()
        self.thread = threading.Thread(target=self.run, daemon=True)
        self.thread.start()
        self.next_tick = None

    def run(self):
        now = datetime.now()
        epoch_seconds = int(now.timestamp())
        next_epoch = ((epoch_seconds // self.interval_seconds) + 1) * self.interval_seconds
        self.next_tick = datetime.fromtimestamp(next_epoch)

        delay = (self.next_tick - datetime.now()).total_seconds()
        if delay > 0:
            print(f"Warte {delay:.3f}s bis zum ersten Tick bei {self.next_tick.strftime('%Y-%m-%d %H:%M:%S')}")
            if self.stop_event.wait(timeout=delay):
                print("Timer wurde vor dem ersten Tick gestoppt.")
                return

        while not self.stop_event.is_set():
            now = datetime.now()
            print(f"{now.strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]}: Tick! ", end='')

            try:
                self.func(*self.args, **self.kwargs)
            except Exception as e:
                print(f"Fehler beim Aufruf der User-Function: {e}")

            now = datetime.now()
            epoch_seconds = int(now.timestamp())
            next_epoch = ((epoch_seconds // self.interval_seconds) + 1) * self.interval_seconds
            self.next_tick = datetime.fromtimestamp(next_epoch)

            delay = (self.next_tick - datetime.now()).total_seconds()
            if delay < 0:
                delay = 0

            if self.stop_event.wait(timeout=delay):
                print("Timer wurde gestoppt.")
                break

    def stop(self):
        self.stop_event.set()
        self.thread.join()


# === Beispiel einer User-Funktion ===
def meine_aktion(name, wert=0):
    global aktion_aktiv
    if not aktion_aktiv:
        print(f">> Tick für {name} übersprungen (Status: suspendiert)")
        return

    print(f">> Tick für {name} ...", end='')
    switchGPIO()
    print(f"   ...ausgeführt!\n")


def get_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        # Verbindung zu einer externen Adresse (hier Google DNS) erzwingen
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
    except Exception:
        ip = "127.0.0.1"
    finally:
        s.close()
    return ip


# Zustand der Lampe, Clock_Started, Clock_Suspended merken
lampen_status = False  # False = Aus, True = An
clock_started = True
clock_suspended = True


def set_lampen_relais(state: bool):
    global lampen_status
    lampen_status = state
    # Je nach Relais evtl. invertieren (HIGH = Aus, LOW = An)
    GPIO.output(GPIO_PIN_Lampe_On_Off, GPIO.HIGH if state else GPIO.LOW)


# === Flask Webserver ===
app = Flask(__name__, template_folder="/home/pi/Waltis_Repo_Clone/RaspberryPi4PiPlates/Python_Raspberry/Bahnhofuhr/Python_On_RaspberryPi/templates")


@app.route("/")
def index():
    now = datetime.now()
    print(f'lampe_an={lampen_status}, clock_started={clock_started}, clock_suspended={clock_suspended}')
    return render_template("index.html",
                           lampe_an=lampen_status,
                           clock_started=clock_started,
                           aktion_aktiv=aktion_aktiv,
                           server_time=now.strftime("%d.%B %Y %H:%M:%S"))


@app.route('/start_timer', methods=['POST'])
def start_timer(direct_called=False):
    global lampen_status
    global clock_started
    global tick_controler, last_timer_config

    clock_started = True

    if tick_controler and not tick_controler.stop_event.is_set():
        if direct_called:
            return {"status": "already running", "message": "Timer läuft bereits."}
        else:
            return redirect(url_for("index"))

    tick_controler = timer_controler(
        last_timer_config["func"],
        last_timer_config["interval_seconds"],
        *last_timer_config["args"],
        **last_timer_config["kwargs"]
    )

    if direct_called:
        return {"status": "already running", "message": "Timer läuft bereits."}
    else:
        return redirect(url_for("index"))


@app.route('/stop_timer', methods=['POST'])
def stop_timer():
    global lampen_status
    global clock_started
    global tick_controler

    clock_started = False

    if tick_controler and not tick_controler.stop_event.is_set():
        tick_controler.stop()
        return redirect(url_for("index"))


@app.route('/suspend', methods=['POST'])
def suspend():
    global aktion_aktiv
    aktion_aktiv = False
    # return {"status": "suspended", "message": "Aktionen werden nicht mehr ausgeführt."}
    return redirect(url_for("index"))


@app.route('/activate', methods=['POST'])
def activate():
    global aktion_aktiv
    aktion_aktiv = True
    # return {"status": "active", "message": "Aktionen werden wieder ausgeführt."}
    return redirect(url_for("index"))


@app.route('/status_JSON', methods=['GET'])
def status_JSON():
    global tick_controler, aktion_aktiv, last_timer_config
    status = "stopped"
    next_tick = "N/A"
    interval = last_timer_config["interval_seconds"]
    if tick_controler and not tick_controler.stop_event.is_set():
        status = "running"
        next_tick = tick_controler.next_tick.strftime('%Y-%m-%d %H:%M:%S') if tick_controler.next_tick else "N/A"

    aktion_status = "aktiv" if aktion_aktiv else "suspendiert"
    return {
        "01_current_time": datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        "02_next_tick": next_tick,
        "03_timer_status": status,
        "04_aktion_status": aktion_status,
        "05_interval_seconds": interval,
    }


@app.route("/set_time", methods=["POST"])
def set_time():
    display_time = request.form.get("user_time")
    if display_time:
        display_hour, display_minutes = display_time.split(':')
        display_hour = int(display_hour) % 12
        display_total_minutes = display_hour * 60 + int(display_minutes)
        print(f"Angezeigte Zeit: {display_time}   {display_hour}::{display_minutes}  --> {display_total_minutes}")

        now = datetime.now()
        ist_time = f"{now.strftime('%H:%M')}"
        ist_hour, ist_minutes = ist_time.split(':')
        ist_hour = int(ist_hour) % 12
        ist_total_minutes = ist_hour * 60 + int(ist_minutes)
        print(f"Aktuelle Zeit: {ist_time}   {ist_hour}::{ist_minutes}  --> {ist_total_minutes}")

        count_of_forward_ticks = (ist_total_minutes - display_total_minutes) % (12 * 60)  # innerhalb von 12h
        print(f"{count_of_forward_ticks} Minuten vorwärts stellen")
        if count_of_forward_ticks > 100:
            count_of_forward_ticks = 0
            ret_str = f"Zeitdifferenz zu gross!!! Suspend Ticks!"
        else:
            ret_str = f"Uhr {count_of_forward_ticks} Minuten vorgestellt!"

        # z. B. an deine Timer-/GPIO-Logik weiterleiten
        tickArgs(count=count_of_forward_ticks, delay=1)
    # return ret_str
    return redirect(url_for("index"))


@app.route('/set_lampe_on')
def set_lampe_on():
    set_lampen_relais(True)
    return 'Lampe On'


@app.route('/set_lampe_off')
def set_lampe_off():
    set_lampen_relais(False)
    return 'Lampe Off'


@app.route("/toggle_lampe", methods=["POST"])
def toggle_lampe():
    set_lampen_relais(not lampen_status)
    return redirect(url_for("index"))


if __name__ == '__main__':
    # TEST_01()

    # Initialisiere Standard-Konfiguration
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(GPIO_PIN_Min_Clock, GPIO.OUT)
    print(f'Set GPIO_PIN_Min_Clock:{GPIO_PIN_Min_Clock} to HIGH (Off)')
    GPIO.output(GPIO_PIN_Min_Clock, GPIO.HIGH)

    GPIO.setup(GPIO_PIN_Lampe_On_Off, GPIO.OUT)
    set_lampen_relais(True)
    last_timer_config["func"] = meine_aktion
    start_timer(direct_called=True)

    try:
        host_ip = get_ip()
        print(f"Starte Flask auf {host_ip}:5001")
        time.sleep(3)
        set_lampen_relais(False)
        # app.run(debug=True, host=host_ip, port=5001, use_reloader=False)
        app.run(host="0.0.0.0", port=5001, debug=False, use_reloader=False)
    except KeyboardInterrupt:
        print("Beendet durch Nutzer, stoppe Timer...")
        if tick_controler:
            tick_controler.stop()
        print("Timer beendet.")
