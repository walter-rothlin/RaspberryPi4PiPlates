from sense_hat import SenseHat
import math


class MySenseHat(SenseHat):
    def __init__(self):
        super().__init__()

    def set_pixel(self, x, y, color):

        try:
            x = round(float(x))
            y = round(float(y))
        except ValueError:
            print(f"Invalid input for x or y: x={x}, y={y}")
            return

        # Überprüfen, ob x und y innerhalb der Grenzen der LED-Matrix (8x8) liegen
        if 0 <= x < 8 and 0 <= y < 8:
            super().set_pixel(x, y, color)  # Aufruf der Methode der Oberklasse
        else:
            print(f"Coordinates out of bounds: x={x}, y={y}")

    def draw_line(self, x_start, y_start, x_end, y_end, color):

        try:
            x_start, y_start = round(float(x_start)), round(float(y_start))
            x_end, y_end = round(float(x_end)), round(float(y_end))
        except ValueError:
            print("Invalid start or end coordinates.")
            return

        # Berechnung der Steigung (a) und des Achsenabschnitts (b)
        if x_end - x_start != 0:
            a = (y_end - y_start) / (x_end - x_start)
            b = y_start - a * x_start
        else:
            a, b = None, None  # Vertikale Linie

        # Zeichne die Linie
        if a is not None:  # Nicht-vertikale Linie
            if abs(a) <= 1:  # Steigung <= 1
                for x in range(min(x_start, x_end), max(x_start, x_end) + 1):
                    y = a * x + b
                    self.set_pixel(x, round(y), color)
            else:  # Steigung > 1
                for y in range(min(y_start, y_end), max(y_start, y_end) + 1):
                    x = (y - b) / a
                    self.set_pixel(round(x), y, color)
        else:  # Vertikale Linie
            for y in range(min(y_start, y_end), max(y_start, y_end) + 1):
                self.set_pixel(x_start, y, color)


if __name__ == "__main__":
    # Testprogramm
    sense = MySenseHat()

    # Test 1: Pixel setzen
    print("Test 1: Einzelne Pixel setzen")
    sense.set_pixel(4, 5, (255, 0, 0))  # Pixel auf Rot setzen
    sense.set_pixel(8, 5, (0, 255, 0))  # Außerhalb der Grenzen, sollte Fehler ausgeben
    sense.set_pixel("3", "6", (0, 0, 255))  # Pixel auf Blau setzen
    sense.set_pixel(2.7, 4.9, (255, 255, 0))  # Pixel auf Gelb setzen

    # Test 2: Linie zeichnen
    print("Test 2: Linie zeichnen")
    sense.draw_line(0, 0, 7, 7, (0, 255, 0))  # Diagonale Linie
    sense.draw_line(0, 7, 7, 0, (255, 0, 255))  # Andere Diagonale
    sense.draw_line(0, 3, 7, 3, (0, 0, 255))  # Horizontale Linie
    sense.draw_line(4, 0, 4, 7, (255, 255, 0))  # Vertikale Linie
