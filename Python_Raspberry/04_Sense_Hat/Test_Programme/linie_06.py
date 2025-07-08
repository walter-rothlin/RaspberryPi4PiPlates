#!/usr/bin/python3

# Linien zeichnen
# ---------------

from sense_hat import SenseHat
from time import sleep

sense = SenseHat()
sense.clear()

#roter Punkt Mitte horizontal Ping-Pong
pos = 0
direction = 1
while True:
	sense.clear()
	sense.set_pixel(pos, 3, 255, 0, 0)
	pos += direction
	if pos > 7:
		pos = 6
		direction *= -1
	if pos < 0:
		pos = 1
		direction *= -1
	sleep(0.5)

