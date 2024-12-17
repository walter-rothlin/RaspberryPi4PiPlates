#!/usr/bin/python3

from sense_hat import SenseHat
from time import sleep
from random import randint

white = (255, 255, 255)
red = (255, 0, 0)
green = (0, 255, 0)
blue = (0, 0, 255)
yellow = (255, 255, 0)
grey = (64, 64, 64)


class MySenseHat(SenseHat):
    
    def __init__(self):
        super().__init__()

    def range_check(self, value, min=0, max=7):
        return min <= value <= max

    def set_pixel(self, x_pos, y_pos, color):
        try:
            x_pos = float(x_pos)
            y_pos = float(y_pos)
        except:
            return

        x_pos = round(x_pos)
        y_pos = round(y_pos)
        if self.range_check(x_pos) and self.range_check(y_pos):
            super().set_pixel(x_pos, y_pos, color)

    def draw_line(self, x_start, y_start, x_end, y_end, color=grey):
        
        [x_start, x_end] = sorted([x_start, x_end])
        [y_start, y_end] = sorted([y_start, y_end])

        x_start = 0 if x_start < 0 else x_start == 7 if x_start > 7 else x_start
        y_start = 0 if y_start < 0 else y_start == 7 if y_start > 7 else x_start

        dx = x_end - x_start
        dy = y_end - y_start
        
        if dx > dy:
            y = y_start
            for x in range(x_start, x_end+1):
                if (x+1)%int(dx/(dy-1)) == 0: y += 1
                self.set_pixel(x, y, color)
        else: 
            x = x_start
            for y in range(y_start, y_end+1):
                if y%int(dy/dx): x += 1
                self.set_pixel(x, y, color)

        print(f"x_start: {x_start}, y_start: {y_start}, x_end: {x_end}, y_end: {y_end}, dx: {dx}, dy: {dy}")
    


if __name__ == '__main__':
    sense = MySenseHat()
    sense.low_light = True
    sense.clear()
    sleep(1)

    # Test mit vier grüne Punkte im gültigen Bereich, 
    # keine roten Punkte, kein Abbruch
    sense.set_pixel(4, 5, green)
    sense.set_pixel(0, 7, green)
    sense.set_pixel(7, 7, green)
    sense.set_pixel(7, 0, green)
    sense.set_pixel(-1, 0, red)
    sense.set_pixel(8, 5, red)
    sense.set_pixel(0, -1, red)
    sense.set_pixel(0, 8, red)

    # Test mit Dezimalzahlen
    sense.set_pixel(0.8, 1.4, blue)
    sense.set_pixel(6.45, 5.5, blue)

    # Test mit Stings
    sense.set_pixel('2', '2', yellow)
    sense.set_pixel('5.1', '2.4', yellow)

    sleep(2)
    sense.clear()

    # Teste Zeichen von Linien
    sense.draw_line(0, 0, 7, 2, green)
    sense.draw_line(0, 0, 7, 7, green)
    sense.draw_line(0, 0, 7, 4, green)
    sense.draw_line(0, 0, 3, 7, green)

    sleep(2)
    sense.clear()
    sense.draw_line(0, 3, 7, 3, yellow)








