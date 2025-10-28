#!/usr/bin/env python3
from sense_hat import SenseHat
from time import sleep

# Globale Defaults
SLEEPTIME = 0.8
DEFAULT_R, DEFAULT_G, DEFAULT_B = 255, 255, 255

# 1. Erstellen Sie eine Unter-Klasse von SenseHat, überschreiben sie __init__() und mit dem Namen MySenseHat …
class MySenseHat(SenseHat):
    def __init__(self):
        super().__init__()  # (1)

    # 2.2.3 Strings (Konvertieren mit Fehlerbehandlung) | 2.2.2 Dezimalzahlen (Runden)
    @staticmethod
    def _to_float(v, name: str) -> float:
        if isinstance(v, (int, float)):
            return float(v)
        if isinstance(v, str):
            try:
                return float(v.strip().replace(",", "."))
            except Exception as ex:
                raise ValueError(f"{name}: '{v}' ist kein gültiger Zahlenwert (erwartet z. B. 3, 4.5 oder '6,7')") from ex
        raise ValueError(f"{name} hat ungültigen Typ: {type(v).__name__}")

    @staticmethod
    def _in_bounds(xi: int, yi: int) -> bool:
        return 0 <= xi <= 7 and 0 <= yi <= 7  # 8x8 Matrix

    # 2.2 set_pixel() überschreiben (Grenzen, Runden, Strings)
    # 2.2.1 ausserhalb → Oberklasse NICHT aufrufen
    def set_pixel(self, x, y, r=DEFAULT_R, g=DEFAULT_G, b=DEFAULT_B):
        xf = self._to_float(x, "x")   # (2.2.3)
        yf = self._to_float(y, "y")   # (2.2.3)
        xi, yi = int(round(xf)), int(round(yf))  # (2.2.2)
        if not self._in_bounds(xi, yi):         # (2.2.1)
            return
        super().set_pixel(xi, yi, r, g, b)

    # 3 draw_line(...)  | 3.1 y = a*x + b | 3.2 vertikal | 3.3 a>1 hohe Aufloesung
    def draw_line(self, x_start, y_start, x_end, y_end, r=DEFAULT_R, g=DEFAULT_G, b=DEFAULT_B):
        x1 = self._to_float(x_start, "x_start")
        y1 = self._to_float(y_start, "y_start")
        x2 = self._to_float(x_end, "x_end")
        y2 = self._to_float(y_end, "y_end")

        if x1 == x2:  # (3.2)
            y_from, y_to = (y1, y2) if y1 <= y2 else (y2, y1)
            print(f"[3.2] Vertikale Linie x={x1} von y={y_from} bis y={y_to}")
            y = y_from
            while y <= y_to:
                self.set_pixel(x1, y, r, g, b)
                sleep(SLEEPTIME)
                y += 1.0
            return

        a = (y1 - y2) / (x1 - x2)    # (3.1)
        b0 = y1 - a * x1
        print(f"[3.1] Linie von ({x1},{y1}) nach ({x2},{y2}) mit a={a:.3f}, b={b0:.3f}")

        if abs(a) <= 1.0:
            x_from, x_to = (x1, x2) if x1 <= x2 else (x2, x1)
            x = x_from
            while x <= x_to:
                y = a * x + b0
                self.set_pixel(x, y, r, g, b)
                sleep(SLEEPTIME)
                x += 1.0
        else:  # (3.3)
            y_from, y_to = (y1, y2) if y1 <= y2 else (y2, y1)
            print(f"[3.3] Steile Linie |a|>1 -> Substeps (0.25). y von {y_from} bis {y_to}")
            y = y_from
            sub = 0.25
            while y <= y_to:
                x = (y - b0) / a
                self.set_pixel(x, y, r, g, b)
                sleep(SLEEPTIME)
                y += sub

    # Testhilfe für 2.1.2 (roter Test – direkter Oberklassenaufruf)
    def _raw_super_set_pixel(self, x, y, r=DEFAULT_R, g=DEFAULT_G, b=DEFAULT_B):
        super().set_pixel(x, y, r, g, b)


