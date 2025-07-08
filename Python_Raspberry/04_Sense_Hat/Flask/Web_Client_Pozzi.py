#!/usr/bin/python3

# ------------------------------------------------------------------
# Name  : Web_Client_Pozzi.py
#
# Description: Web-Client mit dem die LED-Matrix über REST-Services zur angesteuert werden kann. (Sense_Hat_Flask)

#
#
# Autor: Beni Pozzi
#
# History:  
# 08-Jul-2025   Beni Pozzi      Initial Version
# ------------------------------------------------------------------

from flask import Flask, render_template, jsonify
import requests

app = Flask(__name__, template_folder='data')

# Globale Konfigurationswerte
ip = "192.168.107.97"
port = "5001"
r_prog = 0
g_prog = 255
b_prog = 0


def call_led(x=0, y=0, r=0, g=0, b=0):
    url = f"http://{ip}:{port}/set_pixel?x={x}&y={y}&r={r}&g={g}&b={b}"
    print("Aufruf:", url)
    try:
        response = requests.get(url)
        return f"Status {response.status_code}: {url}"
    except Exception as e:
        return f"Fehler beim Aufruf: {e}"

@app.route('/')
def index():
    return render_template("web_client_main.html")

@app.route('/button/<int:row>/<int:col>')
def button_click(row, col):
    y = row 
    x = col
    return call_led(x, y, r_prog, g_prog, b_prog)

@app.route('/clear')
def clear():
    for x in range(8):
        for y in range(8):
            call_led(x, y, 0, 0, 0)
    return "Matrix gelöscht"

@app.route('/daten/ip/<ip_str>/<port_str>')
def daten_ip(ip_str, port_str):
    global ip, port
    ip = ip_str
    port = port_str
    return f"Ziel IP: {ip}, Port: {port}"

@app.route('/daten/rgb/<int:r>/<int:g>/<int:b>')
def daten_rgb(r, g, b):
    global r_prog, g_prog, b_prog
    r_prog = r
    g_prog = g
    b_prog = b
    return f"Farbe gesetzt auf: ({r_prog}, {g_prog}, {b_prog})"

@app.route('/status')
def status():
    try:
        url = f"http://{ip}:{port}/get_status"
        response = requests.get(url, timeout=2)
        data = response.json()
        led_matrix = data.get("LED_Matrix", [])
        return jsonify(led_matrix)
    except Exception as e:
        print("Fehler beim Statusabruf:", e)
        # Rückgabe einer schwarzen Matrix als Fallback
        return jsonify([[0,0,0]]*64)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)
