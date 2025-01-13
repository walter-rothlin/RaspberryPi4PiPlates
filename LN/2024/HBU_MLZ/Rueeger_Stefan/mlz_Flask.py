from flask import Flask, request, render_template
from mlz_MySenseHat import MySenseHat

# Punkt 9. Form-Elemente für die Test-Execution im test_endpoints_page.html eingefügt
# ist exemplarisch für clear() und set_pixel() implementiert.

red = (255, 0, 0)
green = (0, 255, 0)
blue = (0, 0, 255)
white = (255, 255, 255)
black = (0, 0, 0)
grey = (64, 64, 64)

version='Stefan Rüeger'

app = Flask(__name__)
sense = MySenseHat()

@app.route('/')
def index():
    return render_template('mlz_index.html', version=version)

@app.route('/clear_LED', methods=['GET', 'POST'])
def clear():

    if request.method == 'POST':
        get_color = request.form.get('param')
    else:
        all_parameters = dict(request.args.items())
        get_color = all_parameters['color']

    print(f'###### value: {get_color}')

    if get_color == 'red':
        color = red
    elif get_color == 'green': 
        color = green
    elif get_color == 'blue': 
        color = blue
    elif get_color == 'white': 
        color = white
    elif get_color == 'black': 
        color = black
    elif get_color == 'grey': 
        color = grey
    else:
        raise Exception('ERROR! Unknown color:', get_color)

    sense.clear(color)
    result_string = f'clear({get_color})'
    return render_template('mlz_test_endpoints_page.html', result_string=result_string, endpoint='clear')


@app.route('/get_status')
def get_status():
    temperature = sense.get_temperature()
    humidity = sense.get_humidity()
    pressure = sense.get_pressure()
    result_string = f'Temperature {temperature:3.1f}°C, ' + \
                    f'Humidity {humidity:3.0f}%, ' + \
                    f'Pressure {pressure:4.0f} hPa.'
    return render_template('mlz_test_endpoints_page.html', result_string=result_string, endpoint='get_status')
 
@app.route('/set_pixel', methods=['GET', 'POST'])
def set_pixel():
    
    if request.method == 'POST':
        parameters = request.form.get('param')
        print(f'###### value post: {parameters}')
        x, y, r, g, b = map(int, parameters.split(','))
    else:
        all_parameters = dict(request.args.items())
        print(f'###### value get: {all_parameters}')

        #all_parameters = dict(request.args.items())
        #print(f'\n###### all parameters:\n{all_parameters}\n')
        x = int(all_parameters['x'])
        y = int(all_parameters['y'])
        r = int(all_parameters['r'])
        g = int(all_parameters['g'])
        b = int(all_parameters['b'])

    print(x, y, r, g, b)
    sense.set_pixel(x, y, r, g, b)
    result_string = f'set_pixel({x}, {y}, {r}, {g}, {b})'
    return render_template('mlz_test_endpoints_page.html', result_string=result_string, endpoint='set_pixel')

@app.route('/show_message', methods=['GET'])
def show_message():
    all_parameters = dict(request.args.items())
    text_string = all_parameters['text_string']
    scroll_speed = float(all_parameters['scroll_speed'])
    r, g, b = map(int, all_parameters['text_colour'].split(','))
    text_colour =  [r, g, b]
    r, g, b = map(int, all_parameters['back_colour'].split(','))
    back_colour =  [r, g, b]
    sense.show_message(text_string, scroll_speed, text_colour, back_colour)
    result_string = f'show_message("{text_string}", {scroll_speed}, {text_colour}, {back_colour})'
    return render_template('mlz_test_endpoints_page.html', result_string=result_string, endpoint='show_message')

@app.route('/show_letter', methods=['GET'])
def show_letter():
    all_parameters = dict(request.args.items())
    s = all_parameters['s']
    r, g, b = map(int, all_parameters['text_colour'].strip('()').split(','))
    text_colour =  [r, g, b]
    r, g, b = map(int, all_parameters['back_colour'].strip('()').split(','))
    back_colour =  [r, g, b]
    sense.show_letter(s, text_colour, back_colour)
    result_string = f'show_letter({s}, {text_colour}, {back_colour})'
    return render_template('mlz_test_endpoints_page.html', result_string=result_string, endpoint='show_letter')


@app.route('/set_rotation', methods=['GET'])
def set_rotation():
    all_parameters = dict(request.args.items())
    r = int(all_parameters['r'])
    redraw = True if all_parameters['redraw']=='True' else False
    sense.set_rotation(r, redraw)
    result_string = f'set_rotation({r}, {redraw})'
    return render_template('mlz_test_endpoints_page.html', result_string=result_string, endpoint='set_rotation')


@app.route('/low_light', methods=['GET'])
def low_light():
    all_parameters = dict(request.args.items())
    low_light_val = True if all_parameters['low_light_val']=='True' else False
    sense.low_light = low_light_val
    result_string = f'low_light={low_light_val}'
    return render_template('mlz_test_endpoints_page.html', result_string=result_string, endpoint='low_light')

if __name__ == '__main__':
    # app.run(debug=True, host='gooseberry.local', port=8080)
    app.run(debug=True, host='0.0.0.0', port=5002)
