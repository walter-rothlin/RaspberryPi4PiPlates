#!/usr/bin/python3

#######################################################################
# Programm: Leistungskontrolle 2
# Fach:     Python2
# Autor:    Claudio Monti
# Datum:    03-12-2024
#######################################################################

from sense_hat import SenseHat
import math

class MySenseHat(SenseHat):
    def __init__(self):
        super().__init__()
        self.default_background_color = (0, 0, 0)  # Schwarz
        self.default_foreground_color = (255, 255, 255)  # Weiß

    def set_pixel(self, x, y, r=None, g=None, b=None):
        # Verwende Standardfarben, falls keine Farben angegeben wurden
        if r is None or g is None or b is None:
            r, g, b = self.default_foreground_color

        # Konvertiere String-Eingaben in Integer
        try:
            x = int(float(x))
            y = int(float(y))
        except ValueError:
            print("Error: x und y müssen Zahlen sein.")
            return

        # Überprüfe die Grenzen
        if 0 <= x < 8 and 0 <= y < 8:
            super().set_pixel(x, y, r, g, b)
        else:
            print(f"Warnung: Pixelposition ({x}, {y}) liegt außerhalb der Grenzen!")

    def draw_line(self, start_point, end_point, bg_color=None, fg_color=None):
        # Standardfarben setzen, falls nicht angegeben
        bg_color = bg_color or self.default_background_color
        fg_color = fg_color or self.default_foreground_color

        x_start, y_start = start_point
        x_end, y_end = end_point

        # Konvertiere Eingaben und runde auf Integer
        try:
            x_start = int(round(float(x_start)))
            y_start = int(round(float(y_start)))
            x_end = int(round(float(x_end)))
            y_end = int(round(float(y_end)))
        except ValueError:
            print("Error: Start- und Endpunkte müssen Zahlen sein.")
            return

        # Berechne die Differenzen
        dx = x_end - x_start
        dy = y_end - y_start

        if dx == 0:  # Vertikale Linie
            y_range = range(min(y_start, y_end), max(y_start, y_end) + 1)
            for y in y_range:
                self.set_pixel(x_start, y, *fg_color)
        else:
            # Berechne die Steigung
            a = dy / dx
            b = y_start - a * x_start

            if abs(a) <= 1:  # Flache Linie
                x_range = range(min(x_start, x_end), max(x_start, x_end) + 1)
                for x in x_range:
                    y = round(a * x + b)
                    self.set_pixel(x, y, *fg_color)
            else:  # Steile Linie
                y_range = range(min(y_start, y_end), max(y_start, y_end) + 1)
                for y in y_range:
                    x = round((y - b) / a)
                    self.set_pixel(x, y, *fg_color)

#######################################################################
# Main-Testprogramm
#######################################################################
if __name__ == "__main__":
    sense = MySenseHat()

    # Testfall 1: Standardfarben nutzen
    sense.set_pixel(4, 5)  # Standardfarbe (Weiß)

    # Testfall 2: Pixel außerhalb der Grenzen
    sense.set_pixel(8, 5, 0, 255, 0)  # Grün (Fehler erwartet)

    # Testfall 3: Linie mit Standardfarben zeichnen
    sense.draw_line((0, 0), (7, 7))  # Diagonale Linie (Weiß)

    # Testfall 4: Linie mit benutzerdefinierten Farben
    sense.draw_line((0, 7), (7, 0), fg_color=(0, 255, 0))  # Grün

    # Testfall 5: Vertikale Linie
    sense.draw_line((3, 0), (3, 7), fg_color=(255, 0, 0))  # Rot

    # Testfall 6: Linie außerhalb der Matrixgrenzen
    sense.draw_line((-2, -2), (9, 9), fg_color=(255, 0, 255))  # Magenta
