#!/usr/bin/python

# Name   : HERO LABYRINTH
# Author : Stefan Rüeger
# ---------------------------------------------------------------------
# 17.09.2022    0.1     game engine, writing maps, reading joystick
# 18.09.2022    0.2     game logic, excel level editor, code clean up

from sense_hat import SenseHat
from time import sleep, time
from math import sin, pi
from copy import deepcopy

sh = SenseHat()

red     = (128,   0,   0)
green   = (  0, 128,   0)
yellow  = (128, 128,   0)
blue    = (  0,   0, 128)
magenta = (128,   0, 128)
gray    = ( 64,  64,  64)
blank   = (  0,   0,   0)

hero = 'h'
key = 'k'
open_door = 'd'
closed_door = 'c'
rock = 'r'
water = 'w'
lava = 'l'
empty = ' '

color_dict = {lava: red, open_door: green, water: blue, key: magenta,
              rock: gray, closed_door: gray, hero:yellow, empty: blank}

level1 = [
'rrrrrrrr',
'r      r',
'r rrrr r',
'r rs r r',
'r rr r r',
'r rr r r',
'r    r d',
'rrrrrrrr',
]

level2 = [
'rrrrrrrr',
'r  r   r',
'r krsr r',
'r  rrr r',
'r r    r',
'r r r rr',
'r   r  c',
'rrrrrrrr',
]

level3 = [
'rrrrrrrrrrrrrrrr',
'r   r          r',
'r r r rrrrrr r r',
'r r r    r   r r',
'r r r  k r r r r',
'r r rrrrrr r r r',
'r          r r r',
'rrrrrrrrrrrr r r',
'r          r r r',
'r rrrrr rrrrrr r',
'r r     r    r r',
'r r rrrrr rr r r',
'r r r      r r r',
'r r rrrrrr r r r',
'rsr        r   r',
'rcrrrrrrrrrrrrrr',
]

level4 = [
'rrrrrrrrrrrrrrrr',
'rwww r r    ll r',
'rwk  r r rr    r',
'rwww r r   rrr r',
'rww  r rrr   r r',
'r w r    rrrrr r',
'r   r ww       r',
'r     ww   r   r',
'rrrrr     rr lrr',
'r   rrrrrrrl  lr',
'r r r      l  ll',
'r r r rrrrrll ll',
'r r r rrr  l  ll',
'rs  r         ll',
'r     r rr lllll',
'rrrrrrrcrrrrrlll',
]

level5 = [
'rrrrrrrrllllrcrllllwwwwwwwwwwwww',
'r  k   rllllrcrllllwwwwwwwwwwwww',
'r      rllrlr rlrllwwwwwwwwwwwww',
'r      rllllr rllllwwwwww   wwww',
'r lll  rllllr rllllwwwwww s wwww',
'r l l  rllllr rllllwwwwww   wwww',
'r  l   rllrlr rlrllwwwwww   wwww',
'r l l  rllllr rllllwwwwwww wwwww',
'r      rllllr rllllwwwwwww wwwww',
'r      rllllr rllllwwwwwww wwwww',
'r      rllrlr rlrllwwwwwww wwwww',
'r   l  rllllr rllllwwwwwww wwwww',
'r   l  rllllr rllllwwwwwww wwwww',
'r  l l rllllr rllllwwwrrrr rrrrr',
'r   l  rllrlr rlrllwwwr        r',
'r  l l rllllr rllllwwwr        r',
'r      rllllr rllllwwwr  r  r  r',
'r  l   rllllr rllllwwwr  r  r  r',
'r  l   rllrlr rlrllwwwr  r  r  r',
'r l l  rllllr rllllwwwr  r  r  r',
'r  l   rllllr rllllwwwr  r  r  r',
'r l l  rllllr rllllwwwr  r  r  r',
'r      rllrlr rlrllrwwr  r  r  r',
'r    l rllllr rllllrwwr  r  r  r',
'r    l rllllr rllllrrwr  r  r  r',
'r  llllrllllr rllllrrwrwwr  r  r',
'r    llrrrrrr rrrrrrrrrwwr  rllr',
'r rrrrrrrr       rrrrrrwwr  rllr',
'r                rrrrrrrrr  rllr',
'rrrrrrrrrr                  rllr',
'         r       rrrrrrrrrrrrllr',
' l l l l rrrrrrrrr l l l l lrrrr',
]

