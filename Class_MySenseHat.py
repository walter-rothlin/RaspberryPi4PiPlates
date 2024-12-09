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
# 08-Dec-2023   Walter Rothlin      Added additonal Test-Cases
# ------------------------------------------------------------------

from sense_hat import SenseHat
from time import sleep
from enum import Enum
from datetime import datetime

class LogLevel(Enum):
    ALLWAYS = 0
    INFO = 1
    WARNING = 2
    ERROR = 3
    FATAL = 4
    NO_TRACE = 9

def get_status_string(actual_log_level, log_level_msg, message, with_timestamp=True):
    timestamp_str = ''
    if with_timestamp:
        timestamp_str = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    if log_level_msg.value >= actual_log_level.value:
        return f'{timestamp_str} {log_level_msg.name}: {message}'
    else:
        return ''

def print_if_not_empty(message):
    if message != '':
        print(message)

class MySenseHat(SenseHat):
    '''
    A subclass from SenseHat where set_pixel() has been overwritten and draw_line() added.
    '''
    red = (255, 0, 0)
    green = (0, 255, 0)
    blue = (0, 0, 255)
    yellow = (255, 255, 0)
    magenta = (255, 0, 255)
    cyan = (0, 255, 255)
    white = (255, 255, 255)
    grey = (100, 100, 100)
    black = (0, 0, 0)


    # Initializer and setter/Getter and Properties
    # ============================================
    def __init__(self, default_bg_color=cyan, default_fg_color=red, trace_level_on=LogLevel.WARNING):
        '''
        Constructor
        :param default_bg_color: color of the background
        :param default_fg_color: color of the foreground
        :param trace_on: LogLevel for debug mode
        '''
        self.__default_fg_color = default_fg_color
        self.__default_bg_color = default_bg_color
        self.__trace_level_on = trace_level_on
        super().__init__()

    def set_debug_mode(self, trace_level_on):
        self.__trace_level_on = trace_level_on


    def get_debug_mode(self):
        return self.__trace_level_on

    debug_mode = property(get_debug_mode, set_debug_mode)


    # Business Methods
    # ================
    def set_pixel(self, x, y, r=None, g=None, b=None, pixel_color=None):
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

        print_if_not_empty(get_status_string(self.debug_mode, LogLevel.INFO, f'set_pixel(self, x={x}, y={y}, r={r}, g={g}, b={b}, pixel_color={pixel_color})')) 

        if pixel_color is not None:
            r = round(pixel_color[0])
            g = round(pixel_color[1])
            b = round(pixel_color[2])
        else:
            if r is None:
                r = self.__default_fg_color[0]
            if g is None:
                g = self.__default_fg_color[1]
            if b is None:
                b = self.__default_fg_color[2]

        if type(x) is int:
            pass
        elif type(x) is float:
            x = round(x)
        elif type(x) is str:
            try:
                x = x.replace(',', '.').replace(' ', '')
                x = round(float(x))
            except ValueError:
                print_if_not_empty(get_status_string(self.debug_mode, LogLevel.ERROR,f'set_pixel(x={x}, y={y}) Conversion failed!'))
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
                print_if_not_empty(get_status_string(self.debug_mode, LogLevel.ERROR,f' set_pixel(x={x}, y={y}) Conversion failed!'))
                y = -1
        else:
            y = -1


        if (0 <= x <= 7) and (0 <= y <= 7):
            print_if_not_empty(get_status_string(self.debug_mode, LogLevel.INFO,f'set_pixel(self, x={x}, y={y}, r={r}, g={g}, b={b}, pixel_color={pixel_color})\n'))
            super().set_pixel(x, y, r, g, b)
        else:
            print_if_not_empty(get_status_string(self.debug_mode, LogLevel.WARNING,f'set_pixel(x={x}, y={y}) Coordinates out of range!\n'))




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

        print_if_not_empty(get_status_string(self.debug_mode, LogLevel.INFO,f'draw_line(self, x1={x_start}, y1={y_start}, x2={x_end}, y2={y_end}, r={r}, g={g}, b={b}, draw_speed={draw_speed})'))

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
            old_state = sense.debug_mode 
            sense.debug_mode = LogLevel.WARNING
            print('Test_set_pixel()....')
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
            sense.set_pixel(8,  0, 255, 0, 0)
            sense.set_pixel(8, -1, 255, 0, 0)
            sense.set_pixel(8, 'zzzz', 255, 0, 0)

          
            sense.set_debug_mode = old_state
            print('... done')


def Test_draw_line(sense, do_test=True):
        if do_test:
            old_state = sense.debug_mode 
            sense.set_debug_mode = LogLevel.ALLWAYS
            print('Test_draw_line()....')
            print('     Rectangle....', end='')
            sense.clear()
            sense.draw_line(0, 0, 7, 0, 255, 0, 0, 0.1)
            sleep(0.5)
            sense.draw_line(7, 0, 7, 7, 0, 255, 0, 0.1)
            sleep(0.5)
            sense.draw_line(7, 7, 0, 7, 0, 0, 255, 0.1)  # Fehler: diese Linie wird von (0,0) nach (7,7) gezeichnet
            sleep(0.5)
            sense.draw_line(0, 7, 0, 0, 255, 255, 0, 0.1)   # Fehler: diese Linie wird von (0,0) nach (0,7) gezeichnet
            print('... done')
            sleep(3)

            print('     Kreuz....', end='')
            sense.clear()
            sense.draw_line(0, 0, 7, 7, 255, 0, 0, 0.1)
            sleep(0.5)
            sense.draw_line(7, 0, 0, 7, 0, 255, 0, 0.1)
            print('... done')
            sleep(3)

            print('     Blaues Plus....', end='')
            sense.clear()
            sense.draw_line(0, 4, 7, 4, 0, 0, 255, 0.1)
            sleep(0.5)
            sense.draw_line(4, 0, 4, 7, 0, 0, 255, 0.1)
            print('... done')
            sleep(3)

            print('     Gelbes fast Plus....', end='')
            sense.clear()
            sense.draw_line(0, 4, 7, 5, 255, 255, 0, 0.1)
            sleep(0.5)
            sense.draw_line(4, 0, 5, 7, 255, 255, 0, 0.1)
            print('... done')
            sleep(3)


            sense.clear()

            sense.set_debug_mode = old_state
            

if __name__ == '__main__':
    sense = MySenseHat()
    sense.set_rotation(90)
    Test_set_pixel(sense, True)
    Test_draw_line(sense, True)




