#!/usr/bin/python3

from flask import Flask, render_template, request
from time import sleep

class MySenseHat:
    def __init__(self):
        self.low_light = False
        self.rotation = 0
        self.matrix = [[(0, 0, 0)] * 8 for _ in range(8)]

    def set_pixel(self, x, y, r, g, b):
        if 0 <= x < 8 and 0 <= y < 8:
            self.matrix[y][x] = (r, g, b)
        else:
            raise ValueError("Pixel position out of range")

    def clear(self, color=(0, 0, 0)):
        self.matrix = [[color] * 8 for _ in range(8)]

    def show_message(self, text, scroll_speed=0.1, text_colour=(255, 255, 255), back_colour=(0, 0, 0)):
        print(f"Displaying message: {text}")

    def set_rotation(self, rotation, redraw=True):
        self.rotation = rotation

    def show_letter(self, letter, text_colour=(255, 255, 255), back_colour=(0, 0, 0)):
        print(f"Displaying letter: {letter}")

sense = MySenseHat()

app = Flask(__name__)
version = 'Ihr Vorname Nachname'

@app.route('/')
def index():
    return render_template('index.html', version=version)

@app.route('/clear_LED', methods=['GET'])
def clear_LED():
    color = request.args.get('color', 'black')
    color_map = {'red': (255, 0, 0), 'green': (0, 255, 0), 'blue': (0, 0, 255), 
                 'white': (255, 255, 255), 'gray': (128, 128, 128), 'black': (0, 0, 0)}
    sense.clear(color_map.get(color, (0, 0, 0)))
    return render_template('test_endpoints_page.html', test_result_string=f'Clear LED matrix to color {color}!')

@app.route('/set_pixel', methods=['GET'])
def set_pixel():
    x = int(request.args.get('x', 0))
    y = int(request.args.get('y', 0))
    r = int(request.args.get('r', 0))
    g = int(request.args.get('g', 0))
    b = int(request.args.get('b', 0))
    try:
        sense.set_pixel(x, y, r, g, b)
        result = f"Pixel set at ({x},{y}) to color ({r},{g},{b})"
    except ValueError as e:
        result = str(e)
    return render_template('test_endpoints_page.html', test_result_string=result)

@app.route('/show_message', methods=['GET'])
def show_message():
    text = request.args.get('text_string', 'Hello')
    scroll_speed = float(request.args.get('scroll_speed', 0.1))
    text_colour = tuple(map(int, request.args.get('text_colour', '255,255,255').split(',')))
    back_colour = tuple(map(int, request.args.get('back_colour', '0,0,0').split(',')))
    sense.show_message(text, scroll_speed=scroll_speed, text_colour=text_colour, back_colour=back_colour)
    return render_template('test_endpoints_page.html', test_result_string=f"Message '{text}' displayed!")

@app.route('/set_rotation', methods=['GET'])
def set_rotation():
    rotation = int(request.args.get('r', 0))
    sense.set_rotation(rotation)
    return render_template('test_endpoints_page.html', test_result_string=f"Rotation set to {rotation} degrees!")

@app.route('/show_letter', methods=['GET'])
def show_letter():
    letter = request.args.get('s', '?')
    text_colour = tuple(map(int, request.args.get('text_colour', '255,255,255').split(',')))
    back_colour = tuple(map(int, request.args.get('back_colour', '0,0,0').split(',')))
    sense.show_letter(letter, text_colour=text_colour, back_colour=back_colour)
    return render_template('test_endpoints_page.html', test_result_string=f"Letter '{letter}' displayed!")

@app.route('/low_light', methods=['GET'])
def low_light():
    low_light_val = request.args.get('low_light_val', 'false').lower() == 'true'
    sense.low_light = low_light_val
    return render_template('test_endpoints_page.html', test_result_string=f"Low light mode set to {low_light_val}!")

if __name__ == '__main__':
    app.run(debug=True, host='192.168.0.94', port=5001)
