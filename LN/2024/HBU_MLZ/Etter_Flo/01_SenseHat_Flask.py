#!/usr/bin/python3

# https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/refs/heads/main/LN/2024/HBU_MLZ/_Vorbereitung/01_SenseHat_Flask.py

from flask import *
from sense_hat import SenseHat
from time import sleep


red   = (255,   0,   0)
blue  = (  0,   0, 255)
green = (  0, 255,   0)
white = (255, 255, 255)
black = (  0,   0,   0)
gray  = (128, 128, 128)


app = Flask(__name__)
sense = SenseHat()

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
    # elif bg_color == 'red':
        # sense.clear(red) 
    # elif bg_color == 'blue':
        # sense.clear(blue)
    # elif bg_color == 'green':
        # sense.clear(green) 
    # elif bg_color == 'white':
        # sense.clear(white) 
    # elif bg_color == 'gray':
        # sense.clear(gray) 
        
    return f'Clear LED matrix to color {bg_color}!'

@app.route('/')
def index():
    return render_template('index.html')
#new
@app.route('/show_message', methods=['GET'])
def show_message():
    text_string = request.args.get('text_string', 'Hello')
    scroll_speed = float(request.args.get('scroll_speed', '0.1'))
    text_colour = tuple(map(int, request.args.get('text_colour', '255,255,255').split(',')))
    back_colour = tuple(map(int, request.args.get('back_colour', '0,0,0').split(',')))
    
    sense.show_message(text_string, scroll_speed=scroll_speed, text_colour=text_colour, back_colour=back_colour)
    return f"Message '{text_string}' displayed!"


@app.route('/set_rotation', methods=['GET'])
def set_rotation():
    rotation = int(request.args.get('r', 0))
    redraw = request.args.get('redraw', 'True').lower() == 'true'
    
    sense.set_rotation(rotation, redraw)
    return f"Rotation set to {rotation} degrees!"
@app.route('/show_letter', methods=['GET'])
def show_letter():
    letter = request.args.get('s', '?')
    text_colour = tuple(map(int, request.args.get('text_colour', '255,255,255').strip('()').split(',')))
    back_colour = tuple(map(int, request.args.get('back_colour', '0,0,0').strip('()').split(',')))
    
    sense.show_letter(letter, text_colour=text_colour, back_colour=back_colour)
    return f"Letter '{letter}' displayed!"
@app.route('/low_light', methods=['GET'])
def low_light():
    low_light_val = request.args.get('low_light_val', 'false').lower() == 'true'
    sense.low_light = low_light_val
    return f"Low light mode set to {low_light_val}!"

if __name__ == '__main__':
    
    # app.run(debug=True, host='RothlinsPi-2.bzu.ads', port=5001)
    # app.run(debug=True, host='192.168.107.126', port=5001)

    app.run(debug=True, host='192.168.0.94', port=5001)

