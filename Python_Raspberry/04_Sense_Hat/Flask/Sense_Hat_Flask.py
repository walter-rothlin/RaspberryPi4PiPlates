#!/usr/bin/python3

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
# ------------------------------------------------------------------

from flask import *
from sense_hat import SenseHat
from time import sleep
import webcolors

red = (255, 0, 0)
blue = (0, 0, 255)
green = (0, 255, 0)
black = (0, 0, 0)

app = Flask(__name__)
version = 'Walter Rothlin V1.0'

sense = SenseHat()


## sense = MySenseHat()


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


@app.route('/clear_LED', methods=['GET', 'POST'])
def clear_LED():
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


@app.route('/set_pixel', methods=['GET'])
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


@app.route('/wetter_json')
def get_weather_as_JSON():
    weather_data = {
        'Temperatur': sense.get_temperature(),
        'Luftdruck': sense.get_pressure(),
        'Feuchtigkeit': sense.get_humidity(),
    }
    return weather_data


@app.route('/weather')
def get_weather():
    return f'''
    <h1>Wetter</h1>
    Temperatur: {sense.get_temperature():0.2f}°C<br/>
    Luftdruck: {sense.get_pressure():0.2f}mBar<br/>
    Rel. Feuchtigkeit: {sense.get_humidity():0.2f}%<br/>

    <br/><br/><a href="/">Back</a>'
    '''


@app.route('/')
def index():
    return render_template('index.html', version=version)


@app.route('/LED_Matrix_Tester')
def LED_Matrix_Tester():
    return render_template('LED_Matrix_Tester.html')


if __name__ == '__main__':
    # app.run(debug=True, host='RothlinsPi-2.bzu.ads', port=5002)
    app.run(debug=True, host='192.168.1.170', port=5002)

    # app.run(debug=True, host='127.0.0.1', port=5002)