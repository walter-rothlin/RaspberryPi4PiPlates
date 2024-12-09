#!/usr/bin/python3
#Autor:         Landert Patrick
#Erstelldatum:  2024-12-03
#

from sense_hat import SenseHat
import math

class MySenseHat(SenseHat):
    def __init__(self):
        super().__init__()

    def set_pixel(self, x, y, color):
        # Wörterbuch zur Umwandlung von Strings in Zahlen
        word_to_number = {
            "null": 0, "eins": 1, "zwei": 2, "drei": 3, "vier": 4,
            "fünf": 5, "sechs": 6, "sieben": 7
        }

        try:
            # Konvertiere Strings in Zahlen, wenn sie in Wortform vorliegen
            if isinstance(x, str) and x.lower() in word_to_number:
                x = word_to_number[x.lower()]
            if isinstance(y, str) and y.lower() in word_to_number:
                y = word_to_number[y.lower()]

            # Konvertiere andere Strings in Integer oder Float
            if isinstance(x, str):
                x = int(float(x))
            if isinstance(y, str):
                y = int(float(y))
            # Runde Dezimalwerte
            if isinstance(x, float):
                x = round(x)
            if isinstance(y, float):
                y = round(y)
        except ValueError:
            print("Fehler: x und y müssen Zahlen oder Strings sein, die in Zahlen konvertierbar sind.")
            return

        # Prüfen, ob die Koordinaten innerhalb der Grenzen sind
        if 0 <= x < 8 and 0 <= y < 8:
            print(f'Pixel gesetzt: x={x}, y={y}, Farbe={color}')
            super().set_pixel(x, y, color)
        else:
            print(f'Fehler: Koordinaten x={x}, y={y} sind außerhalb der gültigen Grenzen (0-7).')

    def draw_line(self, x_start, y_start, x_end, y_end, color):
        try:
            # Berechnung der Steigung und des Achsenabschnitts
            x_start, y_start, x_end, y_end = map(float, [x_start, y_start, x_end, y_end])

            if x_start == x_end:  # Vertikale Linie
                y_min, y_max = sorted([y_start, y_end])
                for y in range(math.ceil(y_min), math.floor(y_max) + 1):
                    self.set_pixel(x_start, y, color)
            else:
                a = (y_end - y_start) / (x_end - x_start)
                b = y_start - a * x_start

                # Zeichne die Linie, indem der grössere Bereich (x oder y) iteriert wird
                if abs(x_end - x_start) >= abs(y_end - y_start):
                    x_min, x_max = sorted([x_start, x_end])
                    for x in range(math.ceil(x_min), math.floor(x_max) + 1):
                        y = a * x + b
                        self.set_pixel(x, y, color)
                else:
                    y_min, y_max = sorted([y_start, y_end])
                    for y in range(math.ceil(y_min), math.floor(y_max) + 1):
                        x = (y - b) / a
                        self.set_pixel(x, y, color)
        except ValueError as e:
            print(f'Fehler bei der Berechnung: {e}')


if __name__ == "__main__":
    hat = MySenseHat()
    hat.clear()

    print("\nTestfall 1: Pixel setzen (innerhalb der Grenzen)")
    hat.set_pixel(4, 5, (255, 0, 0))  # Rot
    input("Drücke Enter, um zum nächsten Testfall zu wechseln...")
    hat.clear()

    print("\nTestfall 2: Pixel setzen (ausserhalb der Grenzen)")
    hat.set_pixel(8, 5, (0, 255, 0))  # Grün
    input("Drücke Enter, um zum nächsten Testfall zu wechseln...")
    hat.clear()

    print("\nTestfall 3: Pixel setzen mit Dezimalwerten")
    hat.set_pixel(3.7, 6.2, (0, 0, 255))  # Blau
    input("Drücke Enter, um zum nächsten Testfall zu wechseln...")
    hat.clear()

    print("\nTestfall 4: Pixel setzen mit Strings")
    hat.set_pixel("2.5", "4.7", (255, 255, 0))  # Gelb
    input("Drücke Enter, um zum nächsten Testfall zu wechseln...")
    hat.clear()    

    print("\nTestfall 4.1: Pixel setzen mit Zahlen in Wortform")
    hat.set_pixel("sechs", "eins", (255, 0, 0))  # Rot
    input("Drücke Enter, um zum nächsten Testfall zu wechseln...")
    hat.clear()

    print("\nTestfall 4.2: Pixel setzen mit gemischten Eingabetypen")
    hat.set_pixel("drei", 6.2, (0, 0, 255))  # Blau
    input("Drücke Enter, um zum nächsten Testfall zu wechseln...")
    hat.clear()

    print("\nTestfall 4.3: Fehlerfall falsches Wort")
    hat.set_pixel("acht", 6.2, (0, 0, 255))  # Blau
    input("Drücke Enter, um zum nächsten Testfall zu wechseln...")
    hat.clear()

    print("\nTestfall 5: Linie zeichnen")
    hat.draw_line(1, 1, 6, 6, (255, 255, 255))  # Weiss (diagonale Linie)
    input("Drücke Enter, um zum nächsten Testfall zu wechseln...")
    hat.clear()

    print("\nTestfall 6: Vertikale Linie")
    hat.draw_line(3, 0, 3, 7, (0, 255, 255))  # Türkis (vertikale Linie)
    input("Drücke Enter, um zum nächsten Testfall zu wechseln...")
    hat.clear()

    print("\nTestfall 7: Linie mit a > 1")
    hat.draw_line(2, 1, 5, 7, (255, 0, 255))  # Magenta (steile Linie)
    input("Drücke Enter, um zum nächsten Testfall zu wechseln...")
    hat.clear()

    print("\nTestfall 8: Linie ausserhalb der Grenzen")
    hat.draw_line(0, 0, 9, 11, (255, 0, 255))  # Magenta (steile Linie)
    input("Drücke Enter, um zum nächsten Testfall zu wechseln...")
    hat.clear()
    