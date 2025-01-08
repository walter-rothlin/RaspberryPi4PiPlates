#!/usr/bin/python3

from sense_hat import SenseHat

class MySenseHat(SenseHat):
    
    def __init__(self):
        super().__init__()

    def range_check(self, value, min=0, max=7):
        return min <= value <= max

    def set_pixel(self, x_pos, y_pos, r, g, b):
        try:
            x_pos = float(x_pos)
            y_pos = float(y_pos)
        except:
            return

        x_pos = round(x_pos)
        y_pos = round(y_pos)
        if self.range_check(x_pos) and self.range_check(y_pos):
            super().set_pixel(x_pos, y_pos, r, g, b)

