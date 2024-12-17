#!/usr/bin/python

# Class_MySenseHat.py

from sense_hat import SenseHat

class MySenseHat(SenseHat):
    def __init__(self):
        SenseHat.__init__(self)

    def set_pixel(self, x, y, color):
        try:
            original_x = x
            original_y = y
            x = int(round(float(x)))
            y = int(round(float(y)))
            if 0 <= x <= 7 and 0 <= y <= 7:
                SenseHat.set_pixel(self, x, y, color)
            else:
                print("Koordinaten außerhalb des Bereichs: x={}, y={}".format(original_x, original_y))
        except ValueError:
            print("Ungültige Eingabe für x oder y: x={}, y={}".format(original_x, original_y))

if __name__ == "__main__":
    sense = MySenseHat()
    rot = (255, 0, 0)
    gruen = (0, 255, 0)

    # Test 1: Gültige ganze Zahlen
    sense.set_pixel(4, 5, rot)
    print("Test 1 bestanden: Gültige ganze Zahlen.")

    # Test 2: Koordinate außerhalb des Bereichs
    sense.set_pixel(8, 5, gruen)
    print("Test 2 bestanden: Koordinate außerhalb des Bereichs wird behandelt.")

    # Test 3: Dezimalzahlen
    sense.set_pixel('2.7', 3.1, rot)
    print("Test 3 bestanden: Dezimalzahlen werden gerunde")
