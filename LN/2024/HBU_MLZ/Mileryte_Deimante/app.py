from flask import Flask, render_template, request

from MySense_Hat import MySense_Hat
sense = MySense_Hat()

app = Flask(__name__)

version = 'Deimante Mileryte'

@app.route('/')
def index():
    temperature = sense.get_temperature()

    try:
        humidity = sense.get_humidity()
    except Exception:
        humidity = None
    
    pressure = sense.get_pressure()

    return render_template('index.html', 
                           temperature=temperature, 
                           humidity=humidity, 
                           pressure=pressure, 
                           version=version)

@app.route('/clear_LED', methods=['GET', 'POST'])
def clear_LED():
    if request.method == 'POST':
        color = request.form.get('color', default='black')
    else:
        color = request.args.get('color', default='black')
    
    try:
        if color[0] == '#':
            r, g, b = [int(color[i:i+2], 16) for i in (1, 3, 5)]
        else:
            color_dict = {
                'red': (255, 0, 0),
                'green': (0, 255, 0),
                'blue': (0, 0, 255),
                'white': (255, 255, 255),
                'black': (0, 0, 0),
                'grey': (128, 128, 128) 
            }
            if color.lower() in color_dict:
                r, g, b = color_dict[color.lower()]
            else:
                return f"Invalid color: {color}. Use a valid color name or hex format."
        
        sense.clear(r, g, b)
        return render_template('test_endpoints_page.html', result_string=f"Cleared LED matrix to color {color}!")
    
    except ValueError as e:
        return render_template('test_endpoints_page.html', result_string=f"Error: {str(e)}")

@app.route('/show_message', methods=['GET', 'POST'])
def show_message():
    if request.method == 'POST':
        text_string = request.form.get('text_string', default='Hello, World!')
        scroll_speed = float(request.form.get('scroll_speed', default=0.05))
        text_colour = request.form.get('text_colour', default='255,0,0')
    elif request.method == 'GET':
        text_string = request.args.get('text_string', default='Hello, World!')
        scroll_speed = float(request.args.get('scroll_speed', default=0.05))
        text_colour = request.args.get('text_colour', default='255,0,0')

    try:
        text_colour = tuple(map(int, text_colour.split(',')))

        sense.show_message(text_string, scroll_speed=scroll_speed, text_colour=text_colour)

        return render_template('test_endpoints_page.html', result_string=f"Message '{text_string}' displayed with text color {text_colour}.")

    except ValueError as e:
        return render_template('test_endpoints_page.html', result_string=f"Error: {str(e)}. Ensure the colors are in the format 'r,g,b'.")


@app.route('/set_pixel', methods=['GET', 'POST'])
def set_pixel():
    if request.method == 'POST':
        x = int(request.form.get('x'))
        y = int(request.form.get('y'))
        r = int(request.form.get('r'))
        g = int(request.form.get('g'))
        b = int(request.form.get('b'))
    elif request.method == 'GET':
        x = int(request.args.get('x'))
        y = int(request.args.get('y'))
        r = int(request.args.get('r'))
        g = int(request.args.get('g'))
        b = int(request.args.get('b'))

    if 0 <= x <= 7 and 0 <= y <= 7:
        sense.set_pixel(x, y, r, g, b)
        return f"Set pixel at ({x}, {y}) to color ({r}, {g}, {b})!"
    else:
        return "ERROR: Coordinates out of range. x and y must be between 0 and 7."

@app.route('/get_status')
def get_status():
    try:
        temperature = sense.get_temperature()
        try:
            humidity = sense.get_humidity()
        except Exception as e:
            humidity = "Sensor not available"
        
        pressure = sense.get_pressure()

        status = f"""
        <h4>Sense_Hat Status</h4>
        <p>Temperature: {temperature:.2f} C</p>
        <p>Humidity: {humidity}</p>
        <p>Pressure: {pressure:.2f} hPa</p>
        """
        return status
    
    except Exception as e:
        return f"Error retrieving Sense_Hat status: {str(e)}"

@app.route('/set_rotation', methods=['GET', 'POST'])
def set_rotation():
    if request.method == 'POST':
        r = int(request.form.get('r', 0))
        redraw = 'redraw' in request.form
    elif request.method == 'GET':
        r = int(request.args.get('r', 0))
        redraw = 'redraw' in request.args

    try:
        sense.set_rotation(r)
        if redraw:
            sense.show_message("Rotation Set", scroll_speed=0.1)

        return render_template('test_endpoints_page.html', result_string=f"Rotation set to {r} degrees. Redraw: {redraw}")
    
    except ValueError as e:
        return render_template('test_endpoints_page.html', result_string=f"Error: {str(e)}")

@app.route('/show_letter', methods=['GET', 'POST'])
def show_letter():
    char = request.args.get('s', default='?')
    text_colour = request.args.get('text_colour', default='255,255,255')
    back_colour = request.args.get('back_colour', default='0,0,0')

    if request.method == 'POST':
        char = request.form.get('s', default='?')
        text_colour = request.form.get('text_colour', default='255,255,255')
        back_colour = request.form.get('back_colour', default='0,0,0')

    try:
        text_colour = tuple(map(int, text_colour.strip('()').split(',')))
        back_colour = tuple(map(int, back_colour.strip('()').split(',')))

        print(f"Character: {char}, Text Colour: {text_colour}, Background Colour: {back_colour}")

        sense.show_letter(char, text_colour=text_colour, back_colour=back_colour)

        result_message = f"Showing letter '{char}' with text color {text_colour} and background color {back_colour}."
        return render_template('test_endpoints_page.html', result_string=result_message)

    except ValueError as e:
        error_message = f"Error: {str(e)}. Ensure the colors are in the format 'r,g,b'."
        return render_template('test_endpoints_page.html', result_string=error_message)

@app.route('/low_light', methods=['GET', 'POST'])
def low_light():
    try:
        if request.method == 'POST':
            low_light_val = request.form.get('low_light_val')
        elif request.method == 'GET':
            low_light_val = request.args.get('low_light_val')

        if low_light_val == 'True':
            sense.clear(50, 50, 50)
            return "Low light enabled."
        elif low_light_val == 'False':
            sense.clear(255, 255, 255)
            return "Low light disabled."
        else:
            return "Invalid low_light_val parameter. Use 'True' or 'False'."

    except ValueError as e:
        return f"Error: {str(e)}"

if __name__ == '__main__':
    app.run(debug=True)