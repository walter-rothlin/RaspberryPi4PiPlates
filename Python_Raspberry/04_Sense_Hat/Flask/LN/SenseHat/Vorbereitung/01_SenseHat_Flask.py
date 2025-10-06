#!/usr/bin/python

# ------------------------------------------------------------------
# Name  : Sense_Hat_Flask.py
#
# Description: Stellt Web-Applikationen und REST-Services für die Steuerung der LED-Matrix
#              und das Auslesen der Sensoren auf dem Sense-Hat

#
#
# Autor: Walter Rothlin
#
# History:
# 01-Jul-2025  Walter Rothlin     Initial Version
# 04-Oct-2025  Walter Rothlin     Prepared for HBU MLZ 2025
# 06-Oct-2025  Walter Rothlin     Defined all Endpoints
# ------------------------------------------------------------------

from flask import *
from sense_hat import SenseHat
from time import sleep
import webcolors
import inspect


def get_http_parameter(request, name_endpoint='unknown', verbal=False):
    if request.method == "GET":
        all_parameters = dict(request.args)
        if verbal:
            print(f"show_message: GET: {all_parameters}")
    elif request.method == "POST":
        all_parameters = dict(request.form)
        if verbal:
            print(f"show_message: POST: {all_parameters}")
    elif request.is_json:
        all_parameters = request.get_json()
        if verbal:
            print(f"show_message: JSON: {all_parameters}")
    else:
        all_parameters = {}

    call_debug = f'{request.method}: {name_endpoint}({all_parameters})'
    if verbal:
        print(call_debug)
    return all_parameters, call_debug


def convert2Float(value, default_value=None, min=None, max=None):
    try:
        if isinstance(value, str):
            cleaned = value.strip()  # führende/trailing Spaces weg
            cleaned = cleaned.replace(" ", "")  # Spaces löschen
            cleaned = cleaned.replace("'", "")  # Tausendertrenner löschen
            cleaned = cleaned.replace(",", ".")  # Komma durch Punkt ersetzen
            ret_val = float(cleaned)
        else:
            # int, float und andere direkt versuchen
            ret_val = float(value)

        # Min-/Max-Prüfung
        if min is not None and ret_val < min:
            return min
        if max is not None and ret_val > max:
            return max

        return ret_val

    except (TypeError, ValueError):
        return default_value


def convert2Integer(value, default_value=None, min=None, max=None):
    try:
        if isinstance(value, str):
            cleaned = value.strip()  # führende/trailing Spaces weg
            cleaned = cleaned.replace(" ", "")  # Spaces löschen
            cleaned = cleaned.replace("'", "")  # Tausendertrenner löschen
            cleaned = cleaned.replace(",", "")  # Kommas löschen (z. B. 1,234 → 1234)
            ret_val = int(float(cleaned))  # zuerst float, dann int
        else:
            ret_val = int(float(value))  # auch bei int/float/anderen Typen

        # Min-/Max-Prüfung
        if min is not None and ret_val < min:
            return min
        if max is not None and ret_val > max:
            return max

        return ret_val

    except (TypeError, ValueError):
        return default_value


def convert2Boolean(value, default_value=None):
    try:
        if isinstance(value, str):
            cleaned = value.strip().lower()  # führende/trailing Spaces weg + lowercase
            if cleaned in ('1', 'true', 'yes', 'y'):
                return True
            elif cleaned in ('0', 'false', 'no', 'n'):
                return False
            else:
                return default_value
        elif isinstance(value, (int, float)):
            return bool(value)  # 0 -> False, alles andere -> True
        elif isinstance(value, bool):
            return value
        else:
            return default_value
    except Exception:
        return default_value


def convert2RGB(value, default_value=None):
    try:
        # Bereits Tuple/List mit 3 Elementen
        if isinstance(value, (tuple, list)) and len(value) == 3:
            return tuple(int(min(max(0, v), 255)) for v in value)

        # String-Verarbeitung
        elif isinstance(value, str):
            cleaned = value.strip().replace("(", "").replace(")", "").replace(" ", "").replace("'", "").lower()

            # Hex-Farbe erkennen
            if cleaned.startswith('#'):
                cleaned = cleaned[1:]
            if len(cleaned) == 6:  # z. B. 'ff00ff'
                r = int(cleaned[0:2], 16)
                g = int(cleaned[2:4], 16)
                b = int(cleaned[4:6], 16)
                return (r, g, b)

            # RGB-Komma- oder Leerzeichen-Format
            if ',' in cleaned:
                parts = cleaned.split(',')
            else:
                parts = cleaned.split()
            if len(parts) != 3:
                return default_value
            return tuple(int(min(max(0, int(p)), 255)) for p in parts)

        # Einzelzahl → Grau
        elif isinstance(value, (int, float)):
            v = int(min(max(0, int(value)), 255))
            return (v, v, v)

        else:
            return default_value

    except Exception:
        return default_value


red = (255, 0, 0)
blue = (0, 0, 255)
green = (0, 255, 0)
black = (0, 0, 0)

app = Flask(__name__)
version = 'Walter Rothlin V1.0'

sense = SenseHat()


## sense = MySenseHat()


# ====================
# Overall-Status
# ====================
@app.route('/get_status', methods=['GET'])
def get_status():
    pixel_status = sense.get_pixels()
    humidity = sense.get_humidity()
    temperature = sense.get_temperature()
    pressure = sense.get_pressure()

    # print(pixel_status)
    return {'LED_Matrix': pixel_status,
            'Temperature': temperature,
            'Humidity': humidity,
            'Pressure': pressure,
            }


