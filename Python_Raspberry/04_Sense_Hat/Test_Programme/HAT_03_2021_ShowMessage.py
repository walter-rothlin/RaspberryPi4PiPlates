#!/usr/bin/python3

from sense_hat import SenseHat
from time import sleep

sense = SenseHat()
sense.clear(50, 50, 0)
sense.show_message("Ha", 0.5, (255, 0, 0), (0, 10, 10))

sense.show_message("BZU", back_colour=(10, 10, 10), text_colour=(0, 255, 0))
sense.show_letter("?")
sleep(3)


X = [255, 0, 0]      # Red
O = [50, 50, 50]     # Grey
i = [0, 255, 0]      # Green

question_mark = [
i, O, O, X, X, O, O, i,
O, O, X, O, O, X, O, O,
O, O, O, O, O, X, O, O,
O, O, O, O, X, O, O, O,
O, O, O, X, O, O, O, O,
O, O, O, X, O, O, O, O,
O, O, O, O, O, O, O, O,
i, O, O, X, O, O, O, i
]

sense.set_pixels(question_mark)
sleep(3)
sense.clear()

sense.show_letter("!")
sleep(3)
sense.set_rotation(90)
sleep(3)
sense.set_rotation(180)
sleep(3)
sense.set_rotation(270)
sleep(3)
sense.clear()

sense.set_rotation(0)
sense.show_letter("G")
sleep(3)
sense.flip_h()
sleep(3)
sense.flip_h()
sleep(3)
sense.flip_v()
sleep(3)
sense.flip_v()
sleep(3)
sense.clear()