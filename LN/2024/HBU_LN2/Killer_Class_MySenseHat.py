#!/usr/bin/python3

from sense_hat import SenseHat

sense = SenseHat()



class MySenseHat(SenseHat):
    def __init__(self, x =0 , y = 0, red = 0, green = 0, blue = 0):
        self.__x = x
        self.__y = y
        self.__red = red
        self.__green = green
        self.__blue = blue
        '''
        Initialisert ein MySenseHat Objekt
        
        :param x: x-koordinate
        :param y: y-koordinate
        :param red: rote Farbe
        :param green: grüne Farbe
        :param blue: blaue Farbe
        '''#Docstrings

    def __str__(self):
        if MySenseHat.do_trace:
            return f'''
            x:      {self.__x}
            y:      {self.__y}
            red:    {self.__red}
            green:  {self.__green}
            blue:   {self.__blue}
            '''
        else:
            return "Ein Objekt der Klasse MySenseHat()"
    
    def set_pixel(self):
        super().set_pixel(self.__x, self.__y,self.__red, self.__green, self.__blue) 

    def clear(self):
        super().clear


if __name__ == '__main__':
    sensehat_test1 = MySenseHat(x = 0, y= 0,red= 255, green = 255, blue = 255)
    sensehat_test1.set_pixel()
    #sense.set_pixel(1,1,255,255,255)
