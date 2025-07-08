#!/usr/bin/python3

from sense_hat import SenseHat
import os, sys, thread, math

hat = SenseHat()
running = True

def get_RGB_by_celsius(celsius, minCelsius=0, maxCelsius=40):
	if minCelsius > maxCelsius: raise ValueError("Minimum Celsius (" + str(minCelsius) + ") is bigger thatn Maximum Celsius (" + str(maxCelsius) + ")")
	if celsius > maxCelsius: celsius = maxCelsius
	elif celsius < minCelsius: celsius = minCelsius
	range = maxCelsius - minCelsius
	step = range/4
	
	r = 0
	g = 0
	b = 0
	if celsius <= minCelsius + step*1:
		r = 0
		b = 255
		min = minCelsius + step*0
		advance = celsius - min
		g = ((advance / step) * 255)
	elif celsius <= minCelsius + step*2:
		r = 0
		g = 255
		min = minCelsius + step*1
		advance = celsius - min
		b = 255 - ((advance / step) * 255)
	elif celsius <= minCelsius + step*3:
		b = 0
		g = 255
		min = minCelsius + step*2
		advance = celsius - min
		r = ((advance / step) * 255)
	elif celsius <= minCelsius + step*4:
		b = 0
		r = 255
		min = minCelsius + step*3
		advance = celsius - min
		g = 255 - ((advance / step) * 255)
	
	return {'r':r, 'g':g, 'b':b}


def terminate():
	global running
	raw_input("Press Enter to stop...")
	running = False

thread.start_new_thread(terminate, ())

while running:
	orientation = hat.get_orientation()
	roll = orientation["roll"]
	y = 0
	if roll > 180: roll -= 360
	if roll > 50:
		y = 3
	elif roll < -50:
		y = -3
	else:
		y = int(round(roll / 50 * 3))
	y = y + 3
	
	pitch = orientation["pitch"]
	x = 0
	if pitch > 180: pitch -= 360
	if pitch > 50:
		x = 3
	elif pitch < -50:
		x = -3
	else:
		x = int(round(pitch / 50 * -3))
	x = x + 3
	
	dotColor = get_RGB_by_celsius(hat.get_temperature())
	
	hat.clear()
	hat.set_pixel(x, y, int(dotColor['r']), int(dotColor['g']), int(dotColor['b']))
	hat.set_pixel(x + 1, y, int(dotColor['r']), int(dotColor['g']), int(dotColor['b']))
	hat.set_pixel(x, y + 1, int(dotColor['r']), int(dotColor['g']), int(dotColor['b']))
	hat.set_pixel(x + 1, y + 1, int(dotColor['r']), int(dotColor['g']), int(dotColor['b']))

hat.clear()