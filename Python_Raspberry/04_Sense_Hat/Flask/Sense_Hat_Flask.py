#!/usr/bin/python

# ------------------------------------------------------------------
# Name  : Sense_Hat_Flask.py
# https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/refs/heads/main/Python_Raspberry/04_Sense_Hat/Flask/Sense_Hat_Flask.py
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
# 06-Oct-2025  Walter Rothlin     Defined and implemented all Endpoints
# ------------------------------------------------------------------

from flask import *
from sense_hat import SenseHat
from time import sleep
from datetime import datetime
import webcolors
import inspect

version = 'Walter Rothlin V1.0)'
request_log = []

MySenseHat_Classed_used = False
if MySenseHat_Classed_used:
    from Class_My_SenseHat import *

# ===========================================
# Common functions for URL-Parameter handling
# ===========================================
def get_http_parameter(request, name_endpoint='unknown', verbal=False):
    if request.method == "GET":
        all_parameters = dict(request.args)
        if verbal:
            print(f"get_http_parameter: GET: {all_parameters}")
    elif request.method == "POST":
        all_parameters = dict(request.form)
        if verbal:
            print(f"get_http_parameter: POST: {all_parameters}")
    elif request.is_json:
        all_parameters = request.get_json()
        if verbal:
            print(f"get_http_parameter: JSON: {all_parameters}")
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


def convert2RGB_old(value, default_value=None):
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


def convert2RGB(value, default_value=None):
    """
        print(convert2RGB((255,0,128)))        # (255, 0, 128)
        print(convert2RGB([0,128,255]))        # (0, 128, 255)
        print(convert2RGB("255,0,128"))        # (255, 0, 128)
        print(convert2RGB("0 128 255"))        # (0, 128, 255)
        print(convert2RGB("#ff00ff"))          # (255, 0, 255)
        print(convert2RGB("ff00ff"))           # (255, 0, 255)
        print(convert2RGB("red"))              # (255, 0, 0)
        print(convert2RGB("lightblue"))        # (173, 216, 230)
        print(convert2RGB(100))                # (100, 100, 100)
        print(convert2RGB("unknown", default_value=(0,0,0)))  # (0, 0, 0)
    """
    try:
        # Bereits Tuple/List mit 3 Elementen
        if isinstance(value, (tuple, list)) and len(value) == 3:
            return tuple(int(min(max(0, v), 255)) for v in value)

        # String-Verarbeitung
        elif isinstance(value, str):
            cleaned = value.strip().replace(" ", "").replace("'", "").lower()

            # Hex-Farbe
            if cleaned.startswith('#'):
                cleaned = cleaned[1:]
            if len(cleaned) == 6 and all(c in '0123456789abcdef' for c in cleaned):
                r = int(cleaned[0:2], 16)
                g = int(cleaned[2:4], 16)
                b = int(cleaned[4:6], 16)
                return (r, g, b)

            # CSS3-Farbname
            try:
                rgb = webcolors.name_to_rgb(cleaned)
                return (rgb.red, rgb.green, rgb.blue)
            except ValueError:
                pass  # kein bekannter Name, weitermachen

            # RGB-Komma- oder Leerzeichen-Format
            cleaned = cleaned.replace("(", "").replace(")", "")
            print(f'--> cleaned:{cleaned}')
            if ',' in cleaned:
                parts = cleaned.split(',')
            else:
                parts = cleaned.split()

            print(f'--> parts:{parts}')
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


# ===========================================
# Application and Endpoints
# ===========================================
app = Flask(__name__)
if MySenseHat_Classed_used:
    sense = MySenseHat()
else:
    sense = SenseHat()

sense.clear()  # LED-Matrix löschen

# ====================
# Overall-Status
# ====================
@app.route('/get_status', methods=['GET'])
def get_status():
    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: get_status()")
    pixel_status = sense.get_pixels()
    humidity = sense.get_humidity()
    temperature = sense.get_temperature()
    pressure = sense.get_pressure()

    # print(pixel_status)
    return {'LED_Matrix': pixel_status,
            'Temperature': {'value': temperature, 'unit': '°C'},
            'Humidity': {'value': humidity, 'unit': '%'},
            'Pressure': {'value': pressure, 'unit': 'mBar'},
            }


