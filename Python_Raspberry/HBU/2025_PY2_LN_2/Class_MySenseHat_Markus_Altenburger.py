#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# ====================================
# Autor: Markus Altenburger
# Erstellt am: 2025-10-01
# Beschreibung: Beschreibung des Skripts
# ====================================
from sense_hat import SenseHat

class MySenseHat(SenseHat):
    def __init__(self):
        super().__init__()
        self.sense = SenseHat()
        self.width = 8
        self.height = 8
    def chkValue(self,value):
        if isinstance(value, int):
            return value
        elif isinstance(value, str):
            try:
                num = float(value)     
                num =round(num)
                return num
            except ValueError:
                return None  # String war keine Zahl (z. B. 'hallo')
           
     
    def clear(self):
        self.sense.clear()

    def set_pixel(self, x, y, color):
        orig_x = x
        orig_y = y
        try:
            x = self.chkValue(x)
            y = self.chkValue(y)
            if 0 <= x < self.width and 0 <= y < self.height:
                self.sense.set_pixel(x, y, color)
                print(f"Set pixel at ({x}, {y}) to color {color}.")
            else:
                print(f"Error: Pixel-Koordinaten ({x}, {y}) ausserhalb des gueltigen Bereichs.")
        except:
            print(f"Die Werte {orig_x}, {orig_y} sind ungültig.")

    def draw_line(self, x_start, y_start, x_end, y_end, color):
            # Sonderfall: vertikale Linie
            if x_start == x_end:
                y_min, y_max = sorted([y_start, y_end]) # y_min ist der kleinere Wert.sorted = Sortieren von klein nach gross
                for y in range(y_min, y_max + 1):
                    self.set_pixel(x_start, y, color)
                return

            # Steigung a und Achsenabschnitt b
            a = (y_end - y_start) / (x_end - x_start)
            b = y_start - a * x_start

            # Fall 1: flache Steigung (|a| <= 1) → über x iterieren
            if abs(a) <= 1:
                x_min, x_max = sorted([x_start, x_end])
                for x in range(x_min, x_max + 1):
                    y = round(a * x + b)
                    self.set_pixel(x, y, color)

            # Fall 2: steile Steigung (|a| > 1) → über y iterieren
            else:
                self.draw_line_bres(x_start, y_start, x_end, y_end, color)
                y_min, y_max = sorted([y_start, y_end])
                for y in range(y_min, y_max + 1): #zum vergleich
                    x = round((y - b) / a)
                    self.set_pixel(x, y, (255, 0, 0))
    # Linie mit Bresenham-Algorithmus
    def draw_line_bres(self, x0, y0, x1, y1, color):
        dx = abs(x1 - x0)
        dy = abs(y1 - y0)
        sx = 1 if x0 < x1 else -1
        sy = 1 if y0 < y1 else -1
        err = dx - dy

        while True:
            self.set_pixel(x0, y0, color)
            if x0 == x1 and y0 == y1:
                break
            e2 = 2 * err
            if e2 > -dy:
                err -= dy
                x0 += sx
            if e2 < dx:
                err += dx
                y0 += sy

if __name__ == "__main__":
    from class_MySenseHat import MySenseHat
    sense = MySenseHat()
    sense.clear()
     
    sense.set_pixel(0, 0, (255, 200, 0))  #nullpunkt
    #sense.set_pixel(4, 5, (255, 0, 0)) # Punkt 2.1
    sense.set_pixel(8, 5, (255, 255, 0))    # Punkt 2.2.1
    sense.set_pixel('6.1', '5', (255, 0, 0)) # Punkt 2.2.2
    sense.set_pixel('3', '3', (255, 255, 0))  # Punkt 2.2.3
    sense.set_pixel('test', '5', (255, 0, 0)) # Punkt 2.2.3
    #sense.draw_line(0, 0, 7, 7, (0, 255, 0))  # Diagonale
    #sense.draw_line(0, 0, 10, 10, (255, 255, 255))  # Diagonale mit Werten ausserhalb des Bereichs
    #sense.draw_line(0, 7, 3, 0, (0, 0, 255))  # flache Steigung
    #sense.draw_line(0, 0, 7, 2, (0, 0, 255))  # steile Steigung
    #sense.draw_line(0, 5, 7, 5, (255, 255, 255))  # Horizontale Linie
    #ense.draw_line(3, 0, 3, 7, (255, 0, 255))  # Vertikale Linie
    
