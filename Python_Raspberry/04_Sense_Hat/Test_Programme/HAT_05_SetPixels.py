#!/usr/bin/python3

from sense_hat import SenseHat
from time import sleep

sense = SenseHat()

X = [125, 125,   0]    # Red
Y = [0  , 125, 125]    # Cyan
O = [50 ,  50,  50]    # White
B = [0  ,   0,   0]    # Black

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

print("flip_h")
sense.flip_h(redraw=True)
sleep(5)

print("flip_v")
sense.flip_v(redraw=True)
sleep(5)

x_mark = [
Y, O, O, O, O, O, O, X,
O, Y, O, O, O, O, X, O,
O, O, Y, O, O, X, O, O,
O, O, O, Y, X, O, O, O,
O, O, O, X, Y, B, B, B,
O, O, X, O, O, Y, O, O,
O, X, O, O, O, O, Y, O,
X, O, O, O, O, O, O, Y
]

sense.set_pixels(x_mark)
sleep(5)

sense.clear()