#!/usr/bin/python3

# Linien zeichnen
# ---------------

from sense_hat import SenseHat
from time import sleep

sense = SenseHat()
sense.clear()

#roter Punkt Mitte horizontal Ping-Pong
posX = 0
posY = 3
directionX = 1
directionY = 1
while True:
    sense.clear()
    sense.set_pixel(posX, posY, 255, 0, 0)
    posX += directionX
    posY += directionY
    if posX > 7:
        posX = 6
        directionX *= -1
    elif posX < 0:
        posX = 1
        directionX *= -1

    if posY > 7:
        posY = 6
        directionY *= -1
    elif posY < 0:
        posY = 1
        directionY *= -1

    sleep(0.5)

