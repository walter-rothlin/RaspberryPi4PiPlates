#!/usr/bin/env python3
from sense_hat import SenseHat
import time

class MySenseHat(SenseHat):
    WIDTH = 8
    HEIGHT = 8

    def __init__(self):
        super().__init__()
        self.clear()
        print("MySenseHat initialisiert.")

    def set_pixel(self, x, y, r, g=None, b=None):
        try:
            x = str(x).replace(",", ".")
            y = str(y).replace(",", ".")
            xi = int(round(float(x)))
            yi = int(round(float(y)))
        except Exception:
            print(f"⚠️ Ungültige Koordinaten: ({x},{y}) – ignoriert.")
            return False


        if not (0 <= xi < 8 and 0 <= yi < 8):
            print(f"⚠️ Pixel ausserhalb des Bereichs: ({xi},{yi}) – wird ignoriert.")
            return False

        # 🔹 Farbe prüfen
        if g is None and b is None and isinstance(r, (tuple, list)) and len(r) == 3:
            r, g, b = r
        try:
            r = int(r); g = int(g); b = int(b)
        except Exception:
            print(f"⚠️ Ungültige Farbe: ({r},{g},{b}) – ignoriert.")
            return False

        # 🔹 Nur aufrufen, wenn gültig
        super().set_pixel(xi, yi, r, g, b)
        print(f"✅ Pixel gesetzt bei ({xi},{yi}) – Farbe: ({r},{g},{b})")
        return True

    def draw_line(self, x_start, y_start, x_end, y_end, color=(255, 255, 255), step_delay=0.08):
        try:
            r, g, b = color
            color = (int(r), int(g), int(b))
        except Exception:
            color = (255, 255, 255)

        try:
            x0 = float(str(x_start).replace(",", "."))
            y0 = float(str(y_start).replace(",", "."))
            x1 = float(str(x_end).replace(",", "."))
            y1 = float(str(y_end).replace(",", "."))
        except Exception:
            print(f"Ungültige Linie: {x_start},{y_start} → {x_end},{y_end}")
            return 0

        dx = x1 - x0
        dy = y1 - y0
        placed = 0

        # Vertikale Linie
        if dx == 0:
            y_min, y_max = (y0, y1) if y0 <= y1 else (y1, y0)
            y = y_min
            while y <= y_max:
                if self.set_pixel(round(x0), round(y), color):
                    placed += 1
                    time.sleep(step_delay)   
                y += 1
            print(f"✅ Vertikale Linie ({x_start},{y_start}) → ({x_end},{y_end}) gesetzt ({placed} Pixel)")
            return placed

        # y = a*x + b
        a = dy / dx
        b = y0 - a * x0

        if abs(a) <= 1:
            # Flache Linie: über x iterieren
            x_min, x_max = (x0, x1) if x0 <= x1 else (x1, x0)
            x = x_min
            while x <= x_max:
                y = a * x + b
                if self.set_pixel(round(x), round(y), color):
                    placed += 1
                    time.sleep(step_delay)   
                x += 1
        else:

            y_min, y_max = (y0, y1) if y0 <= y1 else (y1, y0)
            y = y_min
            while y <= y_max:
                x = (y - b) / a
                if self.set_pixel(round(x), round(y), color):
                    placed += 1
                    time.sleep(step_delay)  
                y += 1

        print(f"✅ Linie ({x_start},{y_start}) → ({x_end},{y_end}) gesetzt ({placed} Pixel)")
        return placed



# =========================================================
# TDD-Test mit Validierungsausgabe
# =========================================================
if __name__ == "__main__":
    print("TDD-Test: MySenseHat mit Validierung + Animation + Terminal-Steuerung")

    sh = MySenseHat()

    # kleine Hilfsfunktion
    def wait_for_key(msg="Drücke ENTER, um fortzufahren..."):
        input(msg)


    # Die lise habe ich mit Copilot erstellt bis trenner)
    print("\nEinzelne Pixel-Tests (Validierung aller Fälle):")

    sh.set_pixel(4, 5, 255, 0, 0)               # Rot – gültig
    sh.set_pixel(8, 5, 0, 255, 0)               # Grün – ausserhalb Bereich (x=8)
    sh.set_pixel(-3, 9, 255, 105, 180)          # Pink – ausserhalb Bereich (x<0, y>7)
    sh.set_pixel(3.6, 2.4, 0, 0, 255)           # Blau – Dezimalwerte, werden gerundet
    sh.set_pixel("2", "6.9", 255, 255, 0)       # Gelb – String-Koordinaten, werden konvertiert
    sh.set_pixel("abc", "7", 255, 255, 255)     # Weiss – ungültige Koordinaten
    sh.set_pixel(2, 2, "rot", 0, 0)             # Rot – ungültige Farbe (String statt Zahl)
    sh.set_pixel(1, 1, ("x", 200, 100))         # Farbe – ungültige Werte im Tuple
    sh.set_pixel(5, 5, (255, 0))                # Farbe – Tuple zu kurz
    sh.set_pixel(0, 0, ["a", "b", "c"])         # Farbe – Liste mit falschem Typ

    # ---------------------------------------------------

    wait_for_key("\nDrücke ENTER, um die Linien-Tests zu starten...")
    sh.clear()
    
    print("\nLinien-Tests (animiert):")
    n1 = sh.draw_line(0, 0, 7, 3, (255, 255, 0), step_delay=0.08)
    wait_for_key("\nENTER → nächste Linie...")
    sh.clear()

    n2 = sh.draw_line(7, -2, 7, 10, (0, 255, 0), step_delay=0.08)
    wait_for_key("\nENTER → letzte Linie...")
    sh.clear()

    n3 = sh.draw_line(-5, -5, 2, 7, (255, 0, 255), step_delay=0.08)
    wait_for_key("\nENTER → Test abschliessen.")

    print(f"\nLinien-Gesamt: flach={n1}, vertikal={n2}, steil={n3}")
    print("\n✅ Test abgeschlossen – Anzeige wird gelöscht.")
    sh.clear()


    
