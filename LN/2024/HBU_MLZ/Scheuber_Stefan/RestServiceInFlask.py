#!/usr/bin/python3
from flask import Flask,request, render_template
from LZ2_SenseHat import MySenseHat
import json

app = Flask(__name__)
sense = MySenseHat()

version = "Stefan Scheuber V1.0.0"

red   = (255,   0,   0)
blue  = (  0,   0, 255)
green = (  0, 255,   0)
black = (  0,   0,   0)
white = (  255,   255,   255)
grey =  (64, 64, 64)

app = Flask(__name__)
sense = MySenseHat()

@app.route('/set_pixel', methods=['GET', 'POST'])
def set_pixel():

    if request.method == 'POST':
        x = int(request.form.get('xPos',0)) 
        y = int(request.form.get('yPos',0))
        r = int(request.form.get('red',0)) 
        g = int(request.form.get('green',0))  
        b = int(request.form.get('blue',0)) 

    else:
        all_get_parameters = dict(request.args.items())
        print(all_get_parameters)
        x = int(all_get_parameters.get('x', '0'))
        y = int(all_get_parameters.get('y', '0'))
        r = int(all_get_parameters.get('r', '0'))
        g = int(all_get_parameters.get('g', '0'))
        b = int(all_get_parameters.get('b', '0'))
    
    
    sense.set_pixel(x,y,(r,g,b))   
    return render_template('test_endpoints_page.html', test_result_string=f'set_pixel({x},{y},{r},{g},{b})!',route = 'set_pixel')

@app.route('/get_status', methods=['GET'])
def get_status():
    pixel_status = sense.get_pixels()
    humidity = sense.get_humidity()
    temperature = sense.get_temperature()
    pressure = sense.get_pressure()
    
    print(pixel_status)
    # return {'LED_Matrix': pixel_status,
    #         'Temperature':   temperature,
    #         'Humidity': humidity,
    #         'Pressure': pressure,
    #        }
    tempDict = {'Temperature':   temperature,
            'Humidity': humidity,
            'Pressure': pressure,
           }
    # result_string = f'{{"LED_Matrix": "{pixel_status}", "Temperature": {temperature}, "Humidity": {humidity}, "Pressure": {pressure}}}'
    # result_string = json.dumps({'LED_Matrix': pixel_status,'Temperature': temperature,'Humidity': humidity, 'Pressure': pressure})

    return render_template('test_endpoints_page.html',dict_format = tempDict, list_format = pixel_status)

@app.route('/clear_LED', methods=['GET', 'POST'])
def clear_LED():
    all_get_parameters = dict(request.args.items())
    # print(all_get_parameters)
    if request.method == 'POST':
        bg_color = request.form.get('dropdown')
    else:
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
    # return f'Clear LED matrix to color {bg_color}!'
    return render_template('test_endpoints_page.html', test_result_string= f'Clear LED matrix to color {bg_color}!', route = "clear_LED")

@app.route('/show_message', methods=['GET','POST'])
def show_message():
    if request.method == 'POST':
        text_string = request.form.get('text_string','emptyString')
        scroll_speed = float(request.form.get('scroll_speed','0.06'))
        text_color = parse_rgb(request.form.get('text_color','214,214,214'))
        background_color = parse_rgb(request.form.get('back_color','64, 64, 64'))
    else:
        all_get_parameters = dict(request.args.items())
        #print(all_get_parameters)
        text_string = all_get_parameters.get('text_string','emptyString')
        scroll_speed = float(all_get_parameters.get('scroll_speed','0.06'))
        text_color = parse_rgb(all_get_parameters.get('text_colour','214,214,214'))
        background_color = parse_rgb(all_get_parameters.get('back_colour','64, 64, 64'))
    
    sense.show_message(text_string,scroll_speed,text_color,background_color)
    #text_string=Hallo+Walti&scroll_speed=0.05&text_colour=255,0,0&back_colour=0,0,0
    # return f'Show message [{text_string}] with scroll speed [{scroll_speed}]'
    return render_template('test_endpoints_page.html', test_result_string=f'Show message [{text_string}] with scroll speed [{scroll_speed}]', route = 'show_message')

