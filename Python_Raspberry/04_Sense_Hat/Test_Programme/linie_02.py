#!/usr/bin/python3

# Linien zeichnen
# ---------------

from sense_hat import SenseHat
from time import sleep

sense = SenseHat()
sense.clear()

#rote Line waagrecht zuoberst von Rechts nach Links gezeichnet
for i in range(8):
	sense.set_pixel(7-i, 0, 255, 0, 0)
	sleep(0.5)
sleep(2)
sense.clear()
