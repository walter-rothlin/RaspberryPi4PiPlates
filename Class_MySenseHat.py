#!/usr/bin/python3

# ------------------------------------------------------------------
# Name  : Class_SenseHat.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/refs/heads/main/Class_MySenseHat.py
#
# Description: Sub-Class of SenseHat
#
# Sense HAT: https://pythonhosted.org/sense-hat/
# API HAT  : https://pythonhosted.org/sense-hat/api/
#
# Autor: Walter Rothlin
#
# History:
# 01-Dec-2023   Walter Rothlin      Initial Version
# 04-Dec-2023   Walter Rothlin      set_pixel overwritten
# 08-Dec-2023   Walter Rothlin      draw_line() implemented (extends)
# 23-Dec-2023   Walter Rothlin      Test_Framework implemented
# 06-Dec-2023   Walter Rothlin      Refactoring for HFU PY2
# ------------------------------------------------------------------

from sense_hat import SenseHat
from time import sleep

class MySenseHat(SenseHat):
    '''
    A subclass from SenseHat where set_pixel() has been overwritten and draw_line() added.
    '''

    red      = (255,   0,   0)
    green    = (0,   255,   0)
    blue     = (0,     0, 255)
    yellow   = (255, 255,   0)
    mangenta = (255,   0, 255)
    cyan     = (0,   255, 255)
    white    = (255, 255, 255)
    grey     = (100, 100, 100)
    black    = (0,     0,   0)

    # Initializer and setter/Getter and Properties
    # ============================================
    def __init__(self, background_color=cyan, forground_color=red, trace_on=False):
        '''
        Constructor
        :param background_color: color of the background
        :param forground_color: color of the forground
        :param trace_on: True/False for debug mode

        '''
        self.__fg_color = forground_color
        self.__bg_color = background_color
        self.__debug = trace_on
        # print('__init__():', trace_on, self.__debug)
        # super().clear(r=255, g=0, b=255)
        super().__init__()


    def set_debug_mode(self, trace_on=None):
        if trace_on is not None:
            self.__debug = trace_on
            # print(f'set_debug_mode({trace_on}) ==> {self.__debug}')
        # else:
            # self.__debug = False
            # print(f'set_debug_mode({trace_on}) ==> {self.__debug}')

    def get_debug_mode(self):
        return self.__debug

    debug_mode = property(get_debug_mode, set_debug_mode)



    # Business Methods
    # ================
    def set_pixel(self, x, y, r=255, g=0, b=0, pixel_color=None):
        '''
        Overwrites the set_pixel() method from the SenseHat class.
        :param x: x-coordinate (0-7)
        :param y: y-coordinate (0-7)

        :param r: red color value (0-255)
        :param g: green color value (0-255)
        :param b: blue color value (0-255)
        
        :param pixel_color: tuple with 3 color values (r, g, b)
        :return: None
        '''

        print(f'set_pixel(self, x={x}, y={y}, r={r}, g={g}, b={b}, pixel_color={pixel_color})') if self.debug_mode else None

        if pixel_color is not None:
            r = round(pixel_color[0])
            g = round(pixel_color[1])
            b = round(pixel_color[2])

        if type(x) is int:
            pass
        elif type(x) is float:
            x = round(x)
        elif type(x) is str:
            try:
                x = x.replace(',', '.').replace(' ', '')
                x = round(float(x))
            except ValueError:
                print(f'ERROR: set_pixel(x={x}, y={y}) Coordinates can be converted!') if self.debug_mode else None
                x = -1
        else:
            x = -1

        if isinstance(y, int):
            pass
        elif isinstance(y, float):
            y = round(y)
        elif isinstance(y, str):
            try:
                y = y.replace(',', '.').replace(' ', '')
                y = round(float(y))
            except ValueError:
                print(f'ERROR: set_pixel(x={x}, y={y}) Coordinates can be converted!') if self.debug_mode else None
                y = -1
        else:
            y = -1


        if (0 <= x <= 7) and (0 <= y <= 7):
            print(f'set_pixel(self, x={x}, y={y}, r={r}, g={g}, b={b}, pixel_color={pixel_color})') if self.debug_mode else None
            super().set_pixel(x, y, r, g, b)
        else:
            print(f'WARNING: set_pixel(x={x}, y={y}) Coordinates out of range!') if self.debug_mode else None

        print() if self.debug_mode else None



    def draw_line(self, x_start=0, y_start=0, x_end=7, y_end=7, r=255, g=255, b=255, draw_speed=0):
        '''
        Draws a line from (x1, y1) to (x2, y2) with the given color and speed.
        :param x_start: x-coordinate of the start point
        :param y_start: y-coordinate of the start point
        :param x_end: x-coordinate of the end point
        :param y_end: y-coordinate of the end point

        :param r: red color value (0-255)
        :param g: green color value (0-255)
        :param b: blue color value (0-255)

        :param draw_speed: speed of the drawing in seconds

        :return: None
        '''
        if draw_speed is not None and draw_speed != '':
            draw_speed = float(draw_speed)
        else:
            draw_speed = 0

        print(f'draw_line(self, x1={x_start}, y1={y_start}, x2={x_end}, y2={y_end}, r={r}, g={g}, b={b}, draw_speed={draw_speed})') if self.debug_mode else None

        if x_start == x_end:
            if y_start > y_end:
                y_start, y_end = y_end, y_start
            for y in range(round(y_start), round(y_end+1)):
                self.set_pixel(x_start, y, r, g, b)
                sleep(draw_speed)
        else:
            if x_start > x_end:
                x_start, x_end = x_end, x_start
                y_start, y_end = y_end, y_start
            a = (y_start-y_end)/(x_start-x_end)
            c = y_start - a*x_start
            if (a > 1) or (a < -1):
                if y_start > y_end:
                    y_start, y_end = y_end, y_start
                for y in range(round(y_start), round(y_end+1)):
                    x = (y - c)/a
                    self.set_pixel(x, y, r, g, b)
                    sleep(draw_speed)
            else:
                for x in range(round(x_start), round(x_end+1)):
                    y = a*x + c
                    self.set_pixel(x, y, r, g, b)
                    sleep(draw_speed)


def Test_set_pixel(sense, do_test=False):
        if do_test:
            print('Test_set_pixel()....', end='')
            sense.clear()
            sense.set_pixel(0, 0, 255, 0, 0)
            sleep(0.5)
            sense.set_pixel(7, 0, 0, 255, 0)
            sleep(0.5)
            sense.set_pixel(7.0, 7.0, 255, 255, 0)
            sleep(0.5)
            sense.set_pixel('0', '7 , 32', 255, 255, 255)
            sleep(0.5)
            sense.set_pixel(' 4, 0 ', '2,2', 255, 255, 0)
            sleep(3)
            sense.clear()


def Test_draw_line(sense, do_test=True):
        if do_test:
            print('Test_draw_line()....', end='')
            sense.clear()
            sense.draw_line(0, 0, 7, 0, 255, 0, 0, 0.1)
            sleep(0.5)
            sense.draw_line(7, 0, 7, 7, 0, 255, 0, 0.1)
            sleep(0.5)
            sense.draw_line(7, 7, 0, 7, 0, 0, 255, 0.1)
            sleep(0.5)
            sense.draw_line(0, 7, 0, 0, 255, 255, 0, 0.1)
            sleep(3)
            sense.clear()


if __name__ == '__main__':
    sense = MySenseHat()
    Test_set_pixel(sense, True)
    Test_draw_line(sense, True)




