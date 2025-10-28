#!/usr/bin/python3

from sense_hat import SenseHat

class MySenseHat(SenseHat):
    def __init__(self):
        super().__init__()

    def set_pixel(self, x, y, r, g, b):
        try:
            x = int(round(float(x)))
            y = int(round(float(y)))
        except (ValueError, TypeError):
            print(f"Ungültige Koordinaten: x={x}, y={y}")
            return

        if 0 <= x < 8 and 0 <= y < 8:
            super().set_pixel(x, y, r, g, b)
        else:
            print(f"Pixel ausserhalb der Grenzen: x={x}, y={y}")

    def draw_line(self, x_start, y_start, x_end, y_end, r, g, b):
        try:
            x_start = int(round(float(x_start)))
            y_start = int(round(float(y_start)))
            x_end = int(round(float(x_end)))
            y_end = int(round(float(y_end)))
        except (ValueError, TypeError):
            print("Ungültige Start-/Endkoordinaten")
            return

        dx = x_end - x_start
        dy = y_end - y_start

        if dx == 0:
            y_range = range(min(y_start, y_end), max(y_start, y_end) + 1)
            for y in y_range:
                self.set_pixel(x_start, y, r, g, b)
        else:
            a = dy / dx
            b_line = y_start - a * x_start

            if abs(a) <= 1:
                x_range = range(min(x_start, x_end), max(x_start, x_end) + 1)
                for x in x_range:
                    y = a * x + b_line
                    self.set_pixel(x, y, r, g, b)
            else:
                y_range = range(min(y_start, y_end), max(y_start, y_end) + 1)
                for y in y_range:
                    if a != 0:
                        x = (y - b_line) / a
                    else:
                        x = x_start
                    self.set_pixel(x, y, r, g, b)

if __name__ == "__main__":
    sense = MySenseHat()
    # Test: Pixel setzen
    sense.set_pixel(4, 5, 255, 0, 0)      # Rot
    sense.set_pixel(8, 5, 0, 255, 0)      # Grün, sollte Fehler ausgeben

    # Test: Dezimal und String
    sense.set_pixel("3.7", "2.2", 0, 0, 255)  # Blau

    # Test: Linie
    sense.draw_line(0, 0, 7, 7, 255, 255, 0)  # Diagonal
    sense.draw_line(2, 0, 2, 7, 255, 0, 255)  # Vertikal
    sense.draw_line(0, 7, 7, 0, 0, 255, 255)  # Andere Diagonale
    #sense.clear()