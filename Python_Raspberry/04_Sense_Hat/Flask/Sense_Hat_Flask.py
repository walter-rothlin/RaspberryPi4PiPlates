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
# 01-Jul-2025   Walter Rothlin     Initial Version
# 04-Oct-2025  Walter Rothlin      Prepared for HBU MLZ 2025
# ------------------------------------------------------------------

from flask import *
from sense_hat import SenseHat
from time import sleep

red   = (255,   0,   0)
blue  = (  0,   0, 255)
green = (  0, 255,   0)
black = (  0,   0,   0)


app = Flask(__name__)
sense = SenseHat()
## sense = MySenseHat()

@app.route('/clear_LED', methods=['GET'])
def clear_LED():
    all_get_parameters = dict(request.args.items())
    # print(all_get_parameters)
    bg_color = all_get_parameters.get('color', 'black')
    if bg_color == 'black':
        sense.clear()
    elif bg_color == 'red':
        sense.clear(red) 
    elif bg_color == 'blue':
        sense.clear(blue)
    elif bg_color == 'green':
        sense.clear(green)   
    return f'Clear LED matrix to color {bg_color}!'
    
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

@app.route('/set_pixel', methods=['GET'])
def set_pixel():
    all_get_parameters = dict(request.args.items())
    print(all_get_parameters)
    x = int(all_get_parameters.get('x', '0'))
    y = int(all_get_parameters.get('y', '0'))
    r = int(all_get_parameters.get('r', '0'))
    g = int(all_get_parameters.get('g', '0'))
    b = int(all_get_parameters.get('b', '0'))
    
    
    sense.set_pixel(x,y,r,g,b)   
    return f'set_pixel({x},{y},{r},{g},{b})!'


@app.route('/wetter_json')
def get_weather_as_JSON():
    weather_data = {
    'Temperatur':sense.get_temperature(),
    'Luftdruck':sense.get_pressure(),
    'Feuchtigkeit':sense.get_humidity(),
    }
    return weather_data
    

@app.route('/weather')
def get_weather():
    return f'''
    <h1>Wetter</h1>
    Temperatur: {sense.get_temperature():0.2f}°C<br/>
    Luftdruck: {sense.get_pressure():0.2f}mBar<br/>
    Rel. Feuchtigkeit: {sense.get_humidity():0.2f}%<br/>
    '''
    
    
@app.route('/')
def show_index():
    return f'''
    <h1>INDEX for {say_hello()}</h1>
    <ul>
        <li><a href="/weather">Wetter</a> (as HTML)</li>
        <li><a href="/wetter_json">Wetter</a> (as JSON)</li>
        <li><a href="/get_status">SenseHat Status</a></li>
    </ul>
    <ul>
        <li><a href="/clear_LED?color=black">Clear-LED</a> (color=black)</li>
        <li><a href="/set_pixel?x=0&y=0&r=255&g=0&b=0">Set-Pixel</a> (x=0, y=0, r=255, g=0, b=0)</li>


    </ul>
    '''
    
@app.route('/inde_template')
def index():
    return render_template('index.html')
    
    
@app.route('/hello')    
def say_hello():
    return 'BZU V1.0'
    

if __name__ == '__main__':
    app.run(debug=True, host='192.168.107.97', port=5001)