# ====================
# LED-Matrix Endpoints
# ====================
@app.route('/set_rotation', methods=['GET', 'POST'])
def set_rotation():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    print(f'10) {arguments}')
    r = convert2Float(received_parameter.get('r'), 0)
    redraw = convert2Boolean(received_parameter.get('redraw'), True)
    if r not in [0, 90, 180, 270]:
        r = 0

    print(f'10) set_rotation({r}, {redraw})')
    sense.set_rotation(r=r, redraw=redraw)

    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments}")
    return render_template('index.html', version=version, request_log=request_log)
    # return f'set_rotation() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/flip_h', methods=['GET', 'POST'])
def flip_h():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    print(f'20) {arguments}')
    redraw = convert2Boolean(received_parameter.get('redraw'), True)

    print(f'20) flip_h({redraw})')
    sense.flip_h(redraw=redraw)

    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments}")
    return render_template('index.html', version=version, request_log=request_log)
    # return f'flip_h() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/flip_v', methods=['GET', 'POST'])
def flip_v():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    print(f'30) {arguments}')
    redraw = convert2Boolean(received_parameter.get('redraw'), True)

    print(f'30) flip_v({redraw})')
    sense.flip_v(redraw=redraw)

    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments}")
    return render_template('index.html', version=version, request_log=request_log)
    # return f'flip_v() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/set_pixels', methods=['GET', 'POST'])
def set_pixels():
    return f'set_pixels() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/get_pixels', methods=['GET', 'POST'])
def get_pixels():
    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: get_pixels()")
    pixel_status = sense.get_pixels()
    return pixel_status
    # return f'get_pixels() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/set_pixel', methods=['GET', 'POST'])
def set_pixel():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    print(f'60) {arguments}')
    x = convert2Integer(received_parameter.get('x'), -1)
    y = convert2Integer(received_parameter.get('y'), -1)
    r = convert2Integer(received_parameter.get('r'), -1)
    g = convert2Integer(received_parameter.get('g'), -1)
    b = convert2Integer(received_parameter.get('b'), -1)
    pixel = convert2RGB(received_parameter.get('pixel'), None)

    if pixel is not None:
        print(f'60) set_pixel({x}, {y}, pixel={pixel})')
        sense.set_pixel(x, y, pixel)
    else:
        print(f'60) set_pixel({x}, {y}, {r}, {g}, {b})')
        sense.set_pixel(x, y, r, g, b)

    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments}")
    return render_template('index.html', version=version, request_log=request_log)
    # return f'set_pixel() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/get_pixel', methods=['GET', 'POST'])
def get_pixel():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    print(f'60) {arguments}')
    x = convert2Integer(received_parameter.get('x'), -1)
    y = convert2Integer(received_parameter.get('y'), -1)

    pixel_status = sense.get_pixel(x, y)
    return pixel_status
    # return f'get_pixel() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/clear', methods=['GET', 'POST'])
def clear():
    print('clear called!!!')
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name, verbal=True)
    print(f'40) {arguments}')
    colour = convert2RGB(received_parameter.get('colour'), (0, 0, 0))

    print(f'40) clear({colour})')
    sense.clear(colour)

    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments}")
    return render_template('index.html', version=version, request_log=request_log)
    # return f'clear() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/show_message', methods=['GET', 'POST'])
