#!/usr/bin/python3

# ------------------------------------------------------------------
# Name: showIP.py
#
# Description: Zeigt IP Adresse auf dem SenseHat
#
# Autor: Walter Rothlin
# For Autostart:
#    crontab -e
#    @reboot /usr/bin/python3 ~/bin/showIP.py
#
# History:
# 18-Jun-2024   Walter Rothlin      Initial Version
# 08-Jul-2025   Walter Rothlin      Fixed issues
# ------------------------------------------------------------------
from time      import sleep
from datetime  import *
from sense_hat import SenseHat
import os
import sys
from clone_repo import *

red      = [255,   0,   0]
green    = [  0, 255,   0]
blue     = [  0,   0, 255]
yellow   = [255, 255,   0]
mangenta = [255,   0, 255]
cyan     = [  0, 255, 255]
black    = [  0,   0,   0]
white    = [255, 255, 255]
grey     = [100, 100, 100]


def draw_question_mark(fg_color=red, bg_color=black):
    X = fg_color
    _ = bg_color

    question_mark = [
    _, _, _, X, X, _, _, _,
    _, _, X, _, _, X, _, _,
    _, _, _, _, _, X, _, _,
    _, _, _, _, X, _, _, _,
    _, _, _, X, _, _, _, _,
    _, _, _, X, _, _, _, _,
    _, _, _, _, _, _, _, _,
    _, _, _, X, _, _, _, _
    ]

    sense.set_pixels(question_mark)

def draw_sanduhr(fg_color=green, bg_color=black):
    x = fg_color
    _ = bg_color

    sanduhr = [
    _, x, _, _, _, _, x, _,
    _, _, x, _, _, x, _, _,
    _, _, _, x, x, _, _, _,
    _, _, _, x, x, _, _, _,
    _, _, _, x, x, _, _, _,
    _, _, _, x, x, _, _, _,
    _, _, x, _, _, x, _, _,
    _, x, _, _, _, _, x, _
    ]

    sense.set_pixels(sanduhr)

def get_ip_addresses():
    output = os.popen('/bin/hostname -I').read().strip()
    ip_list = [ip.strip() for ip in output.split()]
    return ip_list
    

def get_ips_str():
    ip_list = get_ip_addresses()
    return ' '.join(ip_list)
    
    
def get_date_time_str(with_date=True, with_time=True):
    date_str = datetime.now().strftime("%d.%m.%Y")
    time_str = datetime.now().strftime("%H:%M")
    
    ret_str = ''
    if with_date:
        ret_str += date_str
    if with_time:
        if ret_str == '':
            ret_str += time_str
        else:
            ret_str += ' / ' + time_str
    
    if ret_str == '':
        ret_str = date_str
    
    return ret_str
    

def get_yes_no(promt):
    sense.show_message(str(promt), scroll_speed=0.08, text_colour=[255, 0, 0])
    event = sense.stick.wait_for_event(emptybuffer=True)
    if event.action == "pressed":
        if event.direction == "middle":
            return True
        else:
            return False
            

# Hauptprogramm
# =============
sense = SenseHat()


sense.clear()
sense.show_message("Connecting to WiFi....", text_colour=red)


do_loop = True
while do_loop:
    sleep(1)
    draw_question_mark()
    event = sense.stick.wait_for_event()
    if event.action == "pressed":
    
        if event.direction == "middle":
            sense.show_message(get_ips_str(), text_colour=blue)
            do_loop = False
            sense.show_message("Bye!", scroll_speed=0.08, text_colour=[0, 255, 0])

        elif event.direction == "left":
            sense.show_message(get_date_time_str(), scroll_speed=0.08, text_colour=[0, 255, 0])
            
        elif event.direction == "right":
            if get_yes_no("Update RPi from Git?"):
                sense.show_message("YES", scroll_speed=0.08, text_colour=[0, 255, 0])
                draw_sanduhr()
                clone_them()
            else:
                sense.show_message("NO", scroll_speed=0.08, text_colour=[255, 0, 0])
                    
            
        elif event.direction == "up":
            temperatur = sense.get_temperature()
            pressure = sense.get_pressure()
            humidity = sense.get_humidity()

            sense.show_message(f"Temperatur: {temperatur:0.1f}C  Luftdruck: {pressure:0.0f}mBar  Rel. Feuchte: {humidity:0.0f}%", scroll_speed=0.08, text_colour=[0, 255, 0])
            
        elif event.direction == "down":
            sense.show_message(get_ips_str(), text_colour=blue)
            


                
sense.show_message('Tschüss!!!!', text_colour=blue)
sense.clear()  