# 2 Test-Programm (korrekt gekapselt)
if __name__ == "__main__":
    print("MySenseHat läuft.")
    sh = MySenseHat()  # (2.1)

    def clear():
        sh.clear()
        print("[clear] Matrix geleert")

    def on(x, y):
        r, g, b = sh.get_pixel(int(x), int(y))
        return (r, g, b) != [0, 0, 0] and (r, g, b) != (0, 0, 0)

    def row_on(y): return sum(1 for x in range(8) if on(x, y))
    def col_on(x): return sum(1 for y in range(8) if on(x, y))

    # (2.1.1) Pixel (4,5) rot – roter Test via Oberklasse
    clear()
    print("[2.1.1] Oberklasse: set_pixel(4,5, rot)")
    sh._raw_super_set_pixel(4, 5, 255, 0, 0)
    sleep(SLEEPTIME)

    # (2.1.2) Pixel (8,5) gruen – soll Fehler werfen
    print("[2.1.2] Oberklasse: set_pixel(8,5, gruen) -> erwarteter Fehler")
    threw = False
    try:
        sh._raw_super_set_pixel(8, 5, 0, 255, 0)
    except Exception as e:
        threw = True
        print(f"[2.1.2] Fehler gefangen: {type(e).__name__}: {e}")
    assert threw, "Direkter Oberklassenaufruf mit (8,5) muss fehlschlagen."

    # (2.2) Eigene set_pixel-Implementierung (grüner Test)
    clear()
    print("[2.2] MySenseHat.set_pixel(4,5, rot) -> sollte OK sein")
    sh.set_pixel(4, 5, 255, 0, 0)
    sleep(SLEEPTIME)
    assert on(4, 5)

    # (2.2.1) ausserhalb -> still ignorieren
    print("[2.2.1] MySenseHat.set_pixel(8,5, gruen) -> still ignorieren (kein Fehler)")
    try:
        sh.set_pixel(8, 5, 0, 255, 0)
        print("[2.2.1] kein Fehler (korrekt)")
    except Exception as e:
        raise AssertionError(f"[2.2.1] Unerwarteter Fehler: {e}")

    print("[2.2.1] MySenseHat.set_pixel(-1,0, weiss) -> still ignorieren (kein Fehler)")
    try:
        sh.set_pixel(-1, 0, 1, 1, 1)
        print("[2.2.1] kein Fehler (korrekt)")
    except Exception as e:
        raise AssertionError(f"[2.2.1] Unerwarteter Fehler: {e}")

    # (2.2.2) Dezimalzahlen (Runden)
    clear()
    print("[2.2.2] MySenseHat.set_pixel(3.6,4.4, hellrot) -> erwartet bei (4,4)")
    sh.set_pixel(3.6, 4.4, 200, 50, 50)
    sleep(SLEEPTIME)
    assert on(4, 4)

    # (2.2.3) Strings (Konvertieren mit Fehlerbehandlung)
    clear()
    print("[2.2.3] MySenseHat.set_pixel('2','6', farbe) -> erwartet bei (2,6)")
    sh.set_pixel("2", "6", 70, 80, 90)
    sleep(SLEEPTIME)
    assert on(2, 6)

    clear()
    print("[2.2.3] MySenseHat.set_pixel('3.5','5.5', farbe) -> erwartet bei (4,6)")
    sh.set_pixel("3.5", "5.5", 100, 110, 120)
    sleep(SLEEPTIME)
    assert on(4, 6)

    print("[2.2.3] MySenseHat.set_pixel('abc',0,0,0) -> erwarteter ValueError")
    try:
        sh.set_pixel("abc", 0, 0, 0, 0)
        raise AssertionError("[2.2.3] Erwarteter ValueError blieb aus.")
    except ValueError as e:
        print(f"[2.2.3] Fehler gefangen: {type(e).__name__}: {e}")

    # (3)/(3.1) Linien
    clear()
    print("[3][3.1] draw_line(0,0 -> 7,3) (flach)")
    sh.draw_line(0, 0, 7, 3)
    sleep(SLEEPTIME)
    assert sum(on(x, y) for y in range(8) for x in range(8)) >= 7

    # (3) Horizontal, Start/End ausserhalb
    clear()
    print("[3] draw_line(-3,4 -> 12,4) (horizontale durch Matrix)")
    sh.draw_line(-3, 4, 12, 4)
    sleep(SLEEPTIME)
    assert row_on(4) == 8 and sum(row_on(y) for y in range(8)) == 8

    # (3.2) Vertikal
    clear()
    print("[3.2] draw_line(2,-5 -> 2,12) (vertikal)")
    sh.draw_line(2, -5, 2, 12, 0, 255, 0)
    sleep(SLEEPTIME)
    assert col_on(2) == 8 and sum(col_on(x) for x in range(8)) == 8

    # (3.3) Steil |a|>1
    clear()
    print("[3.3] draw_line(1,7 -> 3,0) (steil, hohe Auflösung)")
    sh.draw_line(1, 7, 3, 0)
    sleep(SLEEPTIME)
    assert sum(row_on(y) > 0 for y in range(8)) >= 5

    print("Alle Tests ok.")
