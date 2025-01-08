#!/usr/bin/python3

from sense_hat import SenseHat
from time import sleep

class MySenseHat(SenseHat):
    def __init__(self):
        super().__init__()

    def set_pixel(self,x,y,r,g,b,debug=False):
        print(f'set_pixel({x},{y},{r},{g},{b})') if debug else None
        if type(x) is str:
            x = float(x.replace(',','.').replace(' ', ''))
        if type(y) is str:
            y = float(y.replace(',','.').replace(' ', ''))
        
        if type(x) is float:
            x = round(x)
        if type(y) is float:
            y = round(y)

        if x>=0 and x<=7 and y>=0 and y<=7:
            super().set_pixel(x,y,round(float(r)),round(float(g)),round(float(b)))
        else:
            print(f'set_pixel({x},{y},{r},{g},{b})') if debug else None

    def draw_line(self, x_start, y_start, x_end, y_end, r=255, g=0, b=0,debug=False):
        '''
        y = ax + c 
        a = Steigung = (y_end - y_start)/(x_end -x_start)
        c = Y-Achsenabschnitt = y-ax
        '''

        print(f'draw_line({x_start},{y_start},{x_end},{y_end})') if debug else None
        a = (y_end - y_start)/(x_end - x_start)
        print(f'a = {a}') if debug else None
        c = y_start - a*x_start
        print(f'c = {c}') if debug else None
        x = x_start
        while x <= x_end:
            y = a * x + c
            print(f'y = a * x + c') if debug else None
            print(f'{y} = {a} * {x} + {c}') if debug else None
            self.set_pixel(x,y,r,g,b)
            x += 1

    def show_message(self, text_string, scroll_speed=0.1, text_colour=[255,255,255], back_colour=[0,0,0]):
        if type(text_colour) is str:
            t_colour = eval(text_colour)
        else:
            t_colour = text_colour
        if type(back_colour) is str:
            b_colour = eval(back_colour)
        else:
            b_colour = back_colour
        if type(scroll_speed) is str:
            scroll = float(scroll_speed)
        else:
            scroll = scroll_speed
        return super().show_message(text_string = text_string, scroll_speed = scroll, text_colour = t_colour, back_colour= b_colour)
    
    def show_letter(self, s, text_colour=[255,255,255], back_colour=[0,0,0]):
        if type(text_colour) is str:
            t_colour = eval(text_colour)
        else:
            t_colour = text_colour
        if type(back_colour) is str:
            b_colour = eval(back_colour)
        else:
            b_colour = back_colour
        return super().show_letter(s = s, text_colour = t_colour, back_colour= b_colour)

if __name__ == '__main__':
    sense = MySenseHat()
    if False:
        sense.clear()
        sense.set_pixel(4, 5, 255, 0, 0)
        sleep(0.5)
        sense.set_pixel(8, 5, 0, 255, 0)
        sleep(0.5)
        sense.set_pixel(1.0, 2.2, 255, 255, 0)
        sleep(0.5)
        sense.set_pixel('3.0', '2.2', 255, 255, 0)
        sleep(0.5)
        sense.set_pixel(' 4, 0 ', '2,2', 255, 255, 0)

    if True:
        sense.clear()
        sense.draw_line(0,0,7,7)
        sleep(1.0)
        sense.clear()
        sense.draw_line(-5,-3,9,8)
        sleep(1.0)
        sense.clear()
        sense.draw_line(4,0,4,8,debug=True)