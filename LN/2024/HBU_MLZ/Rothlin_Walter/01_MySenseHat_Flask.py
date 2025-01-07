#!/usr/bin/python

# ------------------------------------------------------------------
# Name  : 01_MySenseHat_Flask.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/refs/heads/main/LN/2024/HBU_MLZ/Rothlin_Walter/01_MySenseHat_Flask.py
#
# Description: Sub-Class of SenseHat
#
#
# Autor: Walter Rothlin
#
# History:
# 17-Dec-2024   Walter Rothlin      Initial Version
# 18-Dec-2024   Walter Rothlin      Added show_message(), set_rotation(), show_letter(), low_light()
# 19-Dec-2024   Walter Rothlin      Added clear_LED()
# 07-Jan-2025   Walter Rothlin      Added TestForms for all functions
# ------------------------------------------------------------------
version = "Walter Rothlin V1.0"

from flask import *
from Class_MySenseHat import *



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
    return render_template('test_endpoints_page.html', test_result_string=f'set_pixel({x},{y},{r},{g},{b})!', called_end_point='set_pixel', parameters=all_get_parameters)  

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

@app.route('/clear_LED', methods=['GET'])
def clear_LED():
    all_get_parameters = dict(request.args.items())
    print(all_get_parameters)
    bg_color = all_get_parameters.get('color', 'black')
    if bg_color == 'black':
        sense.clear(MySenseHat.black)
    elif bg_color == 'red':
        sense.clear(MySenseHat.red) 
    elif bg_color == 'blue':
        sense.clear(MySenseHat.blue)
    elif bg_color == 'green':
        sense.clear(MySenseHat.green)
    elif bg_color == 'white':
        sense.clear(MySenseHat.white) 
    elif bg_color == 'grey':
        sense.clear(MySenseHat.grey)
    return render_template('test_endpoints_page.html', test_result_string=f'Clear LED matrix to color {bg_color}!', called_end_point='clear_LED', parameters=all_get_parameters)

@app.route('/show_message', methods=['GET'])
def show_message():
    all_get_parameters = dict(request.args.items())
    print(all_get_parameters)
    text_to_show = all_get_parameters.get('text_string', 'Nothing')
    scroll_speed = float(all_get_parameters.get('scroll_speed', '0.1'))
    sense.show_message(text_to_show, scroll_speed=scroll_speed)
    return render_template('test_endpoints_page.html', test_result_string=f'text_string("{text_to_show}", scroll_speed={scroll_speed})!', called_end_point='show_message', parameters=all_get_parameters)  

@app.route('/show_letter', methods=['GET'])
def show_letter():
    all_get_parameters = dict(request.args.items())
    print(f'show_letter({all_get_parameters})')
    letter_to_show = all_get_parameters.get('s', '?')
    text_colour = eval(all_get_parameters.get('text_colour', '(0,255,0)'))
    back_colour = eval(all_get_parameters.get('back_colour', '(100,100,100)'))
    print(f'show_letter({letter_to_show}, text_colour={text_colour}, back_colour={back_colour})')
    sense.show_letter(letter_to_show, text_colour=text_colour, back_colour=back_colour)  
    return render_template('test_endpoints_page.html', test_result_string=f'show_letter({letter_to_show}, text_colour={text_colour}, back_colour={back_colour})', called_end_point='show_letter', parameters=all_get_parameters)  
    

@app.route('/low_light', methods=['GET'])
def low_light():
    all_get_parameters = dict(request.args.items())
    print(f'(1) low_light({all_get_parameters})')
    low_light_val = all_get_parameters.get('low_light_val', 'False')
    print(f'(2) low_light={low_light_val} (type(low_light_val)={type(low_light_val)})')
    if low_light_val == 'True':
        low_light_val = True
    else:
        low_light_val = False
    print(f'(3) low_light={low_light_val} (type(low_light_val)={type(low_light_val)})')
    sense.low_light=low_light_val
    return render_template('test_endpoints_page.html', test_result_string=f'low_light = {low_light_val}', called_end_point='low_light', parameters=all_get_parameters)  

@app.route('/set_rotation', methods=['GET'])
def set_rotation():
    all_get_parameters = dict(request.args.items())
    print(all_get_parameters)
    r = int(all_get_parameters.get('r', '90'))
    redraw = bool(all_get_parameters.get('redraw', 'True'))
    sense.set_rotation(r=r, redraw=redraw)
    return render_template('test_endpoints_page.html', test_result_string=f'set_rotation({r}, redraw={redraw})!', called_end_point='set_rotation', parameters=all_get_parameters)    

@app.route('/')
def index():
    return render_template('index.html', version=version)

if __name__ == '__main__':
    
    # app.run(debug=True, host='RothlinsPi-2.bzu.ads', port=5001)
    # app.run(debug=True, host='192.168.107.126', port=5001)
    app.run(debug=True, host='192.168.1.137', port=5001)