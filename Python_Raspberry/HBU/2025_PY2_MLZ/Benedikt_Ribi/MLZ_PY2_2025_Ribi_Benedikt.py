#!/usr/bin/env python3

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

# Prefer the MySenseHat wrapper if available; otherwise fall back to a
# SenseHat implementation (hardware, emulator, or the centralized mock).
# We try to ensure the running `sense` object implements the full
# MySenseHat surface so methods are defined only once (in Class_MySenseHat).
try:
    from Class_MySenseHat import MySenseHat
    sense = MySenseHat()
    _SENSE_IMPL = 'mysensehat'
except Exception:
    # No MySenseHat wrapper available; pick the best base SenseHat and
    # try to wrap it with MySenseHat if possible.
    try:
        from sense_hat import SenseHat
        _SENSE_IMPL = 'hardware'
    except Exception:
        try:
            from sense_emu import SenseHat
            _SENSE_IMPL = 'emulator'
        except Exception:
            # centralized mock
            from mock_sensehat import SenseHat
            _SENSE_IMPL = 'mock'

    # Try to wrap the base with MySenseHat if the class is importable.
    # If `Class_MySenseHat` is not importable for any reason, fall back to
    # using the raw base SenseHat.
    try:
        from Class_MySenseHat import MySenseHat as _MSH
        sense = _MSH(base=SenseHat())
        _SENSE_IMPL = 'mysensehat_wrapped'
    except Exception:
        sense = SenseHat()
from time import sleep
from datetime import datetime
import webcolors
import inspect

# ===========================================
# globale Variablen
# ===========================================
version = 'Benedikt Ribi (V1.0)'
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
if MySenseHat:
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
    r = received_parameter.get('r') or received_parameter.get('rotation')
    redraw = convert2Boolean(received_parameter.get('redraw'), False)
    r_int = convert2Integer(r, default_value=0, min=0, max=360)
    # store rotation in app config for reference
    app.config['ROTATION'] = r_int
    if redraw:
        try:
            # simple redraw: clear then restore
            sense.clear()
        except Exception:
            pass
    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments}")
    return render_template('index.html', version=version, request_log=request_log)


@app.route('/flip_h', methods=['GET', 'POST'])
def flip_h():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    # flip horizontally the current pixel matrix
    try:
        pixels = sense.get_pixels()
        # ensure list of lists
        flat = [tuple(p) for p in pixels]
        new = [None] * 64
        for y in range(8):
            for x in range(8):
                src_idx = y * 8 + x
                dst_idx = y * 8 + (7 - x)
                new[dst_idx] = flat[src_idx]
        # write back
        for idx, col in enumerate(new):
            px = col
            # compute x,y
            x = idx % 8
            y = idx // 8
            try:
                sense.set_pixel(x, y, px[0], px[1], px[2])
            except Exception:
                # some implementations require different API; ignore
                pass
    except Exception:
        pass
    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments}")
    return render_template('index.html', version=version, request_log=request_log)


@app.route('/flip_v', methods=['GET', 'POST'])
def flip_v():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    try:
        pixels = sense.get_pixels()
        flat = [tuple(p) for p in pixels]
        new = [None] * 64
        for y in range(8):
            for x in range(8):
                src_idx = y * 8 + x
                dst_idx = (7 - y) * 8 + x
                new[dst_idx] = flat[src_idx]
        for idx, col in enumerate(new):
            x = idx % 8
            y = idx // 8
            try:
                sense.set_pixel(x, y, col[0], col[1], col[2])
            except Exception:
                pass
    except Exception:
        pass
    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments}")
    return render_template('index.html', version=version, request_log=request_log)


@app.route('/set_pixels', methods=['GET', 'POST'])
def set_pixels():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    # Accept pixel_list as JSON string or form value
    pixel_list = received_parameter.get('pixel_list')
    parsed = None
    if isinstance(pixel_list, str):
        try:
            import json as _json
            parsed = _json.loads(pixel_list)
        except Exception:
            # try eval fallback
            try:
                parsed = eval(pixel_list)
            except Exception:
                parsed = None
    elif isinstance(pixel_list, list):
        parsed = pixel_list

    if parsed and isinstance(parsed, (list, tuple)):
        # Prefer a bulk set_pixels implementation on the sense object if
        # available (MySenseHat provides it). Fall back to per-pixel writes
        # for compatibility with raw SenseHat/mock implementations.
        try:
            if hasattr(sense, 'set_pixels') and callable(getattr(sense, 'set_pixels')):
                sense.set_pixels(parsed)
            else:
                for i, p in enumerate(parsed[:64]):
                    try:
                        x = i % 8
                        y = i // 8
                        # allow tuple/list or individual ints
                        if isinstance(p, (list, tuple)) and len(p) == 3:
                            sense.set_pixel(x, y, int(p[0]) % 256, int(p[1]) % 256, int(p[2]) % 256)
                        elif isinstance(p, (int, float)):
                            v = int(p) % 256
                            sense.set_pixel(x, y, v, v, v)
                    except Exception:
                        pass
        except Exception:
            # tolerate any error during bulk write
            pass

    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments}")
    return render_template('index.html', version=version, request_log=request_log)


@app.route('/get_pixels', methods=['GET', 'POST'])
def get_pixels():
    try:
        pixels = sense.get_pixels()
        return jsonify({'pixels': pixels}), 200
    except Exception:
        return jsonify({'error': 'could not read pixels'}), 500


@app.route('/set_pixel', methods=['GET', 'POST'])
def set_pixel():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    # Accept integer coordinates but don't clamp here; let the MySenseHat implementation
    # decide how to handle out-of-bounds. This preserves expected behaviour where
    # OOB writes are ignored (no exception) instead of being clamped to the edges.
    x = convert2Integer(received_parameter.get('x'), default_value=None)
    y = convert2Integer(received_parameter.get('y'), default_value=None)
    pixel = received_parameter.get('pixel')
    r = received_parameter.get('r')
    g = received_parameter.get('g')
    b = received_parameter.get('b')
    if pixel and isinstance(pixel, str):
        # parse like (r, g, b) or 'r,g,b'
        try:
            import json as _json
            if pixel.strip().startswith('(') or pixel.strip().startswith('['):
                parsed = eval(pixel)
            elif ',' in pixel:
                parsed = [int(v) for v in pixel.replace('(', '').replace(')', '').split(',')]
            else:
                parsed = None
        except Exception:
            parsed = None
        if parsed and len(parsed) == 3:
            r, g, b = parsed

    if x is None or y is None:
        return jsonify({'error': 'x and y are required and must be integers'}), 400

    # Convert color components
    try:
        r_i = convert2Integer(r, default_value=0, min=0, max=255)
        g_i = convert2Integer(g, default_value=0, min=0, max=255)
        b_i = convert2Integer(b, default_value=0, min=0, max=255)
    except Exception:
        r_i, g_i, b_i = 0, 0, 0

    # If coordinates are out of the 8x8 range, ignore the write but succeed
    if not (0 <= x < 8 and 0 <= y < 8):
        # Do not call sense.set_pixel for out-of-bounds coordinates.
        request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments} (ignored OOB)")
        return render_template('index.html', version=version, request_log=request_log)

    try:
        sense.set_pixel(x, y, r_i, g_i, b_i)
        request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments}")
        return render_template('index.html', version=version, request_log=request_log)
    except Exception:
        return jsonify({'error': 'failed to set pixel'}), 500


@app.route('/get_pixel', methods=['GET', 'POST'])
def get_pixel():
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    # Accept integer coordinates; return error if missing or out-of-range
    x = convert2Integer(received_parameter.get('x'), default_value=None)
    y = convert2Integer(received_parameter.get('y'), default_value=None)
    if x is None or y is None:
        return jsonify({'error': 'x and y are required and must be integers'}), 400
    if not (0 <= x < 8 and 0 <= y < 8):
        return jsonify({'error': 'x and y must be in range 0..7'}), 400
    try:
        pixels = sense.get_pixels()
        px = pixels[y * 8 + x]
        return jsonify({'x': x, 'y': y, 'pixel': px}), 200
    except Exception:
        return jsonify({'error': 'failed to read pixel'}), 500


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
    text = received_parameter.get('text_string') or received_parameter.get('text') or received_parameter.get('s')
    if not text:
        return jsonify({'error': 'text_string or text required'}), 400
    scroll_speed = convert2Float(received_parameter.get('scroll_speed'), default_value=0.1, min=0.0)
    text_colour = convert2RGB(received_parameter.get('text_colour'), (255, 255, 255))
    back_colour = convert2RGB(received_parameter.get('back_colour'), (0, 0, 0))
    try:
        # call SenseHat show_message if available
        try:
            sense.show_message(text, scroll_speed, text_colour, back_colour)
        except TypeError:
            # emulator/mock may not support all params
            sense.show_message(text)
    except Exception:
        pass
    request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments}")
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
    try:
        t = sense.get_temperature()
        return jsonify({'temperature': {'value': t, 'unit': '°C'}}), 200
    except Exception:
        return jsonify({'error': 'sensor unavailable'}), 500


@app.route('/get_pressure')
def get_pressure():
    try:
        p = sense.get_pressure()
        return jsonify({'pressure': {'value': p, 'unit': 'mBar'}}), 200
    except Exception:
        return jsonify({'error': 'sensor unavailable'}), 500


@app.route('/get_humidity')
def get_humidity():
    try:
        h = sense.get_humidity()
        return jsonify({'humidity': {'value': h, 'unit': '%'}}), 200
    except Exception:
        return jsonify({'error': 'sensor unavailable'}), 500


@app.route('/get_meteo_sensor_values')
def get_meteo_sensor_values():
    try:
        t = sense.get_temperature()
        h = sense.get_humidity()
        p = sense.get_pressure()
        return jsonify({'Temperature': {'value': t, 'unit': '°C'}, 'Humidity': {'value': h, 'unit': '%'}, 'Pressure': {'value': p, 'unit': 'mBar'}}), 200
    except Exception:
        return jsonify({'error': 'sensors unavailable'}), 500


@app.route('/get_weather')
def get_weather():
    # Provide a simple HTML snippet showing current readings
    try:
        t = sense.get_temperature()
        h = sense.get_humidity()
        p = sense.get_pressure()
        html = f"<h1>Weather</h1><p>Temperature: {t} °C<br/>Humidity: {h} %<br/>Pressure: {p} mBar</p><a href='/'>Back</a>"
        return html
    except Exception:
        return '<p>Weather data not available</p><a href="/">Back</a>'


@app.route('/')
def index():
    return render_template('index.html', version=version, request_log=request_log)


@app.route('/LED_Matrix_Tester')
def LED_Matrix_Tester():
    return render_template('LED_Matrix_Tester.html')



# ============================
# Enpoints in MySenseHat Class
# ============================


@app.route('/draw_line', methods=['GET', 'POST'])
def draw_line():
    """Draw a line on the 8x8 matrix between (x1,y1) and (x2,y2).
    Parameters accepted (GET/POST/JSON): x1, y1, x2, y2, color, draw_speed
    color may be a name, hex (#rrggbb), or 'r,g,b' string. draw_speed is optional
    and if >0 will insert a small sleep between pixels.
    """
    received_parameter, arguments = get_http_parameter(request, inspect.currentframe().f_code.co_name)
    x1 = convert2Integer(received_parameter.get('x1'), default_value=None)
    y1 = convert2Integer(received_parameter.get('y1'), default_value=None)
    x2 = convert2Integer(received_parameter.get('x2'), default_value=None)
    y2 = convert2Integer(received_parameter.get('y2'), default_value=None)

    # Support alternate parameter names used in the UI/links
    if x1 is None:
        x1 = convert2Integer(received_parameter.get('x_start') or received_parameter.get('x_begin') or received_parameter.get('xstart'), default_value=None)
    if y1 is None:
        y1 = convert2Integer(received_parameter.get('y_start') or received_parameter.get('y_begin') or received_parameter.get('ystart'), default_value=None)
    if x2 is None:
        x2 = convert2Integer(received_parameter.get('x_end') or received_parameter.get('x_finish') or received_parameter.get('xend'), default_value=None)
    if y2 is None:
        y2 = convert2Integer(received_parameter.get('y_end') or received_parameter.get('y_finish') or received_parameter.get('yend'), default_value=None)

    # color: accept combined color string or separate r,g,b parameters
    color = received_parameter.get('color') or received_parameter.get('colour') or received_parameter.get('c')
    if not color:
        # try separate r,g,b
        r = received_parameter.get('r')
        g = received_parameter.get('g')
        b = received_parameter.get('b')
        if r is not None or g is not None or b is not None:
            r_i = convert2Integer(r, default_value=0, min=0, max=255)
            g_i = convert2Integer(g, default_value=0, min=0, max=255)
            b_i = convert2Integer(b, default_value=0, min=0, max=255)
            color = (r_i, g_i, b_i)
    draw_speed = convert2Float(received_parameter.get('draw_speed'), default_value=0.0, min=0.0)

    # validate coords
    if None in (x1, y1, x2, y2):
        return jsonify({'error': 'x1,y1,x2,y2 are required'}), 400

    rgb = convert2RGB(color, default_value=(255, 255, 255))

    # prefer SenseHat/MySenseHat implementation if available
    # Delegate to the sense object's draw_line implementation. We expect
    # the `sense` object to implement draw_line (Class_MySenseHat provides it).
    if hasattr(sense, 'draw_line') and callable(getattr(sense, 'draw_line')):
        try:
            try:
                sense.draw_line(x1, y1, x2, y2, color=rgb, draw_speed=draw_speed)
            except TypeError:
                # some implementations accept different args
                sense.draw_line(x1, y1, x2, y2, rgb)
            request_log.append(f"{datetime.now().strftime('%d-%m-%y %H:%M:%S')}: {arguments}")
            return render_template('index.html', version=version, request_log=request_log)
        except Exception:
            return jsonify({'error': 'draw_line failed on underlying implementation'}), 500

    # If we reach here, the sense object does not implement draw_line.
    return jsonify({'error': 'draw_line not implemented in current SenseHat object'}), 501


if __name__ == '__main__':
    # For Raspberry Pi deployment change host to 0.0.0.0 so the service
    # is reachable from other machines on the network. In production set
    # debug=False. The port can be adjusted as needed (default 5002).
    app.run(debug=False, host='0.0.0.0', port=5002)