# ====================
# LED-Matrix Endpoints
# ====================
@app.route('/set_rotation', methods=['GET', 'POST'])
def set_rotation():
    return f'set_rotation() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/flip_h', methods=['GET', 'POST'])
def flip_h():
    return f'flip_h() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/flip_v', methods=['GET', 'POST'])
def flip_v():
    return f'flip_v() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/set_pixels', methods=['GET', 'POST'])
def set_pixels():
    return f'set_pixels() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/get_pixels', methods=['GET', 'POST'])
def get_pixels():
    pixel_status = sense.get_pixels()
    return pixel_status


@app.route('/set_pixel', methods=['GET', 'POST'])
def set_pixel():
    all_get_parameters = dict(request.args.items())
    print(all_get_parameters)
    x = int(all_get_parameters.get('x', '0'))
    y = int(all_get_parameters.get('y', '0'))
    r = int(all_get_parameters.get('r', '0'))
    g = int(all_get_parameters.get('g', '0'))
    b = int(all_get_parameters.get('b', '0'))

    sense.set_pixel(x, y, r, g, b)
    return f'set_pixel({x},{y},{r},{g},{b})!<br/><br/><a href="/">Back</a>'


@app.route('/get_pixel', methods=['GET', 'POST'])
def get_pixel():
    return f'get_pixel() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/clear', methods=['GET', 'POST'])
def clear():
    # GET: Farbe aus Query-Parametern
    # POST: Farbe aus Form-Daten oder JSON
    bg_color = "black"  # Default

    if request.method == "GET":
        bg_color = request.args.get("color", "black")
    elif request.method == "POST":
        # Form-data
        if "color" in request.form:
            bg_color = request.form.get("color", "black")
        # JSON
        elif request.is_json:
            data = request.get_json()
            bg_color = data.get("color", "black")

    try:
        if bg_color.startswith("#"):  # Hexwert, z.B. #ff00cc
            rgb = tuple(int(bg_color[i:i + 2], 16) for i in (1, 3, 5))
            sense.clear(rgb)
        else:
            rgb = webcolors.name_to_rgb(bg_color)
            sense.clear((rgb.red, rgb.green, rgb.blue))
    except Exception as e:
        sense.clear()  # Fallback schwarz
        return f'❌ Ungültige Farbe "{bg_color}" ({e}), Matrix auf schwarz gesetzt.<br/><a href="/">Back</a>'

    return f'✅ Clear LED matrix to color {bg_color}!<br/><br/><a href="/">Back</a>'


@app.route('/show_message', methods=['GET', 'POST'])
def show_message():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    print(f'1) {arguments}')
    text_string = received_parameter.get('text_string', 'Kein Wert!!!')
    scroll_speed = received_parameter.get('scroll_speed')
    text_colour = received_parameter.get('text_colour')
    back_colour = received_parameter.get('back_colour')

    print(f'2) show_message({text_string}, {scroll_speed}, {text_colour}, {back_colour})')
    sense.show_message(text_string=text_string, scroll_speed=convert2Float(scroll_speed, 0.2), text_colour=convert2RGB(text_colour, (255, 255, 255)), back_colour=convert2RGB(back_colour, (0, 0, 0)))
    return f'{arguments} not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/show_letter', methods=['GET', 'POST'])
def show_letter():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    print(f'2) {arguments}')
    s = received_parameter.get('s', '?')[0]
    text_colour = convert2RGB(received_parameter.get('text_colour'), (255, 255, 255))
    back_colour = convert2RGB(received_parameter.get('back_colour'), (0, 0, 0))

    print(f'2) show_letter({s}, {text_colour}, {back_colour})')
    sense.show_letter(s=s, text_colour=text_colour, back_colour=back_colour)
    return f'{arguments} not implemented yet!<br/><br/><a href="/">Back</a>'


# =====================
# Environmental sensors
# =====================
@app.route('/get_temperature', methods=['GET', 'POST'])
def get_temperature():
    return {'value': sense.get_temperature(),
            'units': '°C'}


@app.route('/get_pressure')
def get_pressure():
    return {'value': sense.get_pressure(),
            'units': 'mBar'}


@app.route('/get_humidity')
def get_humidity():
    return {'value': sense.get_humidity(),
            'units': '%'}


@app.route('/get_meteo_sensor_values')
def get_meteo_sensor_values():
    weather_data = {
        'Temperatur': {
            'value': sense.get_temperature(),
            'units': 'mBar'},
        'Luftdruck': {
            'value': sense.get_pressure(),
            'units': 'mBar'},
        'Feuchtigkeit': {
            'value': sense.get_humidity(),
            'units': '%'},
    }
    return weather_data


@app.route('/get_weather')
def get_weather():
    return f'''
    <h1>Wetter</h1>
    Temperatur:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {sense.get_temperature():0.2f}°C<br/>
    Luftdruck:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {sense.get_pressure():0.2f}mBar<br/>
    Rel. Feuchtigkeit:&nbsp; {sense.get_humidity():0.2f}%<br/>

    <br/><br/><a href="/">Back</a>
    '''


@app.route('/')
def index():
    return render_template('index.html', version=version)


@app.route('/LED_Matrix_Tester')
def LED_Matrix_Tester():
    return render_template('LED_Matrix_Tester.html')


if __name__ == '__main__':
    # app.run(debug=True, host='RothlinsPi-2.bzu.ads', port=5002)
    # app.run(debug=True, host='192.168.1.170', port=5002)  # Peterliwiese 33
    app.run(debug=True, host='192.168.86.138', port=5002)  # Laax

    # app.run(debug=True, host='127.0.0.1', port=5002)