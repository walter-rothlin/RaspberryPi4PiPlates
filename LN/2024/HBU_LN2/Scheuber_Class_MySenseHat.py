#!/usr/bin/python

from sense_hat import SenseHat
import time

class MySenseHat(SenseHat):
    def __init__(self, default_background_color = (25,25,112), default_forground_color = (42,255,0)):
        """
        Erweiterung von SensHat Klasse
        :param default_background_color: A list of (red, green, blue).
        :param default_forground_color: A list of (red, green, blue).
        """
        self.__default_background_color = default_background_color
        self.__default_forground_color = default_forground_color
        super().__init__()

    def set_pixel(self, x, y, forground_color = None):
        """
        Überschreiben set_pixel
        :param x: x-Kordinate optimal zwischen (0-7)
        :param y: y-Kordinate optimal zwischen (0-7)
        :param forground_color: optional tuple (r,g,b), ansonsten default_color
        """

        if forground_color == None or not all(0 <= c <= 255 for c in forground_color):
            forground_color = self.__default_forground_color
        try:
            x=self.__check_Kordinaten(x)
            y=self.__check_Kordinaten(y)
            super().set_pixel(x, y, (forground_color))
        except:
            pass
    def __check_Kordinaten(self,cord):
        """
        Methode um zu prüfen, ob sich der eingegebene Wert innerhalb der Matrix befindet, ansonsten Korrektur
        :param cord: zu prüfende Kordinate
        """
        cord = str(cord)
        cord = cord.replace(',', '.')
        cord = cord.replace("'", '')
        cord = cord.replace(' ','') 
        cord = int(round(float(cord)))
        if cord > 7:
            return 7
        elif cord < 0:
            return 0
        return cord
    
    def drawLine (self,x_start,y_start,x_end,y_end,forground_color = None, 
         sleepTime=0):
        """
        Methode um Linien zu zeichnen
        :param x_start: x-Kordinate optimal zwischen (0-7)
        :param y_start: y-Kordinate optimal zwischen (0-7)

        :param x_end: x-Kordinate optimal zwischen (0-7)
        :param y_end: y-Kordinate optimal zwischen (0-7)

        :param forground_color: optional tuple (r,g,b), ansonsten default_color
        
        :param sleepTime: Zeit für das setzen einzelner Pixel
        """
        if abs(x_start-x_end) > abs(y_start-y_end):
            gradient_y = (y_end-y_start)/abs(x_end-x_start)
            value_list = self.__calculatPoints(x_end,x_start)
            liste_points = self.__calculateXY(x_start,y_start,value_list,gradient_y)
        else:
            gradient_x = (x_end-x_start)/abs(y_end-y_start)
            value_list = self.__calculatPoints(y_end,y_start) 
            liste_points = self.__calculateXY(x_start,y_start,value_list,gradient_x,False)

        for point in liste_points:
            self.set_pixel(point['x'],point['y'],(forground_color))
            time.sleep(sleepTime)

    def __calculatPoints (self,end,start):
        """
        Methode gibt eine Liste von Werten, abhängig von den Start und Endpunkten zurück
        :param end  : start der Linie
        :param start: ende der Linie
        """
        value_list=[]
        if start < end:
            for x_calculation in range (0, end-start+1):
                value_list.append(x_calculation)
        else:
            for x_calculation in range (0,end-start-1,-1):
                value_list.append(x_calculation)
        return value_list
    
    def __calculateXY (self,x_start,y_start,valueList,gradient,calculateY=True):
        """
        Methode gibt eine Liste von Werten, abhängig von den Start und Endpunkten zurück
        :param x_start: start der x-Kordinate
        :param y_start: start der y-Kordinate
        :param valueList: Liste von Zwischenwerten
        :param gradient : Steigung der Geraden
        :param calculateY: Berechnung der Y = True (Berechnung Y auf Basis X)
        """
        calculation = 0
        liste = []
        for calculation in valueList:
            calculation_2nd= gradient * abs(calculation)
            if calculateY:
                x = calculation + x_start
                y = calculation_2nd + y_start
                liste.append({'x':x,'y':y})
            else:
                x = calculation_2nd + x_start
                y = calculation + y_start
                liste.append({'x':x,'y':y})
        return liste 
        

if __name__ == "__main__":

    sense = MySenseHat((255, 0, 0),(0, 255, 0))
    sense.clear()


    sense.set_pixel(4,5,(0,255,0))
    sense.set_pixel(8,5,(255,0,0))
    time.sleep(1)
    sense.set_pixel(3,3)
    sense.set_pixel(2,3,(255,0, 0))
    sense.set_pixel(-1,3,(0, 0,255))
    sense.set_pixel(8,3,(0, 0,255))
    sense.set_pixel(6,3,(0, 0,2255))
    time.sleep(1)
    sense.set_pixel("8","2",(0, 0,255))
    sense.set_pixel(7,"1.2",(0, 0,255))
    sense.set_pixel(7,"1..2")
    sense.set_pixel(7,"1,2")
    time.sleep(1)
    
    sense.clear()
    sense.drawLine(0,7,7,7,sleepTime=0.5)
    sense.drawLine(7,7,7,0,sleepTime=0.5)
    sense.drawLine(7,0,0,0,sleepTime=0.5)
    sense.drawLine(0,0,0,7,sleepTime=0.5)
    sense.drawLine(7,7,0,0,sleepTime=0.5)
    sense.drawLine(7,0,0,7,sleepTime=0.5)
    sense.clear()
    sense.drawLine(0,0,7,7,sleepTime=0.5)
    sense.drawLine(0,7,7,0,sleepTime=0.5)
    sense.clear()
    sense.drawLine(1,2,7,3,sleepTime=0.5)

