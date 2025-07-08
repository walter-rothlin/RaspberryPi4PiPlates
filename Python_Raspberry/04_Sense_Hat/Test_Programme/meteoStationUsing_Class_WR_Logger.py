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
# 20-Apr-2021   Walter Rothlin		Using Class_WR_Logger
# ------------------------------------------------------------------

from sense_hat import SenseHat
from Class_WR_Logger import *
from time import sleep


# Start Main  (Hauptprogramm)
sense = SenseHat()


meteoLogger = WR_Logger("weatherLog.txt", titleStr="Temp  ; Feuchte ; Druck", delimiter=";", onlyChanges=True, ringbufferSize=10)
print(meteoLogger)

while True:
	sense.clear()
	temp = round(sense.get_temperature(), 2)
	feuchte = sense.get_humidity()
	druck = sense.get_pressure()

	logEntryStr = "{T:5.1f}C; {Fe:3.0f}% ; {druck:3.0f}mbar".format(Fe=feuchte, T=temp, druck=druck)
	meteoLogger.addLogEntry(logEntryStr, level="DEBUG")
	sleep(1)
	# sense.show_message(displyStr, scroll_speed=0.2, back_colour=[125, 0, 0], text_colour=[0, 125, 0])
