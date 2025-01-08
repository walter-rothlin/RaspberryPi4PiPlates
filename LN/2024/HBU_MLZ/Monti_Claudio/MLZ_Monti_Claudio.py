############################################################################################
# Program: MLZ
# Fach:    Python 2
# Autor:   Claudio Monti
# Datum:   2025-01-07
#############################################################################################

from flask import Flask, request, render_template
from sense_hat import SenseHat  

# Eigene SenseHat-Klasse mit Fehlerbehandlung
# Klasse ersetzt direkte Verwendung von SenseHat und zusätzliche Validierungen.
class MySense_Hat:
    def __init__(self):
        self.sense = SenseHat()

    # Setzt ein Pixel auf der LED-Matrix mit den angegebenen Koordinaten und Farben
    def set_pixel(self, x, y, r, g, b):
        try:
            if 0 <= x < 8 and 0 <= y < 8 and all(0 <= color <= 255 for color in [r, g, b]):
                self.sense.set_pixel(x, y, (r, g, b))
            else:
                raise ValueError(f"Ungültige Eingaben: x={x}, y={y}, r={r}, g={g}, b={b}")
        except Exception as e:
            print(f"Fehler beim Setzen des Pixels: {e}")

    # Löscht die LED-Matrix und setzt sie optional auf eine bestimmte Farbe
    def clear(self, color=None):
        if color and all(0 <= c <= 255 for c in color):
            self.sense.clear(color)
        else:
            self.sense.clear()

    # Holt den aktuellen Zustand der LED-Matrix
    def get_pixels(self):
        return self.sense.get_pixels()

    # Zeigt eine scrollende Nachricht auf der LED-Matrix an
    def show_message(self, message, scroll_speed=0.1, text_color=(255, 255, 255), back_color=(0, 0, 0)):
        if all(0 <= c <= 255 for c in text_color) and all(0 <= c <= 255 for c in back_color):
            self.sense.show_message(message, scroll_speed, text_color, back_color)
        else:
            raise ValueError("Ungültige Text- oder Hintergrundfarben.")

    # Setzt die Rotationsrichtung der LED-Matrix
    def set_rotation(self, rotation):
        if rotation in [0, 90, 180, 270]:
            self.sense.set_rotation(rotation)
        else:
            raise ValueError("Ungültiger Rotationswert. Verwenden Sie 0, 90, 180 oder 270.")

    # Zeigt einen Buchstaben auf der LED-Matrix an
    def show_letter(self, letter, text_color=(255, 255, 255), back_color=(0, 0, 0)):
        if len(letter) == 1 and all(0 <= c <= 255 for c in text_color) and all(0 <= c <= 255 for c in back_color):
            self.sense.show_letter(letter, text_color, back_color)
        else:
            raise ValueError("Ungültiger Buchstabe oder Farbwerte.")

    # Aktiviert oder deaktiviert den Low-Light-Modus (gedimmte LEDs)
    def set_low_light(self, low_light):
        self.sense.low_light = low_light

# Flask-App initialisieren
app = Flask(__name__)
sense = MySense_Hat()

# Version definieren (entspricht der Aufgabe: JINJA2 Templates - Version anzeigen)
version = 'Claudio Monti'

# Hauptseite der Anwendung (entspricht der Aufgabe: index.html erweitern)
@app.route('/')
def index():
    return render_template('index.html', version=version)

# Endpoint zum Setzen eines Pixels (entspricht der Aufgabe: REST Service erweitern)
@app.route('/set_pixel', methods=['GET'])
def set_pixel():
    try:
        x = int(request.args.get('x', '0'))
        y = int(request.args.get('y', '0'))
        r = int(request.args.get('r', '0'))
        g = int(request.args.get('g', '0'))
        b = int(request.args.get('b', '0'))
        sense.set_pixel(x, y, r, g, b)
        return render_template('test_endpoints_page.html', test_result_string=f'set_pixel({x}, {y}, {r}, {g}, {b}) erfolgreich!')
    except Exception as e:
        return render_template('test_endpoints_page.html', test_result_string=f'Fehler: {e}')

# Endpoint zum Abfragen des aktuellen Status (LED-Matrix, Temperatur, etc.)
@app.route('/get_status', methods=['GET'])
def get_status():
    try:
        status = {
            'LED_Matrix': sense.get_pixels(),
            'Temperature': sense.sense.get_temperature(),
            'Humidity': sense.sense.get_humidity(),
            'Pressure': sense.sense.get_pressure(),
        }
        return render_template('test_endpoints_page.html', test_result_string=f'Status: {status}')
    except Exception as e:
        return render_template('test_endpoints_page.html', test_result_string=f'Fehler: {e}')

