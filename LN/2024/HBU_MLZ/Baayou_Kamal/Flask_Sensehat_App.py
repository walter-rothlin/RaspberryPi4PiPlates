from flask import *
from sense_hat import SenseHat
from MySense_Hat_Class import *

red   = (255, 0, 0)
blue  = (0, 0, 255)
green = (0, 255, 0)
black = (0, 0, 0)

app = Flask(__name__)
sense =  MySenseHat()


def is_valid_coordinate(value):
    return 0 <= value <= 7

def is_valid_rgb(value):
    return 0 <= value <= 255

@app.route('/set_pixel', methods=['GET'])
def set_pixel():
    all_get_parameters = dict(request.args.items())
    try:
        x = int(all_get_parameters.get('x', '0'))
        y = int(all_get_parameters.get('y', '0'))
        r = int(all_get_parameters.get('r', '0'))
        g = int(all_get_parameters.get('g', '0'))
        b = int(all_get_parameters.get('b', '0'))

        if not (is_valid_coordinate(x) and is_valid_coordinate(y)):
            test_result_string = f"Error: Coordinates (x, y) must be in range 0..7."
            return render_template('test_endpoints_page.html', result_string=test_result_string), 400

        if not (is_valid_rgb(r) and is_valid_rgb(g) and is_valid_rgb(b)):
            test_result_string = f"Error: RGB values must be in range 0..255."
            return render_template('test_endpoints_page.html', result_string=test_result_string), 400

        sense.set_pixel(x, y, r, g, b)
        test_result_string = f"set_pixel({x},{y},{r},{g},{b}) successful!"
        return render_template('test_endpoints_page.html', result_string=test_result_string)

    except ValueError:
        test_result_string = "Error: Invalid input. Coordinates and RGB values must be integers."
        return render_template('test_endpoints_page.html', result_string=test_result_string), 400



@app.route('/get_status', methods=['GET'])
def get_status():
    try:
        pixel_status = sense.get_pixels()
        humidity = sense.get_humidity()
        temperature = sense.get_temperature()
        pressure = sense.get_pressure()

        return {
            'LED_Matrix': pixel_status,
            'Temperature': temperature,
            'Humidity': humidity,
            'Pressure': pressure,
        }
    except Exception as e:
        return {"Error": str(e)}, 500

@app.route('/clear_LED', methods=['GET'])
def clear_LED():
    all_get_parameters = dict(request.args.items())
    bg_color = all_get_parameters.get('color', 'black').lower()

    color_map = {
        'black': black,
        'red': red,
        'blue': blue,
        'green': green,
        'white': (255, 255, 255),
        'grey': (128, 128, 128),
    }

    if bg_color in color_map:
        sense.clear(color_map[bg_color])
        test_result_string = f"Clear LED matrix to color {bg_color}!"
        return render_template('test_endpoints_page.html', result_string=test_result_string)
    else:
        test_result_string = f"Error: Color '{bg_color}' is not supported."
        return render_template('test_endpoints_page.html', result_string=test_result_string), 400

@app.route('/show_message', methods=['GET'])
def show_message():
    all_get_parameters = dict(request.args.items())
    
    try:
       
        text_string = all_get_parameters.get('text_string', 'Hello')  
        scroll_speed = float(all_get_parameters.get('scroll_speed', 0.1))  
        text_colour = tuple(map(int, all_get_parameters.get('text_colour', '255,255,255').split(','))) 
        back_colour = tuple(map(int, all_get_parameters.get('back_colour', '0,0,0').split(',')))  

        # Check if the provided colors are within valid RGB range 
        # hier war Hile von KI nötig
        if not (is_valid_rgb(text_colour[0]) and is_valid_rgb(text_colour[1]) and is_valid_rgb(text_colour[2])):
            return render_template('test_endpoints_page.html', result_string="Error: Invalid text color."), 400
        if not (is_valid_rgb(back_colour[0]) and is_valid_rgb(back_colour[1]) and is_valid_rgb(back_colour[2])):
            return render_template('test_endpoints_page.html', result_string="Error: Invalid background color."), 400
        
        # Show the message on the Sense HAT display
        sense.show_message(text_string, scroll_speed, text_colour, back_colour)

        result_string = f"Message '{text_string}' displayed with scroll speed {scroll_speed} and text color {text_colour} on a {back_colour} background!"
        return render_template('test_endpoints_page.html', result_string=result_string)

    except ValueError:
        return render_template('test_endpoints_page.html', result_string="Error: Invalid input for text, scroll speed, or colors."), 400

