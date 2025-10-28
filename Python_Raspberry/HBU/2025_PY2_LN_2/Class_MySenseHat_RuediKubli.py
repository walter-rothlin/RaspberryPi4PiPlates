# Class_MySenseHat.py
# -----------------------------------------------------------------------------
# Diese Aufgabenstellung sieht zwei Klassen vor:
# 1) SenseHat  -> die "Elternklasse" (Basis mit 8x8 Matrix)
# 2) MySenseHat -> die "Kindklasse", welche SenseHat entsprechend erweitert
# -----------------------------------------------------------------------------
# MySenseHat soll folgende Erweiterungen bieten:
# - Standardfarben (background, foreground)
# - Überschreiben von set_pixel() mit Prüfung der Koordinaten
# - Methode draw_line() zum Zeichnen von Linien
# - x=0, y=0 ist die Ecke oben links
# -----------------------------------------------------------------------------
# Am Ende des Codes steht ein kleines Testprogramm, das die Funktionalität
# der Klasse MySenseHat demonstriert.
# -----------------------------------------------------------------------------

#!/usr/bin/env python3

from sense_hat import SenseHat
from typing import Tuple, List
from time import sleep

# ------------------- Elternklasse: SenseHat ----------------------------------
# Einfaches 8x8 LED-Display mit RGB-Farben pro Pixel
class SenseHat:
    """
    Stellt ein einfaches 8x8 LED-Display dar.
    Jedes Pixel speichert eine Farbe (r, g, b).
    """

    def __init__(self):
        # Erstelle ein 8x8 Feld (Liste in Liste)
        # Jedes Pixel startet mit schwarz (0,0,0)
        self._width = 8
        self._height = 8
        self._buffer: List[List[Tuple[int, int, int]]] = [
            [(0, 0, 0) for _ in range(self._width)]
            for _ in range(self._height)
        ]

    def set_pixel(self, x: int, y: int, r: int, g: int, b: int):
        """
        Setzt ein Pixel an Position (x,y) auf die Farbe (r,g,b).
        Achtung: hier erfolgt KEINE Prüfung, ob Variablen gültig Werte besitzen
        """
        self._buffer[y][x] = (r, g, b)

    def get_pixel(self, x: int, y: int) -> Tuple[int, int, int]:
        """
        Gibt die Farbe des Pixels an Position (x,y) zurück.
        """
        return self._buffer[y][x]

    def set_pixels(self, pixels: List[Tuple[int, int, int]]):
        """
        Setzt ALLE Pixel auf einmal.
        Erwartet eine Liste von 64 Farben (8x8).
        """
        if len(pixels) != self._width * self._height:
            raise ValueError("Es müssen genau 64 Pixel übergeben werden!")
        it = iter(pixels)
        for y in range(self._height):
            for x in range(self._width):
                self._buffer[y][x] = next(it)

    def get_pixels(self) -> List[Tuple[int, int, int]]:
        """
        Gibt alle Pixel zeilenweise zurück.
        """
        return [px for row in self._buffer for px in row]

    def show(self):
        """
        Gibt die aktuelle Pixelmatrix auf dem Sense-HAT aus
        """
        try:
            from sense_hat import SenseHat
            sense = SenseHat()
            pixels = self.get_pixels()
            sense.set_pixels(pixels)
        except ImportError:
            print("Sense-HAT Bibliothek nicht installiert.")
        except Exception as e:
            print(f"Fehler bei Sense-HAT Ausgabe: {e}")

