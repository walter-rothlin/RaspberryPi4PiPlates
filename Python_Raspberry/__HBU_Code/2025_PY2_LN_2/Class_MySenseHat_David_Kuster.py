#!/usr/bin/python
# Author: David Kuster

#from sense_emu import SenseHat   
from sense_hat import SenseHat
import math

class MySenseHat(SenseHat):
    """
    Unterklasse von SenseHat.
    - Überschreibt __init__()
    - Erweiterte set_pixel()-Methode:
        * akzeptiert int, float, str als Koordinaten
        * prüft Wertebereiche (0–7)
        * ignoriert Pixel ausserhalb
    - Neue Methode draw_line() zum Zeichnen von Linien mit robuster Berechnung.
    """

    def __init__(self):
        """
        Konstruktor der Unterklasse.
        Ruft den Konstruktor der Oberklasse auf und gibt eine Info-Meldung aus.
        """
        super().__init__()
        print("MySenseHat initialisiert")

    def set_pixel(self, x, y, r, g=None, b=None):
        """
        Erweiterte Version von set_pixel():
        - akzeptiert int, float, str für x und y
        - konvertiert und rundet Koordinaten automatisch
        - prüft, ob Koordinaten im Bereich [0..7] liegen
        - ignoriert ungültige Pixel ausserhalb des Bereiches
        - akzeptiert RGB entweder als Tupel oder als Einzelwerte
        """
        try:
            x = int(round(float(x)))
            y = int(round(float(y)))
        except (ValueError, TypeError):
            print(f"Ungültige Koordinaten: x={x}, y={y}")
            return

        if not (0 <= x <= 7 and 0 <= y <= 7):
            print(f"Pixel ausserhalb des Bereiches: x={x}, y={y}")
            return

        if isinstance(r, (list, tuple)):
            super().set_pixel(x, y, r[0], r[1], r[2])
        else:
            super().set_pixel(x, y, r, g, b)

    def draw_line(self, x_start, y_start, x_end, y_end, color=(255, 255, 255)):
        """
        Zeichnet eine Linie zwischen zwei Punkten (x_start, y_start) und (x_end, y_end).

        Eigenschaften:
        - Start- und Endpunkte können ausserhalb des LED-Matrix-Bereichs liegen
        - vertikale Linien (dx = 0) werden gesondert behandelt
        - bei steilen Linien (a > 1 oder a < -1) wird in y-Schritten gezeichnet
        - bei flachen Linien in x-Schritten
        """
        try:
            x_start, y_start = float(x_start), float(y_start)
            x_end, y_end = float(x_end), float(y_end)
        except ValueError:
            print("Ungültige Start-/Endkoordinaten")
            return

        dx = x_end - x_start
        dy = y_end - y_start

        if dx == 0:  # vertikale Linie
            y_min, y_max = sorted([y_start, y_end])
            for y in range(int(math.floor(y_min)), int(math.ceil(y_max)) + 1):
                self.set_pixel(x_start, y, color)
        else:
            a = dy / dx
            b = y_start - a * x_start

            if abs(a) <= 1:
                # in x-Schritten durchlaufen
                x_min, x_max = sorted([x_start, x_end])
                for x in range(int(math.floor(x_min)), int(math.ceil(x_max)) + 1):
                    y = a * x + b
                    self.set_pixel(x, y, color)
            else:
                # in y-Schritten durchlaufen
                y_min, y_max = sorted([y_start, y_end])
                for y in range(int(math.floor(y_min)), int(math.ceil(y_max)) + 1):
                    x = (y - b) / a
                    self.set_pixel(x, y, color)


# ================================
# Testprogramm (Test-Driven Style)
# ================================
if __name__ == "__main__":
    """
    Testprogramm für MySenseHat:
    - Erstellt ein MySenseHat-Objekt
    - Testet set_pixel() mit gültigen, ungültigen und konvertierbaren Werten
    - Testet draw_line() mit verschiedenen Fällen
    """
    sense = MySenseHat()
    sense.clear()
    sense.set_rotation(180)  # Drehen, damit es richtig rum ist

    # 1) Pixel korrekt setzen
    sense.set_pixel(4, 5, 255, 0, 0)       # rot
    sense.set_pixel("2", "3", (0, 255, 0)) # grün

    # 2) Pixel ausserhalb Bereich (Fehlerfall, sollte nicht crashen)
    sense.set_pixel(8, 5, 0, 255, 0)

    # 3) Linien zeichnen (verschiedene Fälle)
    sense.draw_line(0, 0, 7, 7, (255, 255, 0))   # Diagonal
    sense.draw_line(3, 0, 3, 7, (0, 0, 255))     # Vertikal
    sense.draw_line(0, 7, 7, 0, (255, 0, 255))   # Gegendiagonal