from sense_hat import SenseHat

class MySenseHat(SenseHat):
    def __init__(self):
        super().__init__()
    
    def set_pixel(self, x, y, r, g, b):
      #x, y Koordinaten runden
      x = round(float(x))
      y = round(float(y))
      
      #set_pixel nur aufrufen, wenn x,y in Matrix liegen
      if 0 <= x < 8 and 0 <= y < 8:
            super().set_pixel(x, y, r, g, b)

    def draw_line(self, x_start, y_start, x_end, y_end):
      
      #Sonderfall vertikale Linie
      if x_start == x_end:
        for y in range(y_start, y_end + 1):
            self.set_pixel(x_start, y, 255, 255, 255)
        return
      
      #lineare Funktion berechnen
      a = (y_start - y_end)/(x_start - x_end)
      b = y_start - a * x_start
      
      #lineare Funktion zeichnen
      for x in range(x_start, x_end + 1):
        y = round(a * x + b)
        self.set_pixel(x, y, 255,255,255)
      
      


#Testprogramm
  
hat = MySenseHat()
hat.low_light = True

#Test 1: Setzen Sie über dieses Objekt das Pixel mit x=4, y=5 auf rot 
hat.set_pixel(4,5,255,0,0)

#Test 2: Setzen Sie über dieses Objekt das Pixel mit x=8, y=5 auf gruen  ==> was zum Fehler führt
#         Kein Fehler meht, weil set_pixel in MySenseHat neu implementiert wurde
hat.set_pixel(8,5,0,255,0)

#Test 3: x und y Koordinate als Dezimalzahl -> Pixel (2,7) in Gelb
hat.set_pixel(2.2, 6.73, 255, 255, 0)

#Test 4: x und y Koordinate als String -> Pixel (3,1) in Blau
xString = "3"
yString = "1"
hat.set_pixel(xString, yString, 0, 0, 255)

#Test 5: einfache Gerade zeichnen 
hat.draw_line(0, 0, 7, 7)
  
#Test 6: weiter Gerade zeichnen
hat.draw_line(0, 5, 7, 2)

#Test 7: horizontale Linie
#hat.draw_line(0, 5, 7, 5)

#Test 8: vertikale Linie
#hat.set_pixel(5,0,255,255,255)
#hat.set_pixel(5,7,255,255,255)
hat.draw_line(5, 0, 5, 7)
  