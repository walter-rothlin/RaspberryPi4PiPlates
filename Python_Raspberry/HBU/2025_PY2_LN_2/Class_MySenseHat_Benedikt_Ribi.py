#!/usr/bin/python3
# ------------------------------------------------------------------
# Name: Class_MySenseHat.py
#
# Description:
# Eine abgeleitete Klasse von SenseHat mit erweiterten und
# robusteren Methoden zum Setzen von Pixeln und Zeichnen von Linien.
#
# Autor: Benedikt Ribi
# History:
# 24-Mai-2024  -  Initial Version
# ------------------------------------------------------------------

from sense_hat import SenseHat
import time

class MySenseHat(SenseHat):
    """
    Eine erweiterte SenseHat-Klasse mit robusteren Pixel-Setz- und Zeichenfunktionen.
    """

    def __init__(self):
        """
        Initialisiert die SenseHat-Oberklasse.
        """
        super().__init__()
        print("MySenseHat-Objekt wurde erstellt.")

    def set_pixel(self, x, y, r, g=None, b=None):
        """
        Setzt ein einzelnes LED-Pixel auf die angegebene Farbe,
        aber nur, wenn die Koordinaten innerhalb des 8x8-Rasters liegen.
        Akzeptiert Ganzzahlen, Fliesskommazahlen (werden gerundet) und Strings.

        :param x: x-Koordinate (0-7)
        :param y: y-Koordinate (0-7)
        :param r: Roter Farbwert (0-255) oder ein Tupel (r, g, b)
        :param g: Grüner Farbwert (0-255)
        :param b: Blauer Farbwert (0-255)
        """
        try:
            x_val = int(round(float(x)))
            y_val = int(round(float(y)))
        except (ValueError, TypeError):
            print(f"Fehler: Ungültige Koordinaten '{x}', '{y}'. Konnten nicht in Zahlen umgewandelt werden.")
            return

        if 0 <= x_val <= 7 and 0 <= y_val <= 7:
            # Die ursprüngliche Methode der Oberklasse aufrufen
            super().set_pixel(x_val, y_val, r, g, b)
        else:
            # Optional: Eine Meldung ausgeben, wenn Pixel ausserhalb liegen
            # print(f"Info: Pixel ({x_val}, {y_val}) liegt ausserhalb des 8x8-Rasters und wird ignoriert.")
            pass

    def draw_line(self, x1, y1, x2, y2, color=(255, 255, 255), draw_speed=0):
        """
        Zeichnet eine Linie vom Start- zum Endpunkt.
        Punkte ausserhalb des LED-Matrix-Bereichs werden ignoriert.
        Behandelt vertikale und steile Linien korrekt.

        :param x1: x-Koordinate des Startpunkts
        :param y1: y-Koordinate des Startpunkts
        :param x2: x-Koordinate des Endpunkts
        :param y2: y-Koordinate des Endpunkts
        :param color: Farbe der Linie als (r, g, b) Tupel.
        :param draw_speed: Pause in Sekunden nach jedem gesetzten Pixel für Animation.
        """
        try:
            x1 = round(float(x1))
            y1 = round(float(y1))
            x2 = round(float(x2))
            y2 = round(float(y2))
        except (ValueError, TypeError):
            print(f"Fehler: Ungültige Koordinaten für draw_line. Konnten nicht in Zahlen umgewandelt werden.")
            return

        if x1 == x2:  # Vertikale Linie
            if y1 > y2:
                y1, y2 = y2, y1  # y-Werte sortieren
            for y in range(y1, y2 + 1):
                self.set_pixel(x1, y, color)
                time.sleep(draw_speed)
        else:
            # Punkte sortieren, sodass x1 immer kleiner oder gleich x2 ist
            if x1 > x2:
                x1, x2 = x2, x1
                y1, y2 = y2, y1

            # Division durch Null wird durch die obige if-Abfrage (x1 == x2) verhindert
            a = (y1 - y2) / (x1 - x2)
            c = y1 - a * x1

            if abs(a) > 1:  # Steile Linie
                # y-Werte für die Iteration sortieren
                min_y, max_y = (y1, y2) if y1 < y2 else (y2, y1)
                for y in range(min_y, max_y + 1):
                    # a kann nicht 0 sein, da abs(a) > 1
                    x = (y - c) / a
                    self.set_pixel(x, y, color)
                    time.sleep(draw_speed)
            else:  # Flache Linie
                for x in range(x1, x2 + 1):
                    y = a * x + c
                    self.set_pixel(x, y, color)
                    time.sleep(draw_speed)


if __name__ == "__main__":
    print("--- Testprogramm für MySenseHat ---")

    # Ein Objekt von MySenseHat erstellen
    my_hat = MySenseHat()
    my_hat.clear()

    # --- Test-Driven-Ansatz für set_pixel ---
    print("\n1. Test: set_pixel(4, 5) auf Rot setzen (sollte funktionieren)")
    my_hat.set_pixel(4, 5, 255, 0, 0)
    time.sleep(2)

    print("2. Test: set_pixel(8, 5) auf Grün setzen (sollte ignoriert werden, kein Fehler)")
    my_hat.set_pixel(8, 5, 0, 255, 0) # Führt nicht mehr zum Fehler
    time.sleep(1)

    print("3. Test: set_pixel mit Fliesskommazahlen und String")
    my_hat.set_pixel(1.2, "3.8", 0, 0, 255) # Setzt Pixel (1, 4) auf Blau
    time.sleep(2)

    # --- Tests für draw_line ---
    print("\n4. Test: draw_line mit verschiedenen Linien")
    my_hat.clear()

    print(" - Diagonale Linie (0,0) -> (7,7)")
    my_hat.draw_line(0, 0, 7, 7, color=(255, 0, 0)) # Rot
    time.sleep(2)

    print(" - Vertikale Linie (x=7)")
    my_hat.draw_line(7, 6, 7, 1, color=(0, 255, 0)) # Grün
    time.sleep(2)

    print(" - Steile Linie (1,0) -> (3,7)")
    my_hat.draw_line(1, 0, 3, 7, color=(0, 0, 255), draw_speed=0.1) # Blau, animiert
    time.sleep(2)

    my_hat.clear()
    print("\n--- Testprogramm beendet ---")