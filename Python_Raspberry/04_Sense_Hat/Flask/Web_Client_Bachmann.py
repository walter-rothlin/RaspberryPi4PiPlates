#!/usr/bin/env python3

#*************************
#   Tim Bachmann, BFSU
#   01.07.2025
#   Programm zur auswahl von Temperatur, Luftdruck, Luftfeuchtigkeit, LED-Ansteuern
#   08.07.2025
#   Erweiterung des Programm mit Schönsheitsanpassungen
#*************************



from flask import Flask, render_template_string, request
from sense_hat import SenseHat

app = Flask(__name__)
sense = SenseHat()

@app.route('/')
def index():
    html = '''
    <!DOCTYPE html>
    <html>
    <head>
        <title>Sense HAT Wetter-API Menü</title>
        <style>
            body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }
            .btn {
                display: inline-block; margin: 10px; padding: 15px 30px;
                font-size: 18px; background: #4CAF50; color: white;
                text-decoration: none; border-radius: 6px;
            }
            .btn:hover { background: #4CAF50; }
        </style>
    </head>
    <body>
        <h1>Sense HAT Wetter-API Menü</h1>
        <a href="/temperature" class="btn">Temperatur</a>
        <a href="/humidity" class="btn">Luftfeuchtigkeit</a>
        <a href="/pressure" class="btn">Luftdruck</a>
        <a href="/led_control" class="btn" style="background:#4CAF50;">LED steuern</a>
    </body>
    </html>
    '''
    return render_template_string(html)

@app.route('/temperature')
def temperature():
    temp = sense.get_temperature()
    html = f'''
    <!DOCTYPE html>
    <html>
    <head>
        <title>Temperatur</title>
        <style>
            body {{ font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }}
            .value {{ font-size: 2.5em; color: #3498db; margin: 30px 0; }}
            .btn {{
                display: inline-block; margin: 10px; padding: 12px 28px;
                font-size: 18px; background: #4CAF50; color: white;
                text-decoration: none; border-radius: 6px;
            }}
            .btn:hover {{ background: #217dbb; }}
        </style>
    </head>
    <body>
        <h1>Temperatur</h1>
        <div class="value">{round(temp, 1)} °C</div>
        <a href="/" class="btn">Zurück zur Startseite</a>
    </body>
    </html>
    '''
    return html

@app.route('/humidity')
def humidity():
    hum = sense.get_humidity()
    html = f'''
    <!DOCTYPE html>
    <html>
    <head>
        <title>Luftfeuchtigkeit</title>
        <style>
            body {{ font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }}
            .value {{ font-size: 2.5em; color: #3498db; margin: 30px 0; }}
            .btn {{
                display: inline-block; margin: 10px; padding: 12px 28px;
                font-size: 18px; background: #4CAF50; color: white;
                text-decoration: none; border-radius: 6px;
            }}
            .btn:hover {{ background: #388e3c; }}
        </style>
    </head>
    <body>
        <h1>Luftfeuchtigkeit</h1>
        <div class="value">{round(hum, 1)} %</div>
        <a href="/" class="btn">Zurück zur Startseite</a>
    </body>
    </html>
    '''
    return html

@app.route('/pressure')
def pressure():
    pressure = sense.get_pressure()
    html = f'''
    <!DOCTYPE html>
    <html>
    <head>
        <title>Luftdruck</title>
        <style>
            body {{ font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }}
            .value {{ font-size: 2.5em; color: #3498db; margin: 30px 0; }}
            .btn {{
                display: inline-block; margin: 10px; padding: 12px 28px;
                font-size: 18px; background: #4CAF50; color: white;
                text-decoration: none; border-radius: 6px;
            }}
            .btn:hover {{ background: #388e3c; }}
        </style>
    </head>
    <body>
        <h1>Luftdruck</h1>
        <div class="value">{round(pressure, 1)} hPa</div>
        <a href="/" class="btn">Zurück zur Startseite</a>
    </body>
    </html>
    '''
    return html

