#!/usr/bin/python3

from sense_hat import SenseHat
from time import sleep


print("Hallo ggggg")


sense = SenseHat()
sense.clear()
sleep(1)
# Rotes LED anzuenden
sense.set_pixel(0, 0, 255, 0, 0)
sense.set_pixel(1, 0, 255, 0, 0)
sense.set_pixel(2, 0, 255, 0, 0)
sense.set_pixel(3, 0, 255, 0, 0)
sense.set_pixel(4, 0, 255, 0, 0)
sense.set_pixel(5, 0, 255, 0, 0)
sense.set_pixel(6, 0, 255, 0, 0)
sense.set_pixel(7, 0, 255, 0, 0)
sleep(1)

# Grünes LED anzuenden
sense.set_pixel(7, 1, 0, 255, 0)
sense.set_pixel(7, 2, 0, 255, 0)
sense.set_pixel(7, 3, 0, 255, 0)
sense.set_pixel(7, 4, 0, 255, 0)
sense.set_pixel(7, 5, 0, 255, 0)
sense.set_pixel(7, 6, 0, 255, 0)
sleep(1)

# Blaues LED anzuenden
sense.set_pixel(0, 1, 0, 0, 255)
sense.set_pixel(0, 2, 0, 0, 255)
sense.set_pixel(0, 3, 0, 0, 255)
sense.set_pixel(0, 4, 0, 0, 255)
sense.set_pixel(0, 5, 0, 0, 255)
sense.set_pixel(0, 6, 0, 0, 255)
sleep(1)

# Gelbes LED anzuenden
sense.set_pixel(0, 7, 255, 255, 0)
sense.set_pixel(1, 7, 255, 255, 0)
sense.set_pixel(2, 7, 255, 255, 0)
sense.set_pixel(3, 7, 255, 255, 0)
sense.set_pixel(4, 7, 255, 255, 0)
sense.set_pixel(5, 7, 255, 255, 0)
sense.set_pixel(6, 7, 255, 255, 0)
sense.set_pixel(7, 7, 255, 255, 0)

sleep(5)
sense.clear()


X = [255, 0, 0]  # Red
O = [255, 255, 255]  # White

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
sense.show_message("One small step for Pi!", text_colour=[255, 0, 0])

sleep(5)
sense.clear()