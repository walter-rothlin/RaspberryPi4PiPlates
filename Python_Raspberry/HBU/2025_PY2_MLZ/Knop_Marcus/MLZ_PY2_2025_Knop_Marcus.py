#!/usr/bin/python3
# ------------------------------------------------------------------
# Name  : 01_SenseHat_Flask.py
# Description: Flask-REST-API für Sense HAT: LED-Matrix & Sensoren
# Author: Marcus Knop (auf Basis der Vorgaben)
# ------------------------------------------------------------------

from flask import Flask, request, jsonify, render_template
from datetime import datetime
import inspect

# Eigene Klasse (mit Fallback/Mock, Bounds-Checks etc.)
from Class_My_SenseHat import MySenseHat

# ===========================================
# Globale Variablen
# ===========================================
version = 'Marcus Knop (V1.0)'
request_log = []

# ===========================================
# Hilfsfunktionen
# ===========================================
def get_http_parameter(req, endpoint='unknown', verbal=False):
    if req.method == "GET":
        params = dict(req.args)
        if verbal: print(f"GET {endpoint}: {params}")
    elif req.method == "POST":
        params = dict(req.form)
        if verbal: print(f"POST {endpoint}: {params}")
    elif req.is_json:
        params = req.get_json()
        if verbal: print(f"JSON {endpoint}: {params}")
    else:
        params = {}

    call_debug = f'{req.method}: {endpoint}({params})'
    if verbal: print(call_debug)
    return params, call_debug

def log_call(arguments: str):
    ts = datetime.now().strftime('%d-%m-%y %H:%M:%S')
    request_log.append(f"{ts}: {arguments}")

# ===========================================
# App + Sense
# ===========================================
app = Flask(__name__, template_folder='templates', static_folder='static')
sense = MySenseHat()
sense.clear((0, 0, 0))  # Start: Matrix löschen

# ====================
# Overall-Status
# ====================
@app.route('/get_status', methods=['GET'])
def get_status():
    params, dbg = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    log_call(dbg)

    return jsonify({
        'LED_Matrix': sense.get_pixels(),
        'Temperature': {'value': sense.get_temperature(), 'unit': '°C'},
        'Humidity': {'value': sense.get_humidity(), 'unit': '%'},
        'Pressure': {'value': sense.get_pressure(), 'unit': 'mBar'},
        'rotation': sense.rotation
    })