@app.route('/led_control', methods=['GET', 'POST'])
def led_control():
    message = ""
    default = {'x': 3, 'y': 3, 'r': 255, 'g': 0, 'b': 0, 'text': '', 'scroll_speed': 0.1, 'bg_r': 0, 'bg_g': 0, 'bg_b': 0}
    if request.method == 'POST':
        try:
            x = int(request.form.get('x', default['x']))
            y = int(request.form.get('y', default['y']))
            r = int(request.form.get('r', default['r']))
            g = int(request.form.get('g', default['g']))
            b = int(request.form.get('b', default['b']))
            text = request.form.get('text', '').strip()
            scroll_speed = float(request.form.get('scroll_speed', default['scroll_speed']))
            bg_r = int(request.form.get('bg_r', default['bg_r']))
            bg_g = int(request.form.get('bg_g', default['bg_g']))
            bg_b = int(request.form.get('bg_b', default['bg_b']))
            x = max(0, min(7, x))
            y = max(0, min(7, y))
            r = max(0, min(255, r))
            g = max(0, min(255, g))
            b = max(0, min(255, b))
            bg_r = max(0, min(255, bg_r))
            bg_g = max(0, min(255, bg_g))
            bg_b = max(0, min(255, bg_b))
            scroll_speed = max(0.01, min(1.0, scroll_speed))
            sense.clear()
            sense.set_pixel(x, y, [r, g, b])
            message = f"LED an Position ({x}, {y}) wurde auf Farbe ({r}, {g}, {b}) gesetzt."
            if text:
                sense.show_message(
                    text,
                    scroll_speed=scroll_speed,
                    text_colour=[r, g, b],
                    back_colour=[bg_r, bg_g, bg_b]
                )
                message += f' Text "{text}" wurde angezeigt (Geschwindigkeit: {scroll_speed}, Hintergrundfarbe: [{bg_r},{bg_g},{bg_b}]).'
        except Exception as e:
            message = f"Fehler: {e}"
    html = f'''
    <!DOCTYPE html>
    <html>
    <head>
        <title>LED steuern</title>
        <style>
            body {{ font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }}
            form {{ margin: 30px auto; display: inline-block; text-align: left; }}
            label {{ display: block; margin-top: 10px; font-size: 1.1em; }}
            input[type="number"], input[type="text"] {{ width: 120px; font-size: 1em; }}
            .btn {{
                display: inline-block; margin: 20px 0 0 0; padding: 12px 28px;
                font-size: 18px; background: #4CAF50; color: white;
                text-decoration: none; border-radius: 6px; border: none;
                cursor: pointer;
            }}
            .btn:hover {{ background: #d35400; }}
            .back-btn {{
                display: inline-block; margin: 20px 0 0 0; padding: 10px 24px;
                font-size: 16px; background: #4CAF50; color: white;
                text-decoration: none; border-radius: 6px;
            }}
            .msg {{ color: #2d3436; font-size: 1.2em; margin-bottom: 20px; }}
        </style>
    </head>
    <body>
        <h1>LED auf dem Sense HAT steuern</h1>
        <div class="msg">{message}</div>
        <form method="post">
            <label>X-Position (0-7): <input type="number" name="x" min="0" max="7" value="{default['x']}"></label>
            <label>Y-Position (0-7): <input type="number" name="y" min="0" max="7" value="{default['y']}"></label>
            <label>Rot (0-255): <input type="number" name="r" min="0" max="255" value="{default['r']}"></label>
            <label>Grün (0-255): <input type="number" name="g" min="0" max="255" value="{default['g']}"></label>
            <label>Blau (0-255): <input type="number" name="b" min="0" max="255" value="{default['b']}"></label>
            <label>Text anzeigen: <input type="text" name="text" maxlength="32" placeholder="Optional"></label>
            <label>Scroll-Geschwindigkeit (0.01-1.0, kleiner = schneller): <input type="number" step="0.01" name="scroll_speed" min="0.01" max="1.0" value="{default['scroll_speed']}"></label>
            <label>Hintergrundfarbe Rot (0-255): <input type="number" name="bg_r" min="0" max="255" value="{default['bg_r']}"></label>
            <label>Hintergrundfarbe Grün (0-255): <input type="number" name="bg_g" min="0" max="255" value="{default['bg_g']}"></label>
            <label>Hintergrundfarbe Blau (0-255): <input type="number" name="bg_b" min="0" max="255" value="{default['bg_b']}"></label>
            <button type="submit" class="btn">LED & Text setzen</button>
        </form>
        <br>
        <a href="/" class="back-btn">Zurück zur Startseite</a>
    </body>
    </html>
    '''
    return html

if __name__ == '__main__':
    app.run(debug=True, host='192.168.107.198', port=5001) 