def show_message():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    print(f'1) {arguments}')
    text_string = received_parameter.get('text_string', 'Kein Wert!!!')
    scroll_speed = convert2Float(received_parameter.get('scroll_speed'), 0.1)
    text_colour = convert2RGB(received_parameter.get('text_colour'), (255, 255, 255))
    back_colour = convert2RGB(received_parameter.get('back_colour'), (0, 0, 0))

    print(f'1) show_message({text_string}, {scroll_speed}, {text_colour}, {back_colour})')
    sense.show_message(text_string=text_string, scroll_speed=scroll_speed, text_colour=text_colour, back_colour=back_colour)

    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments}")
    return render_template('index.html', version=version, request_log=request_log)
    # return f'show_message() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/show_letter', methods=['GET', 'POST'])
def show_letter():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    print(f'2) {arguments}')
    s = received_parameter.get('s', '?')[0]
    text_colour = convert2RGB(received_parameter.get('text_colour'), (255, 255, 255))
    back_colour = convert2RGB(received_parameter.get('back_colour'), (0, 0, 0))

    print(f'2) show_letter({s}, {text_colour}, {back_colour})')
    sense.show_letter(s=s, text_colour=text_colour, back_colour=back_colour)

    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments}")
    return render_template('index.html', version=version, request_log=request_log)
    # return f'show_letter() not implemented yet!<br/><br/><a href="/">Back</a>'


# ============================
# Enpoints in MySenseHat Class
# ============================
@app.route('/draw_line', methods=['GET', 'POST'])
def draw_line():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    print(f'100) {arguments}')
    x_start = convert2Integer(received_parameter.get('x_start'), -1)
    y_start = convert2Integer(received_parameter.get('y_start'), -1)
    x_end = convert2Integer(received_parameter.get('x_end'), -1)
    y_end = convert2Integer(received_parameter.get('y_end'), -1)
    r = convert2Integer(received_parameter.get('r'), -1)
    g = convert2Integer(received_parameter.get('g'), -1)
    b = convert2Integer(received_parameter.get('b'), -1)
    draw_speed = convert2Float(received_parameter.get('draw_speed'), 0)
    pixel = None
    if pixel is not None:
        print(f'100) draw_line({x}, {y}, pixel={pixel})')
        sense.draw_line(x, y, pixel)
    else:
        print(f'100) draw_line({x_start}, {y_start}, {x_end}, {y_end}, {r}, {g}, {b})')
        sense.draw_line(x_start, y_start, x_end, y_end, r, g, b, 0.1)

    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments}")
    return render_template('index.html', version=version, request_log=request_log)
    # return f'draw_line() not implemented yet!<br/><br/><a href="/">Back</a>'


# =====================
# Environmental sensors
# =====================
@app.route('/get_temperature', methods=['GET', 'POST'])
def get_temperature():
    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: get_temperature()")
    return {'value': sense.get_temperature(),
            'units': '°C'}
    # return f'get_temperature() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/get_pressure')
def get_pressure():
    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: get_pressure()")
    return {'value': sense.get_pressure(),
            'units': 'mBar'}
    # return f'get_pressure() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/get_humidity')
def get_humidity():
    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: get_humidity()")
    return {'value': sense.get_humidity(),
            'units': '%'}
    # return f'get_humidity() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/get_meteo_sensor_values')
def get_meteo_sensor_values():
    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: get_meteo_sensor_values()")
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
    # return f'get_meteo_sensor_values() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/get_weather')
def get_weather():
    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: get_weather()")
    return f'''
    <h1>Wetter</h1>
    Temperatur:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {sense.get_temperature():0.2f}°C<br/>
    Luftdruck:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {sense.get_pressure():0.2f}mBar<br/>
    Rel. Feuchtigkeit:&nbsp; {sense.get_humidity():0.2f}%<br/>

    <br/><br/><a href="/">Back</a>
    '''
    # return f'get_weather() not implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/')
def index():
    return render_template('index.html', version=version, request_log=request_log)


@app.route('/LED_Matrix_Tester')
def LED_Matrix_Tester():
    return render_template('LED_Matrix_Tester.html')


if __name__ == '__main__':
    # app.run(debug=True, host='192.168.1.170', port=5002)  # Peterliwiese 33
    app.run(debug=True, host='192.168.86.138', port=5002)  # Laax
