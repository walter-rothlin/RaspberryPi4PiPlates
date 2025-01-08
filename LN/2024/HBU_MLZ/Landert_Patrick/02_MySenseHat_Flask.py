#!/usr/bin/python3

from flask import *
from time import sleep
from Class_MySenseHat import MySenseHat

red   = (255,   0,   0)
blue  = (  0,   0, 255)
green = (  0, 255,   0)
black = (  0,   0,   0)
white = (255, 255, 255)
grey  = ( 64,  64,  64)

app = Flask(__name__)
sense = MySenseHat()  # Ersetzen von SenseHat durch MySenseHat

# Definieren der Variable `version`
version = 'Patrick Landert'

@app.route('/set_pixel', methods=['GET'])
def set_pixel():
    all_get_parameters = dict(request.args.items())
    print(all_get_parameters)
    # Standardwerte setzen
    try:
        x = int(all_get_parameters.get('x', '0'))
        y = int(all_get_parameters.get('y', '0'))
        r = int(all_get_parameters.get('r', '0'))
        g = int(all_get_parameters.get('g', '0'))
        b = int(all_get_parameters.get('b', '0'))
    except ValueError:
        return render_template(
            'test_endpoints_page.html',
            test_result_string="Invalid input. x, y, r, g, b must be integers."
        ), 400

    # Validierung der Eingabewerte
    if not (0 <= x <= 7 and 0 <= y <= 7):
        return render_template(
            'test_endpoints_page.html',
            test_result_string="Coordinates x and y must be between 0 and 7."
        ), 400

    if not (0 <= r <= 255 and 0 <= g <= 255 and 0 <= b <= 255):
        return render_template(
            'test_endpoints_page.html',
            test_result_string="Color values r, g, b must be between 0 and 255."
        ), 400

    # Pixel setzen
    sense.set_pixel(x, y, r, g, b)
    return render_template(
        'test_endpoints_page.html',
        test_result_string=f'set_pixel({x}, {y}, {r}, {g}, {b}) executed successfully!'
    )

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
    elif bg_color == 'white':
        sense.clear(white)   
    elif bg_color == 'grey':
        sense.clear(grey)   
    else:
        return render_template('test_endpoints_page.html', test_result_string=f'Invalid color: {bg_color}'), 400

    return render_template('test_endpoints_page.html', test_result_string=f'Clear LED matrix to color {bg_color}!')

@app.route('/')
def index():
    return render_template('index.html', version=version)

@app.route('/test')
def test_endpoints_page():
    # Beispiel-Result-String
    result_string = "Dies ist ein Test-Result-String für die Endpunkte."
    return render_template('test_endpoints_page.html', result_string=result_string)

@app.route('/show_message', methods=['GET'])
def show_message():
    # Lesen der Parameter aus der Anfrage
    text_string = request.args.get('text_string', 'Hello World').strip()
    scroll_speed = float(request.args.get('scroll_speed', 0.1))
    text_colour = request.args.get('text_colour', '255,255,255')
    back_colour = request.args.get('back_colour', '0,0,0')

    # Validierung: Prüfen, ob der Text leer ist
    if not text_string:
        return render_template(
            'test_endpoints_page.html',
            test_result_string="Error: No text provided. Please enter a message to display."
        ), 400
    
    # Konvertieren der Farbwerte zu Tupeln
    try:
        text_colour = tuple(map(int, text_colour.split(',')))
        back_colour = tuple(map(int, back_colour.split(',')))
    except ValueError:
        return render_template('test_endpoints_page.html', test_result_string='Invalid colour format. Use "R,G,B" format.'), 400

    # Validieren der Farben
    if not all(0 <= val <= 255 for val in text_colour + back_colour):
        return render_template('test_endpoints_page.html', test_result_string='Colour values must be between 0 and 255.'), 400

    # Anzeigen der Nachricht
    sense.show_message(text_string, scroll_speed=scroll_speed, text_colour=text_colour, back_colour=back_colour)
    return render_template('test_endpoints_page.html', test_result_string=f'Message "{text_string}" displayed with scroll_speed={scroll_speed}, text_colour={text_colour}, back_colour={back_colour}.')


@app.route('/set_rotation', methods=['GET'])
def set_rotation():
    # Lesen der Parameter aus der Anfrage
    rotation = request.args.get('r', '0')  # Standardwert: 0
    redraw = request.args.get('redraw', 'True').lower() in ('true', '1')

    # Validieren der Rotationsparameter
    try:
        rotation = int(rotation)
        if rotation not in [0, 90, 180, 270]:
            return render_template('test_endpoints_page.html', test_result_string='Invalid rotation value. Use 0, 90, 180, or 270.'), 400
    except ValueError:      
        return render_template('test_endpoints_page.html', test_result_string='Rotation must be an integer value.'), 400
    
    # Setzen der Rotation
    sense.set_rotation(rotation, redraw=redraw)
    return render_template('test_endpoints_page.html', test_result_string=f'set_rotation({rotation}, redraw={redraw}) executed successfully.')


@app.route('/show_letter', methods=['GET'])
def show_letter():
    # Lesen der Parameter aus der Anfrage
    letter = request.args.get('s', '?')  # Standardbuchstabe: '?'
    text_colour = request.args.get('text_colour', '0,255,0')
    back_colour = request.args.get('back_colour', '100,100,100')

    # Konvertieren der Farbwerte zu Tupeln
    try:
        text_colour = tuple(map(int, text_colour.strip('()').split(',')))
        back_colour = tuple(map(int, back_colour.strip('()').split(',')))
    except ValueError:
         return render_template('test_endpoints_page.html', test_result_string='Invalid colour format. Use "(R,G,B)" format.'), 400

    # Validieren der Farben
    if not all(0 <= val <= 255 for val in text_colour + back_colour):
        return render_template('test_endpoints_page.html', test_result_string='Colour values must be between 0 and 255.'), 400

    # Anzeigen der Buchstaben
    sense.show_letter(letter, text_colour=text_colour, back_colour=back_colour)
    return render_template('test_endpoints_page.html', test_result_string=f'show_letter("{letter}", text_colour={text_colour}, back_colour={back_colour}) executed successfully.')

@app.route('/low_light', methods=['GET'])
def low_light():
    # Lesen der Parameter aus der Anfrage
    low_light_val = request.args.get('low_light_val', 'True').lower()

    # Konvertieren der Parameter zu einem Boolean
    if low_light_val in ('true', '1', 'yes'):
        low_light_status = True
    elif low_light_val in ('false', '0', 'no'):
        low_light_status = False
    else:
         return render_template('test_endpoints_page.html', test_result_string='Invalid value for "low_light_val". Use "True" or "False".'), 400

    # Setzen des Low-Light-Modus
    sense.low_light = low_light_status
    return render_template('test_endpoints_page.html', test_result_string=f'low_light={low_light_status} set successfully.')


if __name__ == '__main__':
    app.run(debug=True, host='beeri.local', port=5001)