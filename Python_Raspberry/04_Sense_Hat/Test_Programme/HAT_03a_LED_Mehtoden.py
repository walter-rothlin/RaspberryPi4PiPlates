#!/usr/bin/python3

from sense_hat import SenseHat
import time

sense_hat = SenseHat()

black = (0, 0, 0)
red = (255,0,0)
green = (0,255,0)
blue = (0,0,255)
magenta = (255,0 ,255)
cyan = (0, 255, 255)
yellow = (255, 255, 0)
white = (255, 255, 255)

sense_hat.clear(white)
time.sleep(2)
sense_hat.set_pixel(0,0,black)
sense_hat.set_pixel(1,0,green)
sense_hat.set_pixel(2,0,blue)
sense_hat.set_pixel(0,1,magenta)
sense_hat.set_pixel(1,1,cyan)
sense_hat.set_pixel(2,1,yellow)
sense_hat.set_pixel(7,7,sense_hat.get_pixel(0, 0))


time.sleep(2)
sense_hat.clear(white)
X = yellow
O = black
_ = white

question_mark = [
_, _, _, X, X, _, _, _,
O, O, X, O, O, X, O, O,
O, O, O, O, O, X, O, O,
O, O, O, O, X, O, O, O,
O, O, O, X, O, O, O, O,
O, O, O, X, O, O, O, O,
O, O, O, O, O, O, O, O,
_, _, _, X, _, _, _, _
]

sense_hat.set_pixels(question_mark)

time.sleep(2)
sense_hat.clear(black)
sense_hat.show_message("One small step for Pi!", text_colour=red, back_colour=white)

time.sleep(2)
sense_hat.clear(black)
sense_hat.show_letter('E', text_colour=red, back_colour=white)
time.sleep(1)
sense_hat.set_rotation(0)
time.sleep(1)
sense_hat.set_rotation(90)
time.sleep(1)
sense_hat.set_rotation(180)
time.sleep(1)
sense_hat.set_rotation(270)
time.sleep(5)


sense_hat.set_rotation(0)
for i in [1, "2", "A", 'B', 'X' , 6, '7']:
    sense_hat.show_letter(str(i), text_colour=red, back_colour=white)
    time.sleep(1)