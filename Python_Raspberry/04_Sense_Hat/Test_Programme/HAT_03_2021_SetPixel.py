#!/usr/bin/python3

from sense_hat import SenseHat
from time import sleep

sense = SenseHat()
sense.clear(0,50,0)

red = (255, 0, 0)
green = (0, 255,0)
blue = (0, 0, 255)

yellow = (255, 255, 0)
cyan = (0, 255, 255)
magenta = (255, 0, 255)

white = (255, 255, 255)
grey = (100, 100, 100)


# examples using (x, y, r, g, b)
sense.set_pixel(0, 0, 255, 0, 0)
sense.set_pixel(7, 0, 255, 255, 0)
sleep(2.5)
sense.set_pixel(0, 7, 0, 0, 255)
sleep(2.5)

sense.set_pixel(7, 7, cyan)
sense.set_pixel(2, 0, magenta)
sleep(2)
sense.clear()

# horizontale Linie oben
for xCoordinate in range(0, 8):
    sense.set_pixel(xCoordinate, 0, yellow)
    sleep(0.3)

# vertikale Linie rechts
for yCoordinate in range(1, 7):
    sense.set_pixel(7, yCoordinate, blue)
    sleep(0.3)

# horizontale Linie unten   
for xCoordinate in range(0, 8):
    sense.set_pixel(7 - xCoordinate, 7, magenta)
    sleep(0.3) 

# vertikale Linie links
yCoordinate = 6
while yCoordinate > 0:
    sense.set_pixel(0, yCoordinate, green)
    yCoordinate = yCoordinate - 1
    sleep(0.3)

# diagonale unten rechts nach links oben    
yCoordinate = 6
xCoordinate = 6
while yCoordinate > 0:
    sense.set_pixel(xCoordinate, yCoordinate, red)
    yCoordinate -= 1
    xCoordinate -= 1
    sleep(0.5)

# diagonale unten links nach rechts oben    
yCoordinate = 6
xCoordinate = 1
while yCoordinate > 0:
    sense.set_pixel(xCoordinate, yCoordinate, cyan)
    yCoordinate -= 1
    xCoordinate += 1
    sleep(0.5)    

sleep(20)
sense.clear()