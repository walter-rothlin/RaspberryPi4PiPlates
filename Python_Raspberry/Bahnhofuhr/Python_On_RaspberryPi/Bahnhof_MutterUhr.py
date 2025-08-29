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
# ------------------------------------------------------------------
import RPi.GPIO as GPIO
import time
import threading
import time
from   datetime import datetime
from   flask import Flask, request, jsonify
import socket

# === Globale Variablen ===
GPIO_PIN       = 26     # Pin-Definition (BCM-Nummerierung)
current_state  = False  # Anfangszustand
tick_controler = None
aktion_aktiv   = True

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
        GPIO.output(GPIO_PIN, GPIO.LOW)
    else:
        GPIO.output(GPIO_PIN, GPIO.HIGH)
    

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
    GPIO.setup(GPIO_PIN, GPIO.OUT)
    print(f'Set GPIO_PIN:{GPIO_PIN} to HIGH (Off)')
    GPIO.output(GPIO_PIN, GPIO.HIGH)
    do_loop = True
    while do_loop:
        antwort = input('Weiter (s=stopp):')
        if antwort == 's':
            do_loop=False
        else:
            switchGPIO()
    
    time.sleep(5)
    
    tickArgs(count=5, delay=1)
    
    print(f'Set GPIO_PIN:{GPIO_PIN} to LOW (on)')
    GPIO.output(GPIO_PIN, GPIO.LOW)
    
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
    

# === Flask Webserver ===
app = Flask(__name__)

@app.route('/')
def index():
    uhr_bild_url = "https://www.blog.mobatime.ch/hs-fs/hubfs/Bilder/Blog/sbb_sekunden.gif?width=392&height=396&name=sbb_sekunden.gif"
    now = datetime.now()
    javaScript_clock = '''
          <!-- Bootstrap JS -->
          <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
          
          <!-- JavaScript für Live-Uhr -->
          <script>
            function updateClock() {
              const now = new Date();
              const options = { 
                day: '2-digit', month: 'long', year: 'numeric',
                hour: '2-digit', minute: '2-digit', second: '2-digit'
              };
              document.getElementById("clock").textContent = now.toLocaleString("de-DE", options);
            }
            setInterval(updateClock, 1000);
            updateClock(); // erste Anzeige sofort
          </script>
    '''

    return f'''
        <!DOCTYPE html>
        <html lang="de">
        <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <title>SBB-Uhr</title>
          <!-- Bootstrap CSS -->
          <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>
        <body class="bg-light">

          <div class="container py-5">
            <div class="card shadow-lg p-4">
              <div class="card-body text-center">
                
                <!-- Bild -->
                <img src="https://www.blog.mobatime.ch/hs-fs/hubfs/Bilder/Blog/sbb_sekunden.gif?width=392&height=396&name=sbb_sekunden.gif" 
                     class="img-fluid mx-auto d-block mb-3" 
                     alt="SBB Uhr" 
                     width="120">
                
                <h1 class="h4 mb-2">SBB-Uhr Steuerung</h1>
                
                <!-- Live Uhrzeit -->
                <h2 class="h5 text-muted mb-4" id="clock"></h2>
                <h2 class="h5 text-muted mb-4">{now.strftime('%d.%B %Y %H:%M:%S')}</h2>

                <!-- Eingabe-Feld für Zeit -->
                <div class="mt-4 mb-4">
                  <form action="/set_time" method="post" class="row g-2 justify-content-center">
                    <div class="col-auto d-flex align-items-center">
                        <label for="user_time" class="form-label fw-bold">Uhr zeigt</label>
                    </div>
                    <div class="col-auto">
                      <input type="time" name="user_time" class="form-control form-control-lg" required>
                    </div>
                    <div class="col-auto">
                      <button type="submit" class="btn btn-outline-secondary btn-lg">⏰ Zeit setzen</button>
                    </div>
                  </form>
                </div>

                <!-- Buttons -->
                <div class="row g-3">
                  <div class="col-md-6">
                    <form action="/start_timer" method="post">
                      <button type="submit" class="btn btn-success btn-lg w-100">▶ Start Clock</button>
                    </form>
                  </div>
                  <div class="col-md-6">
                    <form action="/stop_timer" method="post">
                      <button type="submit" class="btn btn-danger btn-lg w-100">⏹ Stop Clock</button>
                    </form>
                  </div>
                  <div class="col-md-6">
                    <form action="/suspend" method="post">
                      <button type="submit" class="btn btn-warning btn-lg w-100">⏸ Suspend Tick</button>
                    </form>
                  </div>
                  <div class="col-md-6">
                    <form action="/activate" method="post">
                      <button type="submit" class="btn btn-primary btn-lg w-100">⏵ Activate Tick</button>
                    </form>
                  </div>
                </div>
                
              </div>
                <!-- Status Button -->
                <form action="/status_JSON" method="get" class="mb-4">
                  <button type="submit" class="btn btn-outline-primary btn-lg">
                    Status als JSON abrufen
                  </button>
                </form>
            </div>
          </div>
          {javaScript_clock}
        </body>
        </html>
    '''


