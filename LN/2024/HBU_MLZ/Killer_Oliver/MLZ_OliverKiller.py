#!/usr/bin/python3

from flask import *
from Class_MySenseHat import MySenseHat

red =(255,0,0)
blue = (0,0,255)
green = (0,255,0)
black = (0,0,0)
white = (255,255,255)
grey = (128,128,128)

version = 'Oliver Killer'

app = Flask(__name__)
sense = MySenseHat()

@app.route('/set_pixel', methods = ['GET'])
def set_pixel():
    all_parameters = dict(request.args.items())
    print(all_parameters)
    x = all_parameters.get('x','0')
    y = all_parameters.get('y','0')
    r = all_parameters.get('r','0')
    g = all_parameters.get('g','0')
    b = all_parameters.get('b','0')
    
    sense.set_pixel(x,y,r,g,b)
    return render_template('test_endpoints_page.html', test_result_string=f'Set Pixel:\nX is: {x}\nY is: {y}\nRed is: {r}\nGreen is: {g}\nBlue is: {b}')


@app.route('/get_status', methods =['GET'])
def get_status():
    pixel_status = sense.get_pixels()
    humidity = sense.get_humidity()
    temperature = sense.get_temperature()
    pressure = sense.get_pressure()
    print(pixel_status)
    return {'LED-Matrix': pixel_status,
            'Humditity' : humidity,
            'Temperature': temperature,
            'Pressure': pressure,}

@app.route('/clear_LED', methods = ['GET','POST'])
def clear_LED():
    if request.method == 'POST':
        all_parameters = dict(request.form.items())
    else:
        all_parameters = dict(request.args.items())
    print(all_parameters)
    bg_color = all_parameters.get('color',' black')
    if bg_color == 'black':
        sense.clear()
    elif bg_color == 'red':
        sense.clear(red)
    elif bg_color == 'blue':
        sense.clear(blue)
    elif bg_color == 'green':
        sense.clear(green)
    elif bg_color == 'white':
        sense.clear(white)
    elif bg_color == 'grey':
        sense.clear(grey)
    return render_template('test_endpoints_page.html', test_result_string=f'Clear LED matrix to color {bg_color}!', colors =['red', 'blue', 'green','black','white','grey'])

@app.route('/set_rotation', methods = ['GET','POST'])
def set_rotation():
    if request.method == 'POST':
        all_parameters = dict(request.form.items())
    else:
        all_parameters = dict(request.args.items())
    r = all_parameters.get('r','0')
    red = all_parameters.get('redraw', 'True')
    sense.set_rotation(int(r), redraw = red)
    return render_template('test_endpoints_page.html', test_result_string=f'Set rotation to {r}!')

@app.route('/show_message', methods = ['GET'])
def show_message():
    all_parameters = dict(request.args.items())
    text = all_parameters.get('text_string','Hello World')
    scroll = all_parameters.get('scroll_speed', '0')
    t_colour = all_parameters.get('text_colour','255,255,255')
    b_colour = all_parameters.get('back_colour', '0,0,0')
    sense.show_message(text_string = text, scroll_speed=scroll, text_colour= t_colour, back_colour=b_colour)
    return render_template('test_endpoints_page.html', test_result_string=f'Show Message:\nText is: {text}\nScroll Speed is: {scroll}\nText Colour is: {t_colour}\nBackground Colour is: {b_colour}')

@app.route('/show_letter',methods = ['GET'])
def show_letter():
    all_parameters = dict(request.args.items())
    text = all_parameters.get('s','a')
    t_colour_string = all_parameters.get('text_colour','255,255,255')
    b_colour_string = all_parameters.get('back_colour', '0,0,0')
    sense.show_letter(s = text, text_colour= t_colour_string, back_colour= b_colour_string)
    return render_template('test_endpoints_page.html', test_result_string=f'Show Letter:\nText is: {text}\nText Colour is: {t_colour_string}\nBackground Colour is: {b_colour_string}')

@app.route('/low_light', methods = ['GET'])
def low_light():
    all_parameters = dict(request.args.items())
    boolean = all_parameters.get('low_light_val','False')
    sense.low_light = boolean
    return render_template('test_endpoints_page.html', test_result_string=f'Low Light is {boolean}!')

@app.route('/')
def index():
    return render_template('index.html', version = version)
    
    
# =========================================================
if __name__ == '__main__':
    # app.run(debug=True, host='192.168.180.35', port=5001)
    app.run(debug=True, host='127.0.0.1', port=5001)