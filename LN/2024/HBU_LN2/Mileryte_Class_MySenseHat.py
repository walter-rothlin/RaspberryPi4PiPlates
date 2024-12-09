#!/usr/bin/python3

from sense_hat import SenseHat
import math

class MySenseHat(SenseHat):
    def __init__(self):
        super().__init__()
        self.clear()

    def set_pixel(self, x, y, r, g, b):
        try:
            x = round(float(x))
            y = round(float(y))
        except ValueError:
            print("Invalid x or y: {}, {}".format(x, y))
            return

        if 0 <= x < 8 and 0 <= y < 8:
            super().set_pixel(x, y, r, g, b)
        else:
            print("Pixel out of bounds: ({}, {})".format(x, y))

    def draw_line(self, x_start, y_start, x_end, y_end, color=(255, 255, 255)):
        try:
            x_start, y_start = float(x_start), float(y_start)
            x_end, y_end = float(x_end), float(y_end)
        except ValueError:
            print("Invalid line coordinates: ({}, {}), ({}, {})".format(
                x_start, y_start, x_end, y_end))
            return

        dx = x_end - x_start
        dy = y_end - y_start

        if dx == 0:
            y_min, y_max = sorted([y_start, y_end])
            for y in range(math.ceil(y_min), math.floor(y_max) + 1):
                self.set_pixel(x_start, y, *color)
        else:
            a = dy / dx
            b = y_start - a * x_start

            if abs(a) <= 1:
                x_min, x_max = sorted([x_start, x_end])
                for x in range(math.ceil(x_min), math.floor(x_max) + 1):
                    y = a * x + b
                    self.set_pixel(x, y, *color)
            else:
                y_min, y_max = sorted([y_start, y_end])
                for y in range(math.ceil(y_min), math.floor(y_max) + 1):
                    x = (y - b) / a
                    self.set_pixel(x, y, *color)


if __name__ == "__main__":
    # Test Programm
    sense = MySenseHat()

    # Testfall 1: Setzen Sie über dieses Objekt das Pixel mit x=4, y=5 auf rot
    sense.set_pixel(4, 5, 255, 0, 0)

    # Testfall 2: Setzen Sie über dieses Objekt das Pixel mit x=8, y=5 auf gruen  ==> was zum Fehler führt
    sense.set_pixel(8, 5, 0, 255, 0)  # Prints ein Error in der Konsole

    # Testfall 3: Dezimal- und String-Werte - Olive Color
    sense.set_pixel(3.7, "2.4", 128, 128, 0)

    # # Testfall 4: Linie zeichnen - Cyan Color
    sense.draw_line(1, 1, 6, 4, (0, 255, 255))

    # # Testfall 5: Vertikale Linie -  Aqua Color
    sense.draw_line(2, 2, 2, 7, (0, 255, 255))

    # # Testfall 6: Steile Linie - Navy Color
    sense.draw_line(1, 1, 3, 7, (0, 0 ,128))