@app.route('/start_timer', methods=['POST'])
def start_timer():
    global tick_controler, last_timer_config
    if tick_controler and not tick_controler.stop_event.is_set():
        return {"status": "already running", "message": "Timer läuft bereits."}

    tick_controler = timer_controler(
        last_timer_config["func"],
        last_timer_config["interval_seconds"],
        *last_timer_config["args"],
        **last_timer_config["kwargs"]
    )
    return {"status": "started", "message": "Timer wurde gestartet."}

@app.route('/stop_timer', methods=['POST'])
def stop_timer():
    global tick_controler
    if tick_controler and not tick_controler.stop_event.is_set():
        tick_controler.stop()
        return {"status": "stopped", "message": "Timer wurde gestoppt."}
    return {"status": "already stopped", "message": "Timer ist bereits gestoppt."}

@app.route('/suspend', methods=['POST'])
def suspend():
    global aktion_aktiv
    aktion_aktiv = False
    return {"status": "suspended", "message": "Aktionen werden nicht mehr ausgeführt."}

@app.route('/activate', methods=['POST'])
def activate():
    global aktion_aktiv
    aktion_aktiv = True
    return {"status": "active", "message": "Aktionen werden wieder ausgeführt."}

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
        
        count_of_forward_ticks = (ist_total_minutes - display_total_minutes) % (12*60)  # innerhalb von 12h
        print(f"{count_of_forward_ticks} Minuten vorwärts stellen")
        if count_of_forward_ticks > 100:
            count_of_forward_ticks = 0
            ret_str =  f"Zeitdifferenz zu gross!!! Suspend Ticks!"
        else:
            ret_str =  f"Uhr {count_of_forward_ticks} Minuten vorgestellt!"
            
        # z. B. an deine Timer-/GPIO-Logik weiterleiten
        tickArgs(count=count_of_forward_ticks, delay=1)
    return ret_str
    
    
if __name__ == '__main__':
    # TEST_01()
    
    # Initialisiere Standard-Konfiguration
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(GPIO_PIN, GPIO.OUT)
    print(f'Set GPIO_PIN:{GPIO_PIN} to HIGH (Off)')
    GPIO.output(GPIO_PIN, GPIO.HIGH)
    last_timer_config["func"] = meine_aktion

    start_timer()

    try:
        host_ip = get_ip()
        print(f"Starte Flask auf {host_ip}:5001")
        # app.run(debug=True, host=host_ip, port=5001, use_reloader=False)
        app.run(host="0.0.0.0", port=5001, debug=False, use_reloader=False)
    except KeyboardInterrupt:
        print("Beendet durch Nutzer, stoppe Timer...")
        if tick_controler:
            tick_controler.stop()
        print("Timer beendet.")
