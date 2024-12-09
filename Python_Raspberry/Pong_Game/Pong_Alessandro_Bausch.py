#!/usr/bin/python3

# Filename: Pong_Alessandro_Bausch.py
# Source  : https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_Raspberry/Pong_Game/Pong_Alessandro_Bausch.py

# Imports
#----------------------
from sense_hat import SenseHat, ACTION_PRESSED, ACTION_HELD, ACTION_RELEASED
from signal import pause
from time import sleep 

# Definitionen
#----------------------
xBall = 3
yBall = 3
xSchleg = 0
ySchleg = 3
Speed = 0.5
sense = SenseHat()

red = (255,0,0)
green = (0,255,0)
blue = (0,0,255)
yellow = (255,255,0)
mangenta = (255,0,255)
cyan = (0,255,255)
white = (255,255,255)
grey = (100,100,100)
black = (0,0,0)

bgcSchleg = red
bgcBall=grey
# function definitions
# --------------------
def clamp(value, min_value=0, max_value=7):     #LED-Matrix Koordinatenlimitierung
    return min(max_value, max(min_value, value))
def clampSchleg(value, min_value=(-1), max_value=8):  #Angepasste Koordinatenlimitierung für den Schläger   
    return min(max_value, max(min_value, value))
def set_pixel_bzu(x, y, pixel):         #Funktion zum eigene Pixel zu erstellen
    x = int(round(x,0))
    y = int(round(y,0))
    if((x >= 0 and x <= 7) and
       (y >= 0 and y <= 7)):
       sense.set_pixel(x, y, pixel)    
def pushed_up(event):                   #Funktion zur Bewegung des Schläger
    global ySchleg
    if event.action != ACTION_RELEASED:
        ySchleg = clampSchleg(ySchleg - 1)
def pushed_down(event):                 #Funktion zur Bewegung des Schläger
    global ySchleg
    if event.action != ACTION_RELEASED:
        ySchleg = clampSchleg(ySchleg + 1)
             
    
# Flags Voreinstellungen
#----------------------   
Loop = True
XReverseFlag = False
YReverseFlag = False
YStraightFlag = False
sense.clear()

# Main Loop
#----------------------
while (Loop==True):
# Ball
#----------------------
    if (XReverseFlag == False):     #Ballbewegung auf der X-Achse
        xBall = clamp(xBall + 1)
    elif (XReverseFlag == True):
        xBall = clamp(xBall -1)
    else:
        Loop = False
    if(YStraightFlag == True):      #Ballbewegung auf der Y-Achse
        yBall = clamp(yBall)
    elif (YReverseFlag == False):
        yBall = clamp(yBall + 1)              
    elif (YReverseFlag == True):
        yBall = clamp(yBall - 1)
    else:
        Loop = False
    if (xBall == 7):                #Wandberührung rechts
        XReverseFlag = True
        YStraightFlag = False
    if (xBall == 0):                #Wandberührung links & Geschwindigkeits erhöhung
        XReverseFlag = False
        Speed = Speed * 0.9
    if (yBall == 7):                #Wandberührung oben
        YReverseFlag = True
    if (yBall == 0):                #Wandberührung unten 
        YReverseFlag = False
    if (Speed < 0.05):              #Geschwindigkeits Limitierung
        Speed = 0.05
#Schläger & Interakionen
#-----------------------
    if (ySchleg > 8):           #Abfangen von zu hohen Schlägerwerten
        ySchleg = 8
    if (ySchleg <(-1)):
        ySchleg = (-1)
    if (xSchleg == xBall):      #Interakion von Schläger und Ball
        XReverseFlag = False
        if(yBall == ySchleg):   #Interakion in mitte des Schlägers
            YStraightFlag = True
            xBall= xBall+1
        elif(yBall == (ySchleg - 1)):   #Interakion unten am Schläger
            YReverseFlag = True
            xBall= xBall+1
        elif(yBall == (ySchleg + 1)):   #Interakion oben am Schläger
            YReverseFlag = False
            xBall= xBall+1
        if xBall == 0:          #Ball im Aus
           Loop = False
           
# Anzeige & Darstellung
#------------------------
    sense.clear()
    set_pixel_bzu(xBall, yBall, bgcBall)            #Ballanzeige
    if(ySchleg >= 0 and ySchleg <= 7):              #Schlägeranzeige ohne Clippen
        set_pixel_bzu(xSchleg, ySchleg, bgcSchleg)
        set_pixel_bzu(xSchleg, ySchleg-1, bgcSchleg)
        set_pixel_bzu(xSchleg, ySchleg+1, bgcSchleg)
    elif(ySchleg > 7):                              #Schlägeranzeige Clipping oben
        set_pixel_bzu(xSchleg, ySchleg-1, bgcSchleg)
    elif(ySchleg < 0):                              #Schlägeranzeige Clipping unten
        set_pixel_bzu(xSchleg, ySchleg+1, bgcSchleg)
    sleep(Speed)                                    #Geschwindigkeit
    sense.stick.direction_up = pushed_up            #Verknüpfung Stick-Inputs mit Funktionen
    sense.stick.direction_down = pushed_down