#!/usr/bin/python3

from sense_hat import SenseHat
from time import sleep

sense = SenseHat()

humidity = sense.get_humidity()
tempH = sense.get_temperature_from_humidity()
temp = sense.get_temperature()
tempP = sense.get_temperature_from_pressure()
pressure = sense.get_pressure()
print("Temp:", temp)
print("TempH:", tempH)
print("TempP:", tempP, "°C")
print("humidity:", humidity, "%")
print("pressure:", pressure, "hPa")


orientation_rad = sense.get_orientation_radians()
print("p: {pitch:3.2f}r, r: {roll:3.2f}r, y: {yaw:3.2f}r".format(**orientation_rad))

orientation = sense.get_orientation_degrees()
print(orientation)
print("p: {pitch:3.2f}°, r: {roll:3.2f}°, y: {yaw:3.2f}°".format(**orientation))