#!/usr/bin/python3

from sense_hat import SenseHat
from time      import sleep

# http://pythonhosted.org/sense-hat/api/#sense-hat-api-reference


print("Test starts....")
sense = SenseHat()

X = [100, 100, 0]    # Red
O = [100, 100, 100]  # White

question_mark = [
O, O, O, X, X, O, O, O,
O, O, X, O, O, X, O, O,
O, O, O, O, O, X, O, O,
O, O, O, O, X, O, O, O,
O, O, O, X, O, O, O, O,
O, O, O, X, O, O, O, O,
O, O, O, O, O, O, O, O,
O, O, O, X, O, O, O, O
]

sense.set_pixels(question_mark)
sleep(5)

sense.clear()

# examples using (x, y, r, g, b)
sense.set_pixel(0, 0, 255, 0, 0)
sense.set_pixel(0, 7, 0, 255, 0)
sense.set_pixel(7, 0, 0, 0, 255)
sense.set_pixel(7, 7, 255, 0, 255)

red = (255, 0, 0)
green = (0, 255, 0)
blue = (0, 0, 255)

# examples using (x, y, pixel)
sense.clear()
sleep(1)
sense.set_pixel(1, 0, red)
sleep(1)
sense.set_pixel(2, 0, green)
sleep(1)
sense.set_pixel(3, 0, blue)

sleep(5)
sense.clear()
print(".... successfully completed!")