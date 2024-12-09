#!/usr/bin/python3


# Filename: Pong_Genc_Hasanaj.py
# Source  : https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_Raspberry/Pong_Game/Pong_Genc_Hasanaj.py


from sense_hat import SenseHat
from time import sleep
from library_gh import *

sense = SenseHat()
sense.clear()



#Variable Definitionen
#---------------------------------------------------

red = (255, 0, 0)
green = (0, 255, 0)
blue = (0, 0, 255)
yellow = (255, 255, 0)
magenta = (255, 0, 255)
cyan = (0, 255, 255)
white = (255, 255, 255)
gray = (100,100,100)
black = (0,0,0)


#Win Lose Conditions
#---------------------------------------------------
LCon = False

#Game Speed Difficulty
#---------------------------------------------------
diff_t = 0.2

def GSpeed (diff_t=0.5):
    sleep(diff_t)



#Functions
#---------------------------------------------------

#calc_steigung(x_start,y_start,x_end,y_end):                                          # m = (y1-y2)/(x1-x2)
#calc_yAchssenabschnitt(x_start,y_start,x_end,y_end):                                 # b = y1-m*x1
#calc_linFct (x, m, b):                                                               # y=m*x + b
#calc_linFct_with_P1P2(x,x_start,y_start,x_end,y_end):

#Functions Sense Hat
#--------------------------------------------------

#set_pixel_bap(x,y, pixel):
#draw_line_horizontal(row_nr=1, fg_color=red, start_x=1, end_x=8):
#draw_line_vertical(column_nr=1, fg_color=blue, start_y=1, end_y=8):
#draw_line_bap(x_start=1,y_start=1,x_end=8,y_end=8,fg_color=magenta):







#Preparing Coordinate Positions
#----------------------------------------------------
Pstart_y=1
Pend_y=3
Pong_x = 7
Pong_y = 3
Pongdir_x = 1
Pongdir_y = 1
CountWH = 0
DifficultyDir = 1
DifficultySpeed = 2




def player_paddle(Pstart_y=1,Pend_y=3):
    #if Pend_y > Pstart_y + 1 and Pend_y < Pstart_y + 3:
    draw_line_vertical(1,red,Pstart_y,Pend_y)
    return (Pstart_y,Pend_y)
    print ("Paddle working")

def move_paddle(event):
    global Pstart_y, Pend_y
    
    if event.action == 'pressed':
        if event.direction == 'up':
            if Pstart_y > -1:
                Pstart_y -= 1
                Pend_y -= 1
        elif event.direction == 'down':
            if Pend_y < 10:
                Pstart_y += 1
                Pend_y += 1



#def Ping_Pong():



#Pong movement

while not LCon:

    sense.stick.direction_up = move_paddle
    sense.stick.direction_down = move_paddle


    #Drawing Pong
    sense.clear()
    player_paddle(Pstart_y,Pend_y)
    set_pixel_bap(Pong_x,Pong_y,white)
 #   if Pongstart_y == 0:                                    # Wall collision turning coordinate to negative (is not gonna work with directions maybe)
  #      Pongstart_y == +Pongstart_y
    
    
  #  if Pongstart_y == 7:                                    # Wall collision turning coordinate to negative (is not gonna work with directions maybe)
   #     Pongstart_y == -Pongstart_y



    if Pong_x >= 7:
        Pongdir_x = -Pongdir_x
 #   if Pong_x < 0:
        #LCon = True
    if (Pong_y <= Pend_y - 1 and Pong_y >= Pstart_y -1) and Pong_x == 1:
        Pongdir_x = -Pongdir_x
        #LCon = True
        #print ("You Lose")
    if not 0 < Pong_y  < 7:
        Pongdir_y = -Pongdir_y
    if Pong_x == 7:
        CountWH += 1
        print ('Wall Hits :', CountWH)

    if  round (CountWH / 10) > DifficultyDir:
        
    if  round (CountWH / 10) > DifficultySpeed:




    print (Pongdir_x)

    Pong_y += Pongdir_y                                #Vertical Movement
    Pong_x += Pongdir_x    #Horizontal Movement
    GSpeed (diff_t)
    