# ====================
# LED-Matrix Endpoints
# ====================
@app.route('/set_rotation', methods=['GET', 'POST'])
def set_rotation():
    params, dbg = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    angle = sense.parse_int(params.get('angle', params.get('rotation', 0)), default=0)
    angle = (angle // 90) * 90  # nur 0/90/180/270
    sense.set_rotation(angle)
    log_call(dbg)
    return jsonify({'ok': True, 'rotation': sense.rotation})

@app.route('/flip_h', methods=['GET', 'POST'])
def flip_h():
    params, dbg = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    sense.flip_h()
    log_call(dbg)
    return jsonify({'ok': True})

@app.route('/flip_v', methods=['GET', 'POST'])
def flip_v():
    params, dbg = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    sense.flip_v()
    log_call(dbg)
    return jsonify({'ok': True})

@app.route('/get_pixels', methods=['GET'])
def get_pixels():
    params, dbg = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    log_call(dbg)
    return jsonify({'pixels': sense.get_pixels()})

@app.route('/set_pixel', methods=['GET', 'POST'])
def set_pixel():
    params, dbg = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    x = sense.parse_int(params.get('x'), default=0)
    y = sense.parse_int(params.get('y'), default=0)

    # Farbe kann als r,g,b oder colour/color (Name/Hex/"r,g,b") kommen
    if all(k in params for k in ('r', 'g', 'b')):
        r = sense.parse_int(params.get('r'), default=0, min_=0, max_=255)
        g = sense.parse_int(params.get('g'), default=0, min_=0, max_=255)
        b = sense.parse_int(params.get('b'), default=0, min_=0, max_=255)
        colour = (r, g, b)
    else:
        colour_str = params.get('colour', params.get('color', 'black'))
        colour = sense.parse_rgb(colour_str, default=(0, 0, 0))

    clamped, x2, y2 = sense.set_pixel(x, y, colour)
    log_call(dbg)
    return jsonify({'ok': True, 'x': x, 'y': y, 'used_x': x2, 'used_y': y2, 'colour': list(colour), 'clamped': clamped})

@app.route('/get_pixel', methods=['GET'])
def get_pixel():
    params, dbg = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    x = sense.parse_int(params.get('x'), default=0)
    y = sense.parse_int(params.get('y'), default=0)
    clamped, x2, y2, rgb = sense.get_pixel(x, y)
    log_call(dbg)
    return jsonify({'x': x, 'y': y, 'used_x': x2, 'used_y': y2, 'colour': list(rgb), 'clamped': clamped})

@app.route('/clear', methods=['GET', 'POST'])
def clear():
    params, dbg = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    colour = params.get('colour', params.get('color', 'black'))
    rgb = sense.parse_rgb(colour, default=(0, 0, 0))
    sense.clear(rgb)
    log_call(dbg)
    # Zurück zur Startseite (Template zeigt Logs unten)
    return render_template('index.html', version=version, request_log=request_log, checks_ok=True)

@app.route('/show_letter', methods=['GET', 'POST'])
def show_letter():
    params, dbg = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    s = str(params.get('s', '?'))[0]
    tc = sense.parse_rgb(params.get('text_colour', params.get('text_color', 'white')), default=(255, 255, 255))
    bc = sense.parse_rgb(params.get('back_colour', params.get('back_color', 'black')), default=(0, 0, 0))
    sense.show_letter(s, tc, bc)
    log_call(dbg)
    return render_template('index.html', version=version, request_log=request_log, checks_ok=True)

@app.route('/show_message', methods=['GET', 'POST'])
def show_message():
    params, dbg = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    text = params.get('text', params.get('message', 'Hello'))
    scroll_speed = sense.parse_float(params.get('speed', params.get('scroll_speed', 0.1)), default=0.1, min_=0.01, max_=1.0)
    tc = sense.parse_rgb(params.get('text_colour', params.get('text_color', 'white')), default=(255, 255, 255))
    bc = sense.parse_rgb(params.get('back_colour', params.get('back_color', 'black')), default=(0, 0, 0))
    sense.show_message(text, scroll_speed, tc, bc)
    log_call(dbg)
    return jsonify({'ok': True})

@app.route('/draw_line', methods=['GET', 'POST'])
def draw_line():
    params, dbg = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    x1 = sense.parse_int(params.get('x1'), default=0)
    y1 = sense.parse_int(params.get('y1'), default=0)
    x2 = sense.parse_int(params.get('x2'), default=7)
    y2 = sense.parse_int(params.get('y2'), default=7)
    colour = sense.parse_rgb(params.get('colour', params.get('color', 'white')), default=(255, 255, 255))
    used_points = sense.draw_line(x1, y1, x2, y2, colour)
    log_call(dbg)
    return jsonify({'ok': True, 'points': used_points, 'colour': list(colour)})

# =====================
# Environmental sensors
# =====================
@app.route('/get_temperature', methods=['GET'])
@app.route('/get_temprature', methods=['GET'])  # Tippfehler-Variante für Tests
def get_temperature():
    params, dbg = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    t = sense.get_temperature()
    log_call(dbg)
    return jsonify({'temperature': {'value': t, 'unit': '°C'}})

@app.route('/get_pressure', methods=['GET'])
def get_pressure():
    params, dbg = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    p = sense.get_pressure()
    log_call(dbg)
    return jsonify({'pressure': {'value': p, 'unit': 'mBar'}})

@app.route('/get_humidity', methods=['GET'])
def get_humidity():
    params, dbg = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    h = sense.get_humidity()
    log_call(dbg)
    return jsonify({'humidity': {'value': h, 'unit': '%'}})

@app.route('/get_meteo_sensor_values', methods=['GET'])
def get_meteo_sensor_values():
    params, dbg = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    data = {
        'temperature': {'value': sense.get_temperature(), 'unit': '°C'},
        'humidity': {'value': sense.get_humidity(), 'unit': '%'},
        'pressure': {'value': sense.get_pressure(), 'unit': 'mBar'},
    }
    log_call(dbg)
    return jsonify(data)

@app.route('/get_weather', methods=['GET'])
def get_weather():
    """
    Einfache Ableitung einer 'Wetterlage' aus T/H/P (für die Test-Cases).
    """
    params, dbg = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    t = sense.get_temperature()
    h = sense.get_humidity()
    p = sense.get_pressure()

    # simple Heuristik
    if h > 80 and p < 1005:
        desc = 'rainy'
        emoji = '🌧️'
    elif h < 35 and p > 1020 and 15 <= t <= 28:
        desc = 'sunny'
        emoji = '☀️'
    elif t < 5:
        desc = 'cold'
        emoji = '🥶'
    else:
        desc = 'cloudy'
        emoji = '⛅'

    log_call(dbg)
    return jsonify({
        'summary': desc,
        'emoji': emoji,
        'metrics': {
            'temperature': {'value': t, 'unit': '°C'},
            'humidity': {'value': h, 'unit': '%'},
            'pressure': {'value': p, 'unit': 'mBar'}
        }
    })

# =====================
# Pages
# =====================
@app.route('/')
def index():
    # Alle Häkchen sind implementiert → ✅
    return render_template('index.html', version=version, request_log=request_log, checks_ok=True)

@app.route('/LED_Matrix_Tester')
def LED_Matrix_Tester():
    return render_template('LED_Matrix_Tester.html', version=version)

# =====================
# Main
# =====================
if __name__ == '__main__':
    # Passe Host/Port an deinen Pi an:
    app.run(debug=True, host='0.0.0.0', port=5002)