# Endpoint zum Löschen der LED-Matrix (entspricht der Aufgabe: REST Service erweitern)
@app.route('/clear_LED', methods=['GET'])
def clear_LED():
    try:
        bg_color = request.args.get('color', 'black').lower()
        colors = {'black': (0, 0, 0), 'red': (255, 0, 0), 'blue': (0, 0, 255), 'green': (0, 255, 0), 'grey': (128, 128, 128), 'white': (255, 255, 255)}
        sense.clear(colors.get(bg_color, (0, 0, 0)))
        return render_template('test_endpoints_page.html', test_result_string=f'LED-Matrix auf {bg_color} gesetzt.')
    except Exception as e:
        return render_template('test_endpoints_page.html', test_result_string=f'Fehler: {e}')

# Endpoint zum Anzeigen einer scrollenden Nachricht
@app.route('/show_message', methods=['GET'])
def show_message():
    try:
        message = request.args.get('message', 'Hallo')
        scroll_speed = float(request.args.get('scroll_speed', '0.1'))
        r = int(request.args.get('r', '255'))
        g = int(request.args.get('g', '255'))
        b = int(request.args.get('b', '255'))
        sense.show_message(message, scroll_speed, (r, g, b))
        return render_template('test_endpoints_page.html', test_result_string=f'Nachricht "{message}" erfolgreich angezeigt!')
    except Exception as e:
        return render_template('test_endpoints_page.html', test_result_string=f'Fehler: {e}')

# Endpoint zum Setzen der Rotationsrichtung der LED-Matrix
@app.route('/set_rotation', methods=['GET'])
def set_rotation():
    try:
        # Rotation und redraw aus der URL extrahieren
        rotation = int(request.args.get('rotation', '0'))
        redraw = request.args.get('redraw', 'false').lower() == 'true'
        
        # Rotation setzen
        sense.set_rotation(rotation)
        
        # Wenn redraw=True gesetzt ist, nach der Rotation die Anzeige aktualisieren
        if redraw:
            sense.show_letter("A", text_color=(255, 255, 255), back_color=(0, 0, 0))
        
        return render_template('test_endpoints_page.html', test_result_string=f'Rotation auf {rotation} Grad gesetzt.')
    except Exception as e:
        return render_template('test_endpoints_page.html', test_result_string=f'Fehler: {e}')


# Endpoint zum Anzeigen eines einzelnen Buchstabens
@app.route('/show_letter', methods=['GET'])
def show_letter():
    try:
        # Extrahiere den Buchstaben, Textfarbe und Hintergrundfarbe
        letter = request.args.get('letter', 'A')
        text_colour = tuple(map(int, request.args.get('text_colour', '255,255,255').split(',')))
        back_colour = tuple(map(int, request.args.get('back_colour', '0,0,0').split(',')))

        # Zeige den Buchstaben auf dem Sense HAT an
        sense.show_letter(letter, text_colour, back_colour)
        
        return render_template('test_endpoints_page.html', test_result_string=f'Buchstabe "{letter}" mit Textfarbe {text_colour} und Hintergrundfarbe {back_colour} angezeigt!')
    except Exception as e:
        return render_template('test_endpoints_page.html', test_result_string=f'Fehler: {e}')


# Endpoint zum Aktivieren oder Deaktivieren des Low-Light-Modus
@app.route('/low_light', methods=['GET'])
def low_light():
    try:
        # Low-Light-Modus aktivieren oder deaktivieren basierend auf dem Parameter
        low_light = request.args.get('low_light_val', 'false').lower() == 'true'
        sense.set_low_light(low_light)
        
        # Verwende eine helle Farbe, um den Unterschied sichtbar zu machen
        if low_light:
            sense.clear((255, 255, 255))  # Weißes Licht im Low-Light-Modus
        else:
            sense.clear((255, 255, 255))  # Weißes Licht ohne Low-Light

        # Rückmeldung zur Low-Light-Einstellung
        return render_template('test_endpoints_page.html', test_result_string=f'Low-Light-Modus auf {low_light} gesetzt. Bitte überprüfen Sie den Unterschied auf der Matrix.')
    
    except Exception as e:
        return render_template('test_endpoints_page.html', test_result_string=f'Fehler: {e}')


#################################################################################################
# Main: Startet den Flask-Server 
#################################################################################################
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5002)
