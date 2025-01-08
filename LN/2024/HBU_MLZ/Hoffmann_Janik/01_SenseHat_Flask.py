#!/usr/bin/python3

# https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/refs/heads/main/LN/2024/HBU_MLZ/_Vorbereitung/01_SenseHat_Flask.py

from flask import *
from Class_SenseHat import MySenseHat
from time import sleep


red   = (255,   0,   0)
blue  = (  0,   0, 255)
green = (  0, 255,   0)
black = (  0,   0,   0)

# Definieren Sie im Flask-Programm noch folgende Variable version='Ihr Voname Nachname' ein und übergeben dies der render_template('index.html)
version = 'Janik Hoffmann'

app = Flask(__name__)
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
    return render_template('test_endpoints_page.html', test_result_string=f'Clear LED matrix to color {bg_color}!')

# Endpoint show_message()
@app.route('/show_message', methods=['GET'])
def show_message():
    all_get_parameters = dict(request.args.items())
    text_message = all_get_parameters.get('text_string', 'Hello')
    scroll_speed = float(all_get_parameters.get('scroll_speed', 0.1))
    text_colour = all_get_parameters.get('text_colour', '(255,255,255)')
    text_colour_tupel = tuple(map(int, text_colour.strip('()').split(',')))
    back_colour = all_get_parameters.get('back_colour', '(0,0,0)')
    back_colour_tupel = tuple(map(int, back_colour.strip('()').split(',')))

    #sense.show_message(text_message, text_colour=text_colour_tupel, back_colour=back_colour_tupel, speed=scroll_speed)

    #Testausgabe
    result_string = f'sense.show_message("{text_message}", text_colour={text_colour_tupel}, back_colour={back_colour_tupel}, speed={scroll_speed})'

    return render_template('test_endpoints_page.html', test_result_string=f'Show Message: {result_string}')

#    return f'''Testausgabe:<br>
#        Message: {text_message}<br>
#        Speed:  {scroll_speed}<br>
#        Text colour: {text_colour}<br>
#        Back colour: {back_colour}<br>
#    '''


# Endpoint set_rotation()  set_rotation?r=0&redraw=True
@app.route('/set_rotation', methods=['GET'])
def set_rotation():
    all_get_parameters = dict(request.args.items())
    rotation_degree = int(all_get_parameters.get('r', 0))
    redraw_text = all_get_parameters.get('redraw', True)
    redraw = True
    if redraw_text == 'False':
        redraw = False
    
    #sense.set_rotation(rotation_degree)
    #Testausgabe
    result_string = f'sense.set_rotation({rotation_degree})'
    
    return render_template('test_endpoints_page.html', test_result_string=f'Rotate: {result_string}')



# Endpoint show_letter()   show_letter?s=?&text_colour=(0,255,0)&back_colour=(100,100,100)
@app.route('/show_letter', methods=['GET'])
def show_letter():
    all_get_parameters = dict(request.args.items())
    letter = all_get_parameters.get('s', ' ')
    text_colour = all_get_parameters.get('text_colour', '(255,255,255)')
    text_colour_tupel = tuple(map(int, text_colour.strip('()').split(',')))
    back_colour = all_get_parameters.get('back_colour', '(0,0,0)')
    back_colour_tupel = tuple(map(int, back_colour.strip('()').split(',')))

    #sense.show_letter(letter, text_colour=text_colour_tupel, back_colour=back_colour_tupel)

    #Testausgabe
    result_string = f'sense.show_letter("{letter}", text_colour={text_colour_tupel}, back_colour={back_colour_tupel})'

    return render_template('test_endpoints_page.html', test_result_string=f'Show Message: {result_string}')


#    return f'''Testausgabe:<br>
#        Leter: {letter}<br>
#        Text colour: {text_colour}<br>
#        Back colour: {back_colour}<br>
#    '''



# Endpoint low_light()   low_light?low_light_val=True
@app.route('/low_light', methods=['GET'])
def low_light():
    all_get_parameters = dict(request.args.items())
    low_light_value_text = all_get_parameters.get('low_light_val', 'True')
    low_light_value_bool = True
    if (low_light_value_text == 'False'):
        low_light_value_bool = False
    result_string = f'Testausgabe:<br>\nLow Light Value: {low_light_value_bool}<br>\n'
    return render_template('test_endpoints_page.html', test_result_string=f'{result_string}')


@app.route('/')
def index():
    return render_template('index.html', version=version)

# Test endpoints
@app.route('/test')
def test():
    result_string = 'Test erfolgreich!'
    return render_template('test_endpoints_page.html', test_result_string=f'Clear LED matrix to color {result_string}!')


if __name__ == '__main__':
    
    # app.run(debug=True, host='RothlinsPi-2.bzu.ads', port=5001)
    # app.run(debug=True, host='192.168.107.126', port=5001)

    # app.run(debug=True, host='192.168.1.137', port=5001)
    # Test Lokal (html anzeigen)
    app.run(debug=True, host='127.0.0.1', port=5001)