@app.route('/set_rotation', methods=['GET'])
def set_rotation():
    all_get_parameters = dict(request.args.items())
    
    try:
       
        rotation = int(all_get_parameters.get('r', '0'))  
        redraw = all_get_parameters.get('redraw', 'False').lower() == 'true'  
        
        # Validate the rotation value
        if rotation not in [0, 90, 180, 270]:
            return render_template('test_endpoints_page.html', result_string="Error: Invalid rotation value. Must be 0, 90, 180, or 270."), 400
        
        sense.set_rotation(rotation)
        
        if redraw:
            sense.clear()  
        
        # Generate a result message
        result_string = f"Rotation set to {rotation} degrees."
        if redraw:
            result_string += " Display has been redrawn."
        
        return render_template('test_endpoints_page.html', result_string=result_string)

    except ValueError:
        return render_template('test_endpoints_page.html', result_string="Error: Invalid rotation value."), 400

@app.route('/show_letter', methods=['GET'])
def show_letter():
    all_get_parameters = dict(request.args.items())
    
    try:
        # Extract parameters
        letter = all_get_parameters.get('s', '?')  # Default letter is '?'
        text_colour = tuple(map(int, all_get_parameters.get('text_colour', '255,255,255').split(',')))  # Default: White
        back_colour = tuple(map(int, all_get_parameters.get('back_colour', '0,0,0').split(',')))  # Default: Black

        # Validate that the letter is a single character
        if len(letter) != 1:
            return render_template('test_endpoints_page.html', result_string="Error: The 's' parameter must be a single character."), 400

        # Validate the RGB color values
        if not (is_valid_rgb(text_colour[0]) and is_valid_rgb(text_colour[1]) and is_valid_rgb(text_colour[2])):
            return render_template('test_endpoints_page.html', result_string="Error: Invalid text color."), 400
        if not (is_valid_rgb(back_colour[0]) and is_valid_rgb(back_colour[1]) and is_valid_rgb(back_colour[2])):
            return render_template('test_endpoints_page.html', result_string="Error: Invalid background color."), 400
        
        # Display the letter on the Sense HAT display
        sense.show_letter(letter, text_colour, back_colour)

        result_string = f"Letter '{letter}' displayed with text color {text_colour} and background color {back_colour}!"
        return render_template('test_endpoints_page.html', result_string=result_string)

    except ValueError:
        return render_template('test_endpoints_page.html', result_string="Error: Invalid input for colors."), 400


@app.route('/low_light', methods=['GET'])
def low_light():
    all_get_parameters = dict(request.args.items())

    try:
        # hier war Hilfe von KI nötig
        low_light_val = all_get_parameters.get('low_light_val', 'False').lower() == 'true'

        # Set the low light mode on the Sense HAT
        sense.low_light = low_light_val

        # Generate a result string based on the value of low_light_val
        if low_light_val:
            result_string = "Low light mode enabled (LEDs dimmed)."
        else:
            result_string = "Low light mode disabled (LEDs normal brightness)."

        return render_template('test_endpoints_page.html', result_string=result_string)

    except Exception as e:
        return render_template('test_endpoints_page.html', result_string=f"Error: {str(e)}"), 400



@app.route('/')
def index():
    version = 'Kamal Baayou'
    return render_template('index.html', version=version)

if __name__ == '__main__':

   
    app.run(host='0.0.0.0', port=5000, debug=True)
