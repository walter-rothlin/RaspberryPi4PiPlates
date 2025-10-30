#!/usr/bin/env python

# ------------------------------------------------------------------
# Name  : SBB_Uhr.py
#
# Description: Generiert den Minuten-Clock um die Mutteruhr zu simulieren. Stellt Web-Applikationen und 
#              REST-Services fürs richten der Uhr zur Verfügung
#
# Autor: Raphael Sauer
#
# History:  
# 01-Jul-2025   Raphael Sauer      Initial Version
# ------------------------------------------------------------------
from  flask import *
import threading
import RPi.GPIO as GPIO
import time

# setup REST API
app = Flask(__name__)

# Pin-Definition (BCM-Nummerierung)
PIN = 26  

# Anfangszustand
zustand = False

def switchGPIO():
    global zustand
    zustand = not zustand
    GPIO.output(PIN, zustand)

@app.route("/")
def Welcome():
    return '''
<html>
<head>
<title>Uhr Controller</title>
</head>
<body>

<h1>Uhr Controller</h1>
<a href="/legal">Copyright</a><br>
<p>Unten ist die API beschreibung</p>
<a href="/tick">/tick (ruecke die uhr einen tick (1Min) vor)</a><br>
<a href="/tick_args?count=10&delay=0.125">/tick_args?count=10&delay=0.125 (ruecke die Uhr um {count} weiter in einem zeitabstand von {delay} sekunden)</a>
</body>
</html>
'''

@app.route("/legal")
def Legal():
   return '''
<html>
<head>
<title>Legal</title>
</head>
<body>

<h1>Copyright</h1>
<p>Copyright ┬® 2025 Raphael Sauer</p>
<p>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ÔÇ£SoftwareÔÇØ), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:</p>
<p>The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.</p>
<p>THE SOFTWARE IS PROVIDED ÔÇ£AS ISÔÇØ, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.</p>
</body>
</html>
'''

@app.route("/tick")
def tick():
    switchGPIO()
    return "tick executed"

@app.route("/tick_args", methods=['GET'])
def tickArgs():
    count = int(request.args.get('count'))
    delay = float(request.args.get('delay'))
    for x in range(count):
        switchGPIO()
        time.sleep(delay)
    return "done"

def mainThread():
    global PIN
    global zustand
    # Setup GPIO
    #GPIO.setmode(GPIO.BCM)
    #GPIO.setup(PIN, GPIO.OUT)

    # Anfangszustand
    zustand = False
    #GPIO.output(PIN, zustand)
    print("Starte Zustand-Toggler (alle 60 Sekunden)...")

    try:
        while True:
            # Zustand umschalten
            switchGPIO()
            print(f"Zustand gewechselt: {zustand}")
            time.sleep(60)

    except KeyboardInterrupt:
        print("Programm manuell beendet.")

    finally:
        GPIO.cleanup()
        print("GPIO zur├╝ckgesetzt.")

def REST_API():
    app.run(debug=True, host='0.0.0.0', port=5001)

# setup threading
t_mainThread = threading.Thread(target=mainThread)
t_REST_API = threading.Thread(target=REST_API)

if __name__ == '__main__':
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(PIN, GPIO.OUT)
    GPIO.output(PIN, zustand)
    t_mainThread.start()
    #t_REST_API.start()
    REST_API()

