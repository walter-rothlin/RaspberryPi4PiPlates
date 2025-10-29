#!/usr/bin/python3
# ------------------------------------------------------------------
# Name: Class_MySenseHat.py
#
# Description: Dieses Skript erweitert die Raspberry Pi Sense HAT-Bibliothek mit der Klasse „MySenseHat“ und ermöglicht sichere Pixelverarbeitung sowie das Zeichnen von Linien auf der LED-Matrix.
#
# Autor: Ricardo Fisch
#
# History:
# 01-Oct-2025  Ricardo Fisch  Init_umgeschrieben
# 02-Oct-2022  Ricardo Fisch  Testing geschrieben, funktionalität nach wunschvorgabe geschrieben und kurz gehahlten
# 02-Oct-2025  Ricardo Fisch  Skript nochmals neu überarbeitet, da zuviele negative Codes im Skript waren
# 02-Oct-2025  Ricardo Fisch  Testing sollte Funktioniern, Kommentare zum Skript Codes wurden noch ergänzt
# ------------------------------------------------------------------


# Datei: Class_MySenseHat.py
from sense_hat import SenseHat


class MySenseHat(SenseHat):
    """Erweiterte SenseHat-Klasse mit sicherem Pixel-Setzen und Linienzeichnung."""

    def __init__(self):
        super().__init__()  # Oberklasse initialisieren

    def set_pixel(self, x, y, color):
        """
        Überschreibt die set_pixel-Methode:
        - akzeptiert int, float, str für x und y
        - prüft Grenzen der 8x8 Matrix (0-7)
        - ruft nur dann das Original-set_pixel auf, wenn gültig
        """

        # Typkonvertierung mit Fehlerbehandlung
        try:
            if isinstance(x, str):
                x = int(float(x))
            if isinstance(y, str):
                y = int(float(y))

            if isinstance(x, float):
                x = round(x)
            if isinstance(y, float):
                y = round(y)
        except ValueError:
            print(f"Fehler: Ungültige Eingabe für x={x}, y={y}")
            return

        # Grenzprüfung
        if 0 <= x <= 7 and 0 <= y <= 7:
            super().set_pixel(x, y, color)  # nur wenn gültig
        else:
            print(f"Warnung: Pixel außerhalb des Bereichs: x={x}, y={y}")

    def draw_line(self, x_start, y_start, x_end, y_end, color):
        """
        Zeichnet eine Linie von (x_start, y_start) nach (x_end, y_end).
        Nutzt die Geradengleichung y = a*x + b.
        Fängt alle Sonderfälle ab:
        - Vertikale Linie
        - Steigung a > 1 (höhere Auflösung)
        """

        # Vertikale Linie
        if x_start == x_end:
            y_min, y_max = sorted([y_start, y_end])
            for y in range(y_min, y_max + 1):
                self.set_pixel(x_start, y, color)
            return

        # Steigung und Achsenabschnitt berechnen
        a = (y_end - y_start) / (x_end - x_start)
        b = y_start - a * x_start

        # Mehr Auflösung falls Steigung > 1
        if abs(a) <= 1:
            # X-Schleife
            x_min, x_max = sorted([x_start, x_end])
            for x in range(x_min, x_max + 1):
                y = a * x + b
                self.set_pixel(x, y, color)
        else:
            # Y-Schleife (feiner bei steilen Linien)
            y_min, y_max = sorted([y_start, y_end])
            for y in range(y_min, y_max + 1):
                x = (y - b) / a
                self.set_pixel(x, y, color)


# ===============================
# Testprogramm (TDD-Ansatz)
# ===============================

if __name__ == "__main__":
    sense = MySenseHat()

    # Test 1: gültiges Pixel setzen
    sense.set_pixel(4, 5, (255, 0, 0))  # rot

    # Test 2: ungültiges Pixel -> Warnung
    sense.set_pixel(8, 5, (0, 255, 0))  # grün → außerhalb

    # Test 3: Eingaben als Float/String
    sense.set_pixel("3", "6", (0, 0, 255))   # blau
    sense.set_pixel(2.7, 1.2, (255, 255, 0)) # gelb

    # Test 4: Linien zeichnen
    sense.draw_line(0, 0, 7, 7, (255, 0, 255))   # Diagonale
    sense.draw_line(3, 0, 3, 7, (0, 255, 255))   # Vertikal
    sense.draw_line(0, 7, 7, 0, (255, 255, 255)) # andere Diagonale

    time.sleep(10)
    sense.clear()0, (255, 255, 255))# Andere Diagonale