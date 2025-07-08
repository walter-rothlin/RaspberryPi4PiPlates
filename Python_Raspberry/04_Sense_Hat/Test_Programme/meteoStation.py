#!/usr/bin/python3

# ------------------------------------------------------------------
# Name: meteoStation.py
#
# Description: Zeigt Luftdruck, Temperatur und Luftfeuchtigkeit
#              auf dem Pixel-Display an
#
# Autor: Walter Rothlin
#
# History:  
# 10-Apr-2018	Walter Rothlin		Initial Version
# 13-Apr-2021   Walter Rothlin		Refactoring
# ------------------------------------------------------------------

from sense_hat import SenseHat
from time import sleep


# Start Main  (Hauptprogramm)
sense = SenseHat()
while True:
	sense.clear()
	temp = round(sense.get_temperature(), 2)
	feuchte = sense.get_humidity()
	druck = sense.get_pressure()
	displyStr = "Temp:{T:4.1f}C Feuchte:{Fe:3.0f}% Druck:{druck:3.0f}mbar".format(Fe=feuchte, T=temp, druck=druck)
	print(displyStr)
	sense.show_message(displyStr, scroll_speed=0.2, back_colour=[125, 0, 0], text_colour=[0, 125, 0])




	


