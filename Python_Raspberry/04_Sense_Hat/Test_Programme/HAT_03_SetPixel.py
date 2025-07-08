#!/usr/bin/python3

from sense_hat import SenseHat
from time import sleep
import math

sense = SenseHat()


sense.clear()

# examples using (x, y, r, g, b)
sense.set_pixel(0, 0, 255, 0, 0)
sleep(0.5)
sense.set_pixel(0, 7, 0, 255, 0)
sleep(0.5)
sense.set_pixel(7, 0, 0, 0, 255)
sleep(0.5)
sense.set_pixel(7, 7, 255, 0, 255)
sleep(0.5)


sense.clear()
red   = (255,   0,   0)
rot   = red
green = (0  , 255,   0)
blue  = (0  ,   0, 255)
gelb  = (255, 255,   0)

# examples using (x, y, pixel)
sense.set_pixel(0, 0, red)
sleep(1)


sense.set_pixel(0, 0, green)
sleep(1)

sense.set_pixel(0, 0, blue)
sleep(1)
sense.clear()


for i in range(0,8):
    sense.set_pixel(0,i,gelb)
    sleep(0.3)

for i in range(0,8):
    sense.set_pixel(i,i,rot)


sleep(5)
sense.clear()
