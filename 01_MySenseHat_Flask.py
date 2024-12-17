#!/usr/bin/python3

from flask import *
from sense_hat import SenseHat
from time import sleep
from Class_senseHat import *

red   = (255,   0,   0)
blue  = (  0,   0, 255)
green = (  0, 255,   0)
black = (  0,   0,   0)

app = Flask(__name__)
sense = MySenseHat()

@app.route('/set_pixel', methods=['GET'])
def set_pixel():
    all_get_parameters = dict(request.args.items())
    print(all_get_parameters)
    x = all_get_parameters.get('x', '0')
    y = all_get_parameters.get('y', '0')
    r = all_get_parameters.get('r', '0')
    g = all_get_parameters.get('g', '0')
    b = all_get_parameters.get('b', '0')
    
    
    sense.set_pixel(x,y,r,g,b)   
    return f'set_pixel({x},{y},{r},{g},{b})!'

@app.route('/get_status', methods=['GET'])
def get_status():
    pixel_status = sense.get_pixels()
    humidity = sense.get_humidity()
    temperature = sense.get_temperature()
    pressure = sense.get_pressure()
    
    # print(pixel_status)
    return {'LED_Matrix': pixel_status,
            'Temperature':   temperature,
            'Humidity': humidity,
            'Pressure': pressure,
           }

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

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    
    app.run(debug=True, host='RothlinsPi-2.bzu.ads', port=5001)
    # app.run(debug=True, host='192.168.107.126', port=5001)