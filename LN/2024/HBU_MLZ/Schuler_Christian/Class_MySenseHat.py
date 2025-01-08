#!/usr/bin/python3

from sense_hat import SenseHat
from time import sleep

class MySenseHat(SenseHat):
    #initialisierer erbt von Oberklasse
    def __init__(self):
        super().__init__()
   
   #überschreiben der set_pixel Methode der Oberklasse
    def set_pixel(self, x, y, *args):
        #string prüfen
        if isinstance(x, str):
            #keine Buchstaben
            if not x.isalpha():
                try:
                    newX = int(x)
                except ValueError:
                    raise ValueError('Kann x nicht konvertieren')
                #auf jeden Fall eine Zahl zuweisen
                finally:
                    newX = 8
            else:
                newX = 8
        #falls x eine dezimalzahl ist, runden
        else:
            newX = round(x)

        if isinstance(y, str):
            if not y.isalpha():
                try:
                    newY = int(y)
                except ValueError:
                    raise ValueError('Kann y nicht konvertieren')
                finally:
                    newY = 8
            else:
                newY = 8
        else:
            newY = round(y)

        if newX <= 7 and newX >=0 and newY <= 7 and newY >=0:
            super().set_pixel(newX, newY, *args)
    
    def draw_line(self, x_start=0, y_start=0, x_end=0, y_end=0, color=(255,255,255)):
        # Konvertiere und runde die Start- und Endwerte
        try:
            x_start, y_start = round(float(x_start)), round(float(y_start))
            x_end, y_end = round(float(x_end)), round(float(y_end))
        except ValueError:
            raise ValueError("Kann nicht konvertieren")
        
        dx = x_end - x_start
        dy = y_end - y_start
        
        # Fall einer vertikalen Linie
        if dx == 0:
            step = 1 if dy > 0 else -1
            for y in range(y_start, y_end + step, step):
                self.set_pixel(x_start, y, color)
            return
        
        # Steigung berechnen
        a=(y_start-y_end)/(x_start-x_end)
        #print(f'a={a}')
        b=y_start-a*x_start
        #print(f'b={b}')
        
        # Linie zeichnen
        if abs(a) <= 1:
            step = 1 if dx > 0 else -1
            for x in range(x_start, x_end + step, step):
                y = a * x + b
                self.set_pixel(x, y, color)
        else:
            step = 1 if dy > 0 else -1
            for y in range(y_start, y_end + step, step):
                x = (y - b) / a
                self.set_pixel(x, y, color)


if __name__ == '__main__':
    # Test Programm
    mySense = MySenseHat()
    mySense.clear()

    #rotes Pixel zeichnen
    mySense.set_pixel(4, 5, (255, 0, 0))
    #grünes Pixel zeichen(x ausserhalb Bereich, sollte nichts passieren)
    mySense.set_pixel(8, 5, (0, 255, 0))
    #blaues Pixel zeichen mit x und y als String Angabe
    mySense.set_pixel('2', '2', (0, 0, 255))
    #blaues Pixel zeichen mit x und y als String Angabe, keine Ausgabe
    mySense.set_pixel('a', 'b', (0, 0, 255))
    #blaues Pixel zeichen mit x und y als String Angabe, wirft exception
    #mySense.set_pixel('2a', '2', (0, 0, 255))
    #grünes Pixel zeichen Werte als Dezimalzahlen
    mySense.set_pixel(2.6, 2.6, (0, 255, 0))

    sleep(3)

    mySense.clear()
    #Linie zeichnen
    mySense.draw_line(0,0,7,7,(255,255,255))
    sleep(2)
    mySense.clear()
    #Vertikale Linie zeichnen
    mySense.draw_line(7,0,7,7,(0,255,0))
    sleep(2)
    mySense.clear()
    #Linie mit negativem Startpunkt
    mySense.draw_line(-5,-5, 5,5, (0,0,255))
    sleep(2)
    mySense.clear()
    #Linie a>1
    mySense.draw_line(0,0,5,7,(255,0,0))
    sleep(5)
    mySense.clear()