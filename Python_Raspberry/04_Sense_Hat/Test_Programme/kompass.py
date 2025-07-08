#!/usr/bin/python3

# ------------------------------------------------------------------
# Name: kompass.py
#
# Description: Bewegt ein LED auf der Anzeige immer noch Norden.
# https://github.com/RPi-Distro/python-sense-hat/blob/master/examples/compass.py
#
#
# Autor: Walter Rothlin
#
# History:  
# 17-Apr-2018	Walter Rothlin		Initial Version
# ------------------------------------------------------------------

from sense_hat import SenseHat 

 
# To get good results with the magnetometer you must first calibrate it using 
# the program in RTIMULib/Linux/RTIMULibCal 
# The calibration program will produce the file RTIMULib.ini 
# Copy it into the same folder as your Python code 
 
 
led_loop = [4, 5, 6, 7, 15, 23, 31, 39, 47, 55, 63, 62, 61, 60, 59, 58, 57, 56, 48, 40, 32, 24, 16, 8, 0, 1, 2, 3] 
 
 
sense = SenseHat() 
sense.set_rotation(0) 
sense.clear() 
 
 
prev_x = 0 
prev_y = 0 
dirStrOld = ""
 
led_degree_ratio = len(led_loop) / 360.0 
 
 
while True: 
    dir = sense.get_compass()
    dirStr = "{dir:4.0f}".format(dir=dir)
    if (dirStr != dirStrOld):
        print(dirStr)
    dirStrOld = dirStr
    dir_inverted = 360 - dir  # So LED appears to follow North 
    led_index = int(led_degree_ratio * dir_inverted) 
    offset = led_loop[led_index] 
 
 
    y = offset // 8  # row 
    x = offset % 8  # column 
 
 
    if x != prev_x or y != prev_y: 
        sense.set_pixel(prev_x, prev_y, 0, 0, 0) 

 
    sense.set_pixel(x, y, 0, 0, 255) 

 
    prev_x = x 
    prev_y = y 