levels = [level1, level2, level3, level4, level5]
level = 0

def print_map_to_display(xstart, ystart):
    for dy in range(8):
        map_ypos = ystart + dy - 3
        for dx in range(8):
            map_xpos = xstart + dx - 3
            if (0 <= map_xpos <= map_xsize-1) and (0 <= map_ypos <= map_ysize-1):
                map_pos_content = map[map_ypos][map_xpos]
            else:
                map_pos_content = empty
            if (dx == 3 and dy ==3):
                sh.set_pixel(dx, dy, color_dict[hero]) # mark hero's position
            else:
                sh.set_pixel(dx, dy, color_dict[map_pos_content]) # write map content

def flash_display(color, time=1, repeat=1):
    r, g, b = color
    for r in range(repeat):
        for i in range(255):
            multi = 255 * sin(i * pi / 255)
            r = int(multi) if(color[0] > 1) else 0
            g = int(multi) if(color[1] > 1) else 0
            b = int(multi) if(color[2] > 1) else 0
            sh.clear(r, g, b)
            sleep(time / 255)

###  MAIN  ###
while 1 == True:
    level_done = False
    map = deepcopy(levels[level])
    map_xsize = len(map[0])
    map_ysize = len(map)
    stick_dir = ''
    hero_dir = ''

    for map_ypos in range(map_ysize):
        for map_xpos in range(map_xsize):
            map_pos_content = map[map_ypos][map_xpos]
            if map_pos_content == 's':
                hero_xpos, hero_ypos = map_xpos, map_ypos
                map[hero_ypos] = map[hero_ypos].replace('s', ' ')
            elif map_pos_content == 'c':
                door_xpos, door_ypos = map_xpos, map_ypos

    ###  GAME LOOP  ###
    while level_done == False:

        print_map_to_display(hero_xpos, hero_ypos)

        event = sh.stick.wait_for_event(emptybuffer=True)
        if event.action in ('pressed', 'held'):
            hero_dir = event.direction
            #print(hero_dir)
            sleep(0.1)

        hero_next_xpos, hero_next_ypos = hero_xpos, hero_ypos
        if hero_dir == 'up':
            hero_next_ypos = hero_ypos - 1 if (hero_ypos > 0) else hero_ypos
        elif hero_dir == 'down':
            hero_next_ypos = hero_ypos + 1 if (hero_ypos < map_ysize-1) else hero_ypos
        elif hero_dir == 'left':
            hero_next_xpos = hero_xpos - 1 if (hero_xpos > 0) else hero_xpos
        elif hero_dir == 'right':
            hero_next_xpos = hero_xpos + 1 if (hero_xpos < map_xsize-1) else hero_xpos
        map_pos_content = map[hero_next_ypos][hero_next_xpos]
        hero_dir = ''

        if map_pos_content == empty:
            hero_xpos, hero_ypos = hero_next_xpos, hero_next_ypos
        elif map_pos_content == open_door:
            print("\nYou just walked through the door!")
            flash_display(color_dict[open_door])
            level_done = True
            level += 1
            if level == len(levels):   # Player has reached the end of the game!
                flash_display(yellow, 0.2, 5)
                sh.show_message("You did it! ", 0.04, yellow)
                sleep(3)
                level = 0
        elif map_pos_content == key:
            print("\nYou have found the key!")
            flash_display(color_dict[key])
            map[door_ypos] = map[door_ypos].replace(closed_door, open_door)
            map[hero_next_ypos] = map[hero_next_ypos].replace(key, empty)
        elif map_pos_content == lava:
            print("\nThe lava has burned you. Start again!")
            flash_display(red)
            level_done = True
        elif map_pos_content == water:
            print("\nYou fell into water. Swim back!")
            flash_display(blue)