@app.route('/set_rotation', methods=['GET','POST'])
def set_rotation():
    if request.method == 'POST':
        rotation = int(request.form.get('dropdown'))
        redraw = bool(request.form.get('redraw'))
    else:
        all_get_parameters = dict(request.args.items())
        #print(all_get_parameters)
        rotation = parse_and_validate_angle(all_get_parameters.get('r','90'))
        redraw = parse_bool(all_get_parameters.get('redraw','True'))

    sense.set_rotation(rotation,redraw)
    # return f'Set rotation to: [{rotation}] redraw activ: [{redraw}]'
    return render_template('test_endpoints_page.html', test_result_string=f'Set rotation to: [{rotation}] redraw activ: [{redraw}]', route = 'set_rotation')

#"/set_rotation?r=0&redraw=True

@app.route('/show_letter', methods=['GET'])
def show_letter():
    all_get_parameters = dict(request.args.items())
    #print(all_get_parameters)
    letter = check_and_truncate(all_get_parameters.get('s','emptyString'))
    text_color = parse_rgb(all_get_parameters.get('text_colour','214,214,214'))
    background_color = parse_rgb(all_get_parameters.get('back_colour','64, 64, 64'))
    
    sense.show_letter(letter,text_color,background_color)
    #s=?&text_colour=(0,255,0)&back_colour=(100,100,100)
    # return f'Show letter [{letter}]'
    return render_template('test_endpoints_page.html', test_result_string=f'Show letter [{letter}]')

@app.route('/low_light', methods=['GET'])
def low_light():
    all_get_parameters = dict(request.args.items())
    #print(all_get_parameters)
    low_light = parse_bool(all_get_parameters.get('low_light_val','true'))
    
    sense.low_light=low_light
    #low_light_val=True
    # return f'low light on: [{low_light}]'
    return render_template('test_endpoints_page.html', test_result_string=f'low light on: [{low_light}]')


@app.route('/')
def index():
    return render_template('index.html',version=version)

def parse_rgb(rgb_string):
    """
    Converts a comma-separated RGB string into a list of integers after cleaning unwanted characters.
    
    Args:
        rgb_string (str): RGB values as a string, e.g., "255,0,0" or "(255,0,0)".
    
    Returns:
        list: RGB values as integers, e.g., [255, 0, 0].
    """
    # Remove parentheses if they exist
    cleaned_string = rgb_string.replace("(", "").replace(")", "")
    
    # Split the cleaned string by commas and convert to integers
    return [int(x) for x in cleaned_string.split(",")]

def parse_bool(string_value):
    """
    Converts a string to a boolean value.

    Args:
        string_value (str): Input string, e.g., "true", "false".
    
    Returns:
        bool: True or False.
    
    Raises:
        ValueError: If the string is not "true" or "false".
    """
    if string_value.lower() == "true":
        return True
    elif string_value.lower() == "false":
        return False
    else:
        raise ValueError(f"Invalid boolean string: {string_value}")

def parse_and_validate_angle(angle_string):
    """
    Parses and validates if the input string represents a valid angle.

    Args:
        angle_string (str): Input string, e.g., "90".

    Returns:
        int or None: The angle as an integer if valid (0, 90, 180, 270); None otherwise.
    """
    try:
        angle = int(angle_string)
        if angle in {0, 90, 180, 270}:
            return angle
    except ValueError:
        pass
    return None

def check_and_truncate(string):
    """
    Checks if the string has only one character. If there are more, truncates the string to the first character.

    Args:
        string (str): The input string to check.

    Returns:
        str: The string with only the first character, or the original string if it has one character.
    """
    if len(string) > 1:
        return string[0]  # Truncate to the first character
    return string  # Return as is if it has one character

if __name__ == '__main__':
    #app.run(debug=True, host='raspStefan', port=5002)
    app.run(debug=True, host='192.168.1.33', port=5003)