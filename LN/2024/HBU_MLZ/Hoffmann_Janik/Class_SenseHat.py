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


  