# ------------------- Kindklasse: MySenseHat -------------------
class MySenseHat(SenseHat):
    """
    Erweiterte Version von SenseHat:
    - hat Standardfarben (background, foreground)
    - überschreibt set_pixel() -> prüft Koordinaten
    - kann Linien zeichnen mit draw_line()
    """

    def __init__(self):
        super().__init__()
        # Standardfarben setzen
        self.default_background_color = (0, 0, 0)   # schwarz
        self.default_foreground_color = (255, 255, 255)  # weiß

    # ---- Überschreiben von set_pixel ----
    def set_pixel(self, x, y, r=None, g=None, b=None) -> bool:
        """
        Überschreibt set_pixel aus der Elternklasse:
        - Wandelt x und y in int um (rundet bei Float, konvertiert bei String)
        - Prüft, ob die Werte im gültigen Bereich sind (0..7)
        - Ruft nur dann die Elternklasse auf, wenn alles ok ist
        - Gibt True zurück, wenn Pixel gesetzt wurde, sonst False
        """

        # Versuche x und y in int umzuwandeln
        try:
            x = int(round(float(x)))
            y = int(round(float(y)))
        except Exception:
            print("Fehler: x oder y konnten nicht umgewandelt werden.")
            return False

        # Prüfen ob innerhalb der 8x8 Matrix
        if not (0 <= x < self._width and 0 <= y < self._height):
            print(f"Out of bounds: ({x},{y}) nicht im Bereich 0-7")
            return False

        # Farbwerte prüfen
        if g is None and b is None:
            r, g, b = r  # Tupel oder Liste
            super().set_pixel(x, y, int(r), int(g), int(b))
            return True

    # ---- Linien zeichnen ----
    def draw_line(self, start_point, end_point, bg_color=None, fg_color=None):
        """
        Zeichnet eine Linie von start_point nach end_point.
        - Start/Endpunkte dürfen auch ausserhalb liegen
        - bg_color: wenn angegeben, füllt den Hintergrund
        - fg_color: Farbe der Linie (Standard = default_foreground_color)
        """

        # Hintergrund füllen, falls gewünscht
        if bg_color is not None:
            self.set_pixels([bg_color] * 64)

        # Linienfarbe bestimmen
        color = fg_color if fg_color is not None else self.default_foreground_color

        x0, y0 = int(round(float(start_point[0]))), int(round(float(start_point[1])))
        x1, y1 = int(round(float(end_point[0]))), int(round(float(end_point[1])))

        if x1 == x0:
            # Von min(y0,y1) bis max(y0,y1) in y-Schritten von 1 laufen
            y_min, y_max = (y0, y1) if y0 <= y1 else (y1, y0)
            y = y_min
            while y <= y_max:
                self.set_pixel(x0, y, color)  # set_pixel rundet und clippt
                y += 1.0
            return

        # 3) Normale (nicht-vertikale) Linie: a und b berechnen
        a = (y1 - y0) / (x1 - x0)          # Steigung
        b_lin = y0 - a * x0                # Achsenabschnitt b

        # 4) Je nach Steigung unterschiedlich iterieren:
        if abs(a) <= 1.0:
            # "flache" Linie: in x-Schritten von 1 gehen und y = a*x + b berechnen
            x_min, x_max = (x0, x1) if x0 <= x1 else (x1, x0)
            x = x_min
            while x <= x_max:
                y = a * x + b_lin
                self.set_pixel(x, y, color)  # r,g,b als Einzelwerte
                x += 1.0
        else:
            # "steile" Linie: in y-Schritten von 1 gehen und x = (y - b)/a berechnen
            y_min, y_max = (y0, y1) if y0 <= y1 else (y1, y0)
            y = y_min
            while y <= y_max:
                x = (y - b_lin) / a
                self.set_pixel(x, y, color)
                y += 1.0

    def clear(self):
        """setzt alle Pixel auf default_background_color"""
        self.set_pixels([self.default_background_color] * 64)    


# ------------------- Testprogramm -------------------
if __name__ == "__main__":
    sh = SenseHat()

    # Pixel innerhalb setzen
    sh.set_pixel(4, 5, 255, 0, 0)  # bricht mit Fehlermeldung ab
    
    # Pixel außerhalb -> gibt False zurück
    #sh.set_pixel(8, 5, 0, 255, 0)  # grün
    
    # Ausgabe in Konsole
    sh.show()
    sleep(10)
            
    sh2 = MySenseHat()
    sh2.clear()
    sh2.show()

    # Pixel innerhalb setzen
    sh2.set_pixel(4, 5, (255, 0, 0))  # rot
    # Pixel außerhalb -> gibt False zurück
    sh2.set_pixel(8, 5, (0, 255, 0))  # grün
    sh2.show()
    sleep(2)

    # Linie zeichnen (diagonal)
    # sh2.draw_line((-3, -3), (9, 9), bg_color=(0, 0, 0), fg_color=(255, 255, 255))
    sh2.draw_line((0, 0), (2, 7), bg_color=(0, 0, 0), fg_color=(255, 255, 255))


    # Ausgabe auf Display
    sh2.show()
    sleep(2)
    
    # Display löschen mit default.background
    sh2.clear()
    sh2.show()