#!/usr/bin/python3
# Minimal Flask-App mit MySenseHat

from flask import Flask, request, render_template
from Class_MySenseHat import MySenseHat

app = Flask(__name__)
version = "Manuel Arn V01"

sense = MySenseHat()

@app.route('/')
def index():
    return render_template('index.html', version=version)

@app.route('/test_endpoints_page')
def test_endpoints_page():
    return render_template('test_endpoints_page.html', test_result_string="")

@app.route('/clear_LED')
def clear_LED():
    color_map = {
        'black': (0, 0, 0),
        'red':   (255, 0, 0),
        'green': (0, 255, 0),
        'blue':  (0, 0, 255),
        'white': (255, 255, 255),
        'grey':  (127, 127, 127)
    }
    color = request.args.get('color', 'black')
    if color in color_map:
        sense.clear(color_map[color])
        msg = f"Clear LED zu {color}!"
    else:
        sense.clear((0,0,0))
        msg = f"Farbe '{color}' unbekannt, verwende black."
    return render_template('test_endpoints_page.html', test_result_string=msg)

@app.route('/set_pixel')
def set_pixel():
    x = request.args.get('x', '0')
    y = request.args.get('y', '0')
    r = request.args.get('r', '0')
    g = request.args.get('g', '0')
    b = request.args.get('b', '0')

    try:
        sense.set_pixel_Djordje(x, y, int(r), int(g), int(b))
        msg = f"set_pixel_Djordje({x},{y},{r},{g},{b}) OK!"
    except Exception as e:
        msg = f"Fehler: {str(e)}"

    return render_template('test_endpoints_page.html', test_result_string=msg)


@app.route('/show_message')
def show_message():
    txt  = request.args.get('text_string', 'Hello SenseHat')
    spd  = float(request.args.get('scroll_speed', '0.1'))
    fg_s = request.args.get('text_colour', '255,255,255')
    bg_s = request.args.get('back_colour', '0,0,0')
    try:
        fg = tuple(int(c) for c in fg_s.split(','))
        bg = tuple(int(c) for c in bg_s.split(','))
        sense.show_message(txt, scroll_speed=spd, text_colour=fg, back_colour=bg)
        msg = f"show_message('{txt}', speed={spd}, fg={fg}, bg={bg}) OK!"
    except Exception as e:
        msg = f"Fehler in show_message: {e}"
    return render_template('test_endpoints_page.html', test_result_string=msg)

@app.route('/get_status')
def get_status():
    st = sense.get_status()
    msg = (f"Status: Temp={st['Temperature']:.1f}°C, "
           f"Humidity={st['Humidity']:.1f}%, "
           f"Pressure={st['Pressure']:.1f}hPa")
    return render_template('test_endpoints_page.html', test_result_string=msg)

@app.route('/set_rotation')
def set_rotation():
    r = request.args.get('r', '0')
    redraw_str = request.args.get('redraw', 'False').lower()
    redraw = (redraw_str == 'true')
    try:
        sense.set_rotation(int(r))
        if redraw:
            pass
        msg = f"Set rotation zu {r}, redraw={redraw}"
    except Exception as e:
        msg = f"Fehler in set_rotation: {e}"
    return render_template('test_endpoints_page.html', test_result_string=msg)

@app.route('/show_letter')
def show_letter():
    s = request.args.get('s', '?')
    fg_s = request.args.get('text_colour', '(255,255,255)').strip("() ")
    bg_s = request.args.get('back_colour', '(0,0,0)').strip("() ")
    try:
        fg = tuple(int(c) for c in fg_s.split(','))
        bg = tuple(int(c) for c in bg_s.split(','))
        sense.show_letter(s, text_colour=fg, back_colour=bg)
        msg = f"show_letter('{s}', fg={fg}, bg={bg}) OK!"
    except Exception as e:
        msg = f"Fehler in show_letter: {e}"
    return render_template('test_endpoints_page.html', test_result_string=msg)

@app.route('/low_light')
def low_light():
    val_str = request.args.get('low_light_val', 'False').lower()
    val_bool = (val_str == 'true')
    try:
        sense.low_light = val_bool
        msg = f"Set low_light zu {val_bool}!"
    except Exception as e:
        msg = f"Fehler in low_light: {e}"
    return render_template('test_endpoints_page.html', test_result_string=msg)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)
