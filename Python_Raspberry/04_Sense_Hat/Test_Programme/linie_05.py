#!/usr/bin/python3

# Linien zeichnen
# ---------------

from sense_hat import SenseHat
from time import sleep

sense = SenseHat()
sense.clear()

#Diagonale in Purple von oben-rechts nach unten-links gezeichnet
for i in range(8):
	sense.set_pixel(i, i, 255, 0, 255)
	sleep(0.5)

#Diagonale in Cyan von unten-links nach oben-rechts gezeichnet
for i in range(8):
	sense.set_pixel(i, 7-i, 0, 255, 255)
	sleep(0.5)

sleep(2)
sense.clear()
