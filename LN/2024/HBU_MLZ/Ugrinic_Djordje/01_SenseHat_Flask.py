#!/usr/bin/python3

from flask import Flask, render_template, request
from sense_hat import SenseHat

# Farbdefinitionen
red = (255, 0, 0)
green = (0, 255, 0)
blue = (0, 0, 255)
black = (0, 0, 0)
white = (255, 255, 255)
grey = (128, 128, 128)

# Flask-App initialisieren
app = Flask(__name__)
sense = SenseHat()

# Versions-Variable
version = 'Djordje Ugrinic'

@app.route('/')
def index():
    """Hauptseite mit Version."""
    return render_template('index.html', version=version)

@app.route('/clear_LED', methods=['GET'])
def clear_LED():
    """LED-Matrix mit einer bestimmten Farbe leeren."""
    color = request.args.get('color', 'black')
    if color == 'red':
        sense.clear(red)
    elif color == 'green':
        sense.clear(green)
    elif color == 'blue':
        sense.clear(blue)
    elif color == 'white':
        sense.clear(white)
    elif color == 'grey':
        sense.clear(grey)
    else:
        sense.clear(black)
    return render_template('test_endpoints_page.html', result_string=f'LED matrix cleared to {color}')

@app.route('/set_pixel', methods=['GET'])
def set_pixel():
    """Einzelnes Pixel setzen."""
    x = int(request.args.get('x', 0))
    y = int(request.args.get('y', 0))
    r = int(request.args.get('r', 0))
    g = int(request.args.get('g', 0))
    b = int(request.args.get('b', 0))
    sense.set_pixel(x, y, r, g, b)
    return render_template('test_endpoints_page.html', result_string=f'set_pixel({x}, {y}, {r}, {g}, {b}) executed.')

@app.route('/show_message', methods=['GET'])
def show_message():
    """Scrollende Nachricht anzeigen."""
    text_string = request.args.get('text_string', 'Hello!')
    scroll_speed = float(request.args.get('scroll_speed', 0.1))
    text_colour = tuple(map(int, request.args.get('text_colour', '255,255,255').split(',')))
    back_colour = tuple(map(int, request.args.get('back_colour', '0,0,0').split(',')))
    sense.show_message(text_string, scroll_speed=scroll_speed, text_colour=text_colour, back_colour=back_colour)
    return render_template('test_endpoints_page.html', result_string=f'Scrolling message "{text_string}" displayed.')

@app.route('/set_rotation', methods=['GET'])
def set_rotation():
    """LED-Matrix-Rotation einstellen."""
    rotation = int(request.args.get('r', 0))
    redraw = request.args.get('redraw', 'false').lower() == 'true'
    sense.set_rotation(rotation, redraw=redraw)
    return render_template('test_endpoints_page.html', result_string=f'Rotation set to {rotation} degrees.')

@app.route('/show_letter', methods=['GET'])
def show_letter():
    """Einzelnen Buchstaben anzeigen."""
    letter = request.args.get('s', '?')
    text_colour = tuple(map(int, request.args.get('text_colour', '255,255,255').split(',')))
    back_colour = tuple(map(int, request.args.get('back_colour', '0,0,0').split(',')))
    sense.show_letter(letter, text_colour=text_colour, back_colour=back_colour)
    return render_template('test_endpoints_page.html', result_string=f'Showing letter "{letter}" on LED matrix.')

@app.route('/low_light', methods=['GET'])
def low_light():
    """Low-Light-Modus ein- oder ausschalten."""
    low_light_val = request.args.get('low_light_val', 'false').lower() == 'true'
    sense.low_light = low_light_val
    return render_template('test_endpoints_page.html', result_string=f'Low light mode set to {low_light_val}.')

@app.route('/test_endpoints_page', methods=['GET'])
def test_endpoints_page():
    """Seite für das Testen der Endpoints."""
    return render_template('test_endpoints_page.html', result_string='')

if __name__ == '__main__':
    app.run(debug=True, host='192.168.0.29', port=5001)
