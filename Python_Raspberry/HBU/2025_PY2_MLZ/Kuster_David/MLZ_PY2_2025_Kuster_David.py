#!/usr/bin/python

# ------------------------------------------------------------------
# Name  : 01_SenseHat_Flask.py
# https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/refs/heads/main/Python_Raspberry/04_Sense_Hat/Flask/LN/SenseHat/Vorbereitung/01_SenseHat_Flask.py
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
# 08-Oct-2025  Walter Rothlin     Prepared for MLZ
# ------------------------------------------------------------------

from flask import *
from sense_hat import SenseHat
from time import sleep
from datetime import datetime
import webcolors
import inspect
from Class_MySenseHat import MySenseHat

# ===========================================
# globale Variablen
# ===========================================
version = 'David Kuster (V1.0)'
request_log = []


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

    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name, verbal=True)

    r = convert2Integer(received_parameter.get('r'), default_value=0)
    redraw = convert2Boolean(received_parameter.get('redraw'), default_value=True)

    valid_angles = {0, 90, 180, 270}
    if r not in valid_angles:
        print(f"[set_rotation] Invalid angle '{r}'. Falling back to 0°.")
        r = 0

    try:
        print(f"[set_rotation] sense.set_rotation({r}, redraw={redraw})")
        sense.set_rotation(r, redraw=redraw)
        status_msg = f"Rotation set to {r}° (redraw={'on' if redraw else 'off'})"
    except Exception as e:
        status_msg = f"Error setting rotation: {e}"
        print("[set_rotation] " + status_msg)

    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments} -> {status_msg}")
    return render_template('index.html', version=version, request_log=request_log)


@app.route('/flip_h', methods=['GET', 'POST'])
def flip_h():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name, verbal=True)
    redraw = convert2Boolean(received_parameter.get('redraw'), default_value=True)

    try:
        sense.flip_h(redraw=redraw)
        status_msg = f"Flipped horizontally (redraw={'on' if redraw else 'off'})"
    except Exception as e:
        status_msg = f"Error flipping horizontally: {e}"

    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments} -> {status_msg}")
    return render_template('index.html', version=version, request_log=request_log)


@app.route('/flip_v', methods=['GET', 'POST'])
def flip_v():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name, verbal=True)
    redraw = convert2Boolean(received_parameter.get('redraw'), default_value=True)

    try:
        sense.flip_v(redraw=redraw)
        status_msg = f"Flipped vertically (redraw={'on' if redraw else 'off'})"
    except Exception as e:
        status_msg = f"Error flipping vertically: {e}"

    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments} -> {status_msg}")
    return render_template('index.html', version=version, request_log=request_log)


@app.route('/set_pixels', methods=['GET', 'POST'])
def set_pixels():
    return f'set_pixels() not to be implemented yet!<br/><br/><a href="/">Back</a>'


@app.route('/get_pixels', methods=['GET', 'POST'])
def get_pixels():
    return sense.get_pixels()


@app.route('/set_pixel', methods=['GET', 'POST'])
def set_pixel():
    '''
    Sets a single LED at (x,y) on the Sense HAT.

    Accepted parameters (GET, POST, or JSON):
      - x, y: coordinates in range 0..7
      - Either:
          r, g, b: integers 0..255
        OR
          pixel: tuple/list/string/hex/name convertible to RGB
                 e.g. "(255, 0, 255)", "255,0,255", "#ff00ff", "magenta"
      - Optional alias:
          colour: same as `pixel`

    Precedence: pixel/colour  >  (r,g,b)

    Returns (JSON):
      { "x": <int>, "y": <int>, "pixel": {"r": <int>, "g": <int>, "b": <int>} }
    '''
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name, verbal=True)

    # coords
    x = convert2Integer(received_parameter.get('x'), default_value=0, min=0, max=7)
    y = convert2Integer(received_parameter.get('y'), default_value=0, min=0, max=7)

    # color resolution: pixel/colour first, else r,g,b
    rgb = None
    pixel_raw = received_parameter.get('pixel')
    colour_raw = received_parameter.get('colour')  # alias
    if pixel_raw is not None:
        rgb = convert2RGB(pixel_raw, default_value=None)
    elif colour_raw is not None:
        rgb = convert2RGB(colour_raw, default_value=None)
    else:
        r = convert2Integer(received_parameter.get('r'), default_value=None, min=0, max=255)
        g = convert2Integer(received_parameter.get('g'), default_value=None, min=0, max=255)
        b = convert2Integer(received_parameter.get('b'), default_value=None, min=0, max=255)
        if r is not None and g is not None and b is not None:
            rgb = (r, g, b)

    # default to black if nothing valid provided
    if rgb is None:
        rgb = (0, 0, 0)

    # clamp (defensive; converters already clamp)
    r = max(0, min(255, int(rgb[0])))
    g = max(0, min(255, int(rgb[1])))
    b = max(0, min(255, int(rgb[2])))
    rgb = (r, g, b)

    try:
        print(f"[set_pixel] sense.set_pixel({x}, {y}, {rgb})")
        sense.set_pixel(x, y, rgb)
        status_msg = f"set_pixel({x},{y},{r},{g},{b})"
    except Exception as e:
        status_msg = f"Error set_pixel({x},{y},{r},{g},{b}): {e}"
        print("[set_pixel] " + status_msg)

    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments} -> {status_msg}")

    return render_template('index.html', version=version, request_log=request_log)


@app.route('/get_pixel', methods=['GET', 'POST'])
def get_pixel():
    '''
    Returns the color value (RGB) of a single LED pixel on the Sense HAT.

    Accepted parameters (GET, POST, or JSON):
      - x, y: coordinates in range 0..7

    Example:
        /get_pixel?x=2&y=4
        → {"x": 2, "y": 4, "pixel": {"r": 255, "g": 255, "b": 0}}

    Returns:
        JSON object containing x, y, and the pixel’s RGB value.
    '''
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name, verbal=True)

    # Read and validate coordinates
    x = convert2Integer(received_parameter.get('x'), default_value=0, min=0, max=7)
    y = convert2Integer(received_parameter.get('y'), default_value=0, min=0, max=7)

    try:
        pixel = sense.get_pixel(x, y)  # returns [r, g, b]
        r, g, b = [int(c) for c in pixel]
        status_msg = f"get_pixel({x},{y}) -> ({r},{g},{b})"
        print(f"[get_pixel] {status_msg}")
    except Exception as e:
        r = g = b = 0
        status_msg = f"Error get_pixel({x},{y}): {e}"
        print("[get_pixel] " + status_msg)

    # Log request
    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments} -> {status_msg}")

    # Return as JSON
    return {
        "x": x,
        "y": y,
        "pixel": {"r": r, "g": g, "b": b}
    }

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
    '''
    Scrolls a message on the Sense HAT LED matrix.

    Parameters (GET, POST, or JSON):
      - text_string (required): the text to scroll
      - scroll_speed (optional): float speed in seconds per column (default 0.1)
      - text_colour (optional): RGB for text, e.g. "(255,0,255)", "#ff00ff", "magenta" (default (255,255,255))
      - back_colour (optional): RGB for background (default (0,0,0))

    Returns (JSON):
      {
        "text_string": "<str>",
        "scroll_speed": <float>,
        "text_colour": {"r": <int>, "g": <int>, "b": <int>},
        "back_colour": {"r": <int>, "g": <int>, "b": <int>}
      }
    '''
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name, verbal=True)

    # Required: text_string
    text_string = received_parameter.get('text_string')
    if not text_string:
        err = {"error": "Parameter 'text_string' is required."}
        request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments} -> {err}")
        return err

    scroll_speed = convert2Float(received_parameter.get('scroll_speed'), default_value=0.1, min=0.005, max=5.0)
    text_colour = convert2RGB(received_parameter.get('text_colour'), (255, 255, 255))
    back_colour = convert2RGB(received_parameter.get('back_colour'), (0, 0, 0))

    tr, tg, tb = [max(0, min(255, int(c))) for c in text_colour]
    br, bg, bb = [max(0, min(255, int(c))) for c in back_colour]
    text_colour = (tr, tg, tb)
    back_colour = (br, bg, bb)

    try:
        sense.show_message(text_string, scroll_speed=scroll_speed,
                           text_colour=text_colour, back_colour=back_colour)
        status_msg = (f"show_message({text_string!r}, {scroll_speed}, "
                      f"{text_colour}, {back_colour})")
    except Exception as e:
        status_msg = f"Error show_message({text_string!r}): {e}"

    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments} -> {status_msg}")

    return render_template('index.html', version=version, request_log=request_log)


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

# =====================
# Environmental sensors
# =====================
@app.route('/get_temperature', methods=['GET', 'POST'])
def get_temperature():
    '''
    Returns the current ambient temperature from the Sense HAT as JSON.
    Example: /get_temperature
    '''
    temperature = round(sense.get_temperature(), 2)
    return {'Temperature': {'value': temperature, 'unit': '°C'}}


@app.route('/get_pressure', methods=['GET', 'POST'])
def get_pressure():
    '''
    Returns the current air pressure from the Sense HAT as JSON.
    Example: /get_pressure
    '''
    pressure = round(sense.get_pressure(), 2)
    return {'Pressure': {'value': pressure, 'unit': 'mBar'}}


@app.route('/get_humidity', methods=['GET', 'POST'])
def get_humidity():
    '''
    Returns the current relative humidity from the Sense HAT as JSON.
    Example: /get_humidity
    '''
    humidity = round(sense.get_humidity(), 2)
    return {'Humidity': {'value': humidity, 'unit': '%'}}


@app.route('/get_meteo_sensor_values', methods=['GET', 'POST'])
def get_meteo_sensor_values():
    '''
    Returns all meteorological sensor values (temperature, pressure, humidity) as JSON.
    Example: /get_meteo_sensor_values
    '''
    data = {
        'Temperature': {'value': round(sense.get_temperature(), 2), 'unit': '°C'},
        'Pressure': {'value': round(sense.get_pressure(), 2), 'unit': 'mBar'},
        'Humidity': {'value': round(sense.get_humidity(), 2), 'unit': '%'}
    }
    return data

@app.route('/get_weather', methods=['GET', 'POST'])
def get_weather():
    '''
    Returns a simple weather summary as JSON based on current temperature and humidity.

    Example:
        /get_weather
        → {
            "Weather": "Moderate",
            "Temperature": {"value": 22.3, "unit": "°C"},
            "Humidity": {"value": 58.1, "unit": "%"}
          }
    '''
    temperature = round(sense.get_temperature(), 1)
    humidity = round(sense.get_humidity(), 1)

    # Simple heuristic for descriptive weather
    if humidity > 80 and temperature < 20:
        weather = "Rainy"
    elif humidity < 40 and temperature > 25:
        weather = "Dry/Hot"
    elif temperature < 5:
        weather = "Cold"
    else:
        weather = "Moderate"

    return {
        "Weather": weather,
        "Temperature": {"value": temperature, "unit": "°C"},
        "Humidity": {"value": humidity, "unit": "%"}
    }

@app.route('/')
def index():
    return render_template('index.html', version=version, request_log=request_log)


@app.route('/LED_Matrix_Tester')
def LED_Matrix_Tester():
    return render_template('LED_Matrix_Tester.html')

# ============================
# Enpoints in MySenseHat Class
# ============================

sense = MySenseHat()

@app.route('/draw_line', methods=['GET', 'POST'])
def draw_line():
    '''
    Delegates to MySenseHat.draw_line(x_start, y_start, x_end, y_end, r, g, b, draw_speed)
    and then returns to the home screen.
    '''
    received_parameter, arguments = get_http_parameter(request, 'draw_line', verbal=True)

    x_start = convert2Integer(received_parameter.get('x_start'), default_value=0)
    y_start = convert2Integer(received_parameter.get('y_start'), default_value=0)
    x_end   = convert2Integer(received_parameter.get('x_end'),   default_value=7)
    y_end   = convert2Integer(received_parameter.get('y_end'),   default_value=7)

    # You can accept either r/g/b or a single colour/pixel string if you like
    r = convert2Integer(received_parameter.get('r'), default_value=255, min=0, max=255)
    g = convert2Integer(received_parameter.get('g'), default_value=255, min=0, max=255)
    b = convert2Integer(received_parameter.get('b'), default_value=255, min=0, max=255)

    draw_speed = convert2Float(received_parameter.get('draw_speed'), default_value=0.0, min=0.0, max=2.0)

    try:
        # Call your subclass method
        sense.draw_line(x_start, y_start, x_end, y_end, r, g, b, draw_speed)
        status_msg = f"draw_line({x_start},{y_start},{x_end},{y_end},{r},{g},{b}, {draw_speed})"
    except Exception as e:
        status_msg = f"Error draw_line: {e}"
        print("[draw_line] " + status_msg)

    # Log and go back home (keeps UI consistent with your other endpoints)
    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments} -> {status_msg}")
    return render_template('index.html', version=version, request_log=request_log)


if __name__ == '__main__':
    app.run(debug=True, host='kustipi.tail115180.ts.net', port=8080)  # IP-Adresse des Raspberry Pi einsetzen
