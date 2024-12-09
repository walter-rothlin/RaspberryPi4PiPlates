#!/usr/bin/python3


# Filename: Pong_Silvan_Braendli.py
# Source  : https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_Raspberry/Pong_Game/Pong_Silvan_Braendli.py


"""
Silvan Brändli
11.07.2023
BFSU Uster

Version:
v0.1         11.7.2023           Erstellung

"""



from sense_hat import SenseHat, ACTION_PRESSED, ACTION_HELD, ACTION_RELEASED
from signal import pause
sense = SenseHat()
import time

sense.clear()

#Trajectory and start values
x = 2
y = 2
mx = 1
my = 0.85

#Other Variables
ledX = 0
ledY = 0
score = 0
speed = 0.3
location = 3

#Booleans
stateX = False
stateY = False

#Colors
green = 0,255,0
red = 255,0,0

#Functions
#================================

def speedMap(value): #Determines the speed given the score (lower speed = faster)
    input_min = 0
    input_max = 40
    output_min = 0.3
    output_max = 0.1

    mapped_value = ((value - input_min) * (output_max - output_min) / (input_max - input_min)) + output_min
    if mapped_value <= 0.1:
        mapped_value = 0.1
        
    return mapped_value


#Calculate Pixel values
def addX(xTemp, mx):
    xTemp = xTemp + mx
    return xTemp
    
def negateX(xTemp, mx):
    xTemp = xTemp - mx
    return xTemp
    
def addY(yTemp, mx):
    yTemp = yTemp + my
    return yTemp
    
def negateY(yTemp, my):
    yTemp = yTemp - my
    return yTemp
    
#Joystick events
def pushed_up(event):
    global location
    if event.action != ACTION_RELEASED:
        location = location - 1
        return location
        
def pushed_down(event):
    global location
    if event.action != ACTION_RELEASED:
        location = location + 1
        return location
   
#Game over function   
def gameOver():
    global score
    global location
    global speed
    sense.clear(red)
    time.sleep(0.15)
    sense.clear()
    time.sleep(0.15)
    sense.clear(red)
    time.sleep(0.15)
    sense.clear()
    time.sleep(0.25)
    print('=============================')
    print('Your score was: ' ,score)
    print('The Speed was:  ' ,round(1/speed, 3), 'pixer per second')
    print('=============================')
    
    sense.show_message(str(score))
    score = 0
    location = 3
    time.sleep(0.5)
    for i in range(0, 3):
        sense.set_pixel(0, i+location, (red))
    time.sleep(1)
#===================================
    
#Running loop code
while True:

    if x <= 1:  #Ball bounces
        stateX = False
        score += 1
        print('Score: ', score)
    if x >= 7:
        stateX = True
    if y <= 1:
        stateY = False
    if y >= 7:
        stateY = True

        
    #Check for Wall hit
    if stateX == True:
        x = negateX(x, mx)
    elif stateX == False:
        x = addX(x, mx)
        
    if stateY == True:
        y = negateY(y, my)
    elif stateY == False:
        y = addY(y, my)

    #Round value to int
    ledX = round(x)
    ledY = round(y)
    #Avoid exeeding allowed sense Hat values
    if ledX <= 0:
        ledX = 0
    if ledX >= 7:
        ledX = 7
    if ledY <= 0:
        ledY = 0
    if ledY >= 7:
        ledY = 7
    #Clear, then write
    sense.clear()
    sense.set_pixel(ledX, ledY, (green))
    
    #set Bat boundries
    if location >= 5:
        location = 5
    if location <= 0:
        location = 0
    
    #Draw bat
    for i in range(0, 3):
        sense.set_pixel(0, i+location, (red))
    
    #Check for game Over
    if ledX == 1:
        if ledY != location and (ledY-1) != location and (ledY-2) != location:
            gameOver()
    
    
    
    #Speed
    speed = speedMap(score)
    time.sleep(speed)
    
    #Check for Joystick input
    sense.stick.direction_up = pushed_up
    sense.stick.direction_down = pushed_down