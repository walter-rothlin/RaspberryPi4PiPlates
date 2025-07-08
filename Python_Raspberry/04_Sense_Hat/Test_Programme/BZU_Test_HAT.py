#!/usr/bin/python3

from sense_hat import SenseHat
from time      import sleep

# http://pythonhosted.org/sense-hat/api/#sense-hat-api-reference

def drawLine(aSense,x1=0,y1=0, x2=7,y2=7,r=100,g=100,b=100, delay=0):
    if (x1 == x2):
        if (y1 > y2):
            tmp = y1
            y1 = y2
            y2 = tmp
        for y in range(y1,y2+1):
            aSense.set_pixel(x1,y,r,g,b)
            sleep(delay)
    else:
        a = (y2-y1)/(x2-x1)
        c = y1 - a*x1
        if (x1 > x2):
           tmp = x1
           x1 = x2
           x2 = tmp
        for x in range(x1,x2+1):
           y = round(a*x + c)
           aSense.set_pixel(x,y,r,g,b)
           sleep(delay)


print("Test starts....")
sense = SenseHat()
sense.clear()
drawLine(sense)
sleep(1)

# drawLine(sense,0,7,7,0,255,  0,  0)
# sleep(1)

# drawLine(sense,0,3,7,3,  0,255,  0)
# sleep(1)

# drawLine(sense,1,2,6,2,  0,  0,255)
# sleep(1)

# drawLine(sense,0,0,0,7,255,255,  0)
# sleep(1)

# drawLine(sense,7,1,0,3,255,255,255,0.2)
# sleep(1)

# drawLine(sense,0,7,0,0,255,255,  0,0.3)
# sleep(5)


sense.clear()
drawLine(sense,0,3,7,5,255,255,  0,0.3)
sleep(1)

drawLine(sense,0,0,3,7,255,255,255,0.3)
sleep(5)
sense.clear()
print(".... successfully completed!")




X = [255, 0, 0]      # Red
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
print(".... successfully completed!")