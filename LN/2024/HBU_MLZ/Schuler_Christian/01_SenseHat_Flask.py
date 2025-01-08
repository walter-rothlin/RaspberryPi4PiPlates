#!/usr/bin/python3

# https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/refs/heads/main/LN/2024/HBU_MLZ/_Vorbereitung/01_SenseHat_Flask.py

from flask import *
from sense_hat import SenseHat
from time import sleep
from Class_MySenseHat import *

red   = (255,   0,   0)
blue  = (  0,   0, 255)
green = (  0, 255,   0)
black = (  0,   0,   0)
white = (255, 255, 255)
grey  = (105, 105, 105)

app = Flask(__name__)
#sense = SenseHat()
sense = MySenseHat()

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
    #return f'set_pixel({x},{y},{r},{g},{b})!'
    return render_template('test_endpoints_page.html', test_result_string=f'set_pixel({x},{y},{r},{g},{b})!')

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
    elif bg_color == 'white':
        sense.clear(white)
    elif bg_color == 'green':
        sense.clear(green)  
    elif bg_color == 'grey':
        sense.clear(grey) 
    #return f'Clear LED matrix to color {bg_color}!'
    return render_template('test_endpoints_page.html', test_result_string=f'Clear LED matrix to color {bg_color}!')

@app.route('/show_message', methods=['GET'])
def show_message():
    all_get_parameters = dict(request.args.items())
    #print(all_get_parameters)
    text = all_get_parameters.get('text_string', 'nix')
    speed = float(all_get_parameters.get('scroll_speed', '1'))
    t_color = eval(all_get_parameters.get('text_colour', '(255,255,255)'))
    b_color = eval(all_get_parameters.get('back_colour', '(255,255,255)'))
    sense.show_message(text_string=text, scroll_speed=speed, text_colour=t_color, back_colour=b_color)
    #return f'show_message()'
    return render_template('test_endpoints_page.html', test_result_string=f'Show Message {text}!')

@app.route('/set_rotation', methods=['GET'])
def set_rotation():
    all_get_parameters = dict(request.args.items())
    #print(all_get_parameters)
    angle = int(all_get_parameters.get('r', '0'))
    re_draw = all_get_parameters.get('redraw', 'True')
    sense.set_rotation(r=angle, redraw=re_draw)
    #return f'set_rotation()'
    return render_template('test_endpoints_page.html', test_result_string=f'Set Rotation to {angle} degree!')

@app.route('/show_letter', methods=['GET'])
def show_letter():
    all_get_parameters = dict(request.args.items())
    #print(all_get_parameters)
    text = all_get_parameters.get('s', '0')
    t_color = eval(all_get_parameters.get('text_colour', '(255,255,255)'))
    b_color = eval(all_get_parameters.get('back_colour', '(255,255,255)'))
    sense.show_letter(text, t_color, b_color)
    #return f'show_letter()'
    return render_template('test_endpoints_page.html', test_result_string=f'Show Letter {text} on SenseHat!')

@app.route('/low_light', methods=['GET'])
def low_light():
    all_get_parameters = dict(request.args.items())
    #print(all_get_parameters)
    bit = all_get_parameters.get('low_light_val', 'True')
    if bit == 'True':
        sense.low_light = True
    else:
        sense.low_light = False
    #return f'low_light()'
    #return render_template('test_endpoints_page.html')
    return render_template('test_endpoints_page.html', test_result_string=f'Low Light is on = {bit}!')

@app.route('/')
def index():
    return render_template('index.html', version='Christian Schuler')

if __name__ == '__main__':
    
    # app.run(debug=True, host='RothlinsPi-2.bzu.ads', port=5001)
    # app.run(debug=True, host='192.168.107.126', port=5001)

    app.run(debug=True, host='127.0.0.1', port=5001)