#!/usr/bin/python3


# Filename: Pong_Unknown.py
# Source  : https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_Raspberry/Pong_Game/Pong_Unknown.py

from sense_hat import SenseHat, ACTION_PRESSED, ACTION_HELD, ACTION_RELEASED
from time import sleep
import random

random.seed()

T_REFRESH = 0.5
SPEED_INCREASE = 0.9

BG_COLOR = (0, 0, 0)
FG_COLOR = (255, 255, 255)
BALL_COLOR = (0, 255, 255)
GAME_OVER_COLOR = (255, 0, 0)

PlayerPos = 2
PLAYER_POS_MIN = 0
PLAYER_POS_MAX = 7
PLAYER_SIZE = 3

BallX = 1
BallY = random.randint(0, 7)

Xdir = 1
Ydir = 1

SHat = SenseHat()
SHat.clear()

startCycle = True;

Score = 0

def DrawVHLine(x, y, Horizontal, LineLength, Color):
	global SHat
	for offset in range(LineLength):
		if (Horizontal == 1):
			SHat.set_pixel(x + offset, y, Color)
		else:
			SHat.set_pixel(x, y + offset, Color)

def FillBG(Color):
	global SHat
	for x in range(8):
		for y in range(8):
			SHat.set_pixel(x, y, Color)

def RestartGame(event):
	global SHat, PlayerPos, BallX, T_REFRESH, Score, startCycle
	if(event.action != ACTION_RELEASED):
		T_REFRESH = 0.5
		PlayerPos = 2
		BallX = random.randint(0, 7)
		startCycle = True
		Score = 0

def PlayerUp(event):
	global PlayerPos, FG_COLOR, BG_COLOR, PLAYER_SIZE, PLAYER_POS_MIN
	if(event.action != ACTION_RELEASED):
		if(PlayerPos > PLAYER_POS_MIN):
			DrawVHLine(0, PlayerPos, 0, PLAYER_SIZE, BG_COLOR)
			PlayerPos -= 1
			DrawVHLine(0, PlayerPos, 0, PLAYER_SIZE, FG_COLOR)

def PlayerDown(event):
	global PlayerPos, FG_COLOR, BG_COLOR, PLAYER_SIZE, PLAYER_POS_MAX
	if(event.action != ACTION_RELEASED):
		if(PlayerPos < (PLAYER_POS_MAX - PLAYER_SIZE + 1)):
			DrawVHLine(0, PlayerPos, 0, PLAYER_SIZE, BG_COLOR)
			PlayerPos += 1
			DrawVHLine(0, PlayerPos, 0, PLAYER_SIZE, FG_COLOR)

SHat.stick.direction_up = PlayerUp
SHat.stick.direction_down = PlayerDown
SHat.stick.direction_middle = RestartGame

FillBG(BG_COLOR)

DrawVHLine(0, PlayerPos, 0, PLAYER_SIZE, FG_COLOR)
SHat.set_pixel(BallX, BallY, BALL_COLOR)

while True:
	sleep(T_REFRESH)
	#Remove old ball
	SHat.set_pixel(BallX, BallY, BG_COLOR)
	#Refresh ball direction
	if (BallX == 7):
		Xdir = 0
	elif (BallX == 1):
		Xdir = 1
		T_REFRESH *= SPEED_INCREASE
	if (BallY == 7):
		Ydir = 0
	elif (BallY == 0):
		Ydir = 1
	#Check if Ball hit the player
	BallPlayerDelta = BallY - PlayerPos
	if (((BallX > 1) or ((BallPlayerDelta <= (PLAYER_SIZE - 1)) and (BallPlayerDelta >= 0))) or (startCycle == True)):
		startCycle = False
		#Refresh ball position
		BallX += 2 * Xdir - 1
		BallY += 2 * Ydir - 1
		#Draw new Ball
		SHat.set_pixel(BallX, BallY, BALL_COLOR)
		if (BallX == 1):
			Score += 1
	else:
		FillBG(GAME_OVER_COLOR)
		while True:
			SHat.show_message("Game Over! Score: " + str(Score), scroll_speed=0.075, text_colour=FG_COLOR, back_colour=GAME_OVER_COLOR)
			if(startCycle == True):
				FillBG(BG_COLOR)
				DrawVHLine(0, PlayerPos, 0, PLAYER_SIZE, FG_COLOR)
				SHat.set_pixel(BallX, BallY, BALL_COLOR)
				break;
