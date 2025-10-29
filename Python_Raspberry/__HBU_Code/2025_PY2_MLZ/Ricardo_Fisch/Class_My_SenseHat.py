
# -*- coding: utf-8 -*-
"""Sehr einfache MySenseHat-Klasse.

Ziel: leicht verständlich, ohne Magie. Läuft auch ohne echte Hardware.
- Wenn das echte sense_hat Modul vorhanden ist, verwenden wir es.
- Wenn nicht, nutzen wir eine einfache Software-Variante (Stub).
- Wir protokollieren einfache Log-Meldungen für die Anzeige auf der Webseite.
"""
from __future__ import annotations
from typing import List, Tuple
from datetime import datetime

# Versuche, echte SenseHat-API zu benutzen
try:
    from sense_hat import SenseHat as RealSenseHat  # type: ignore
    HAVE_HW = True
except Exception:
    HAVE_HW = False
    class RealSenseHat:
        """Einfache Software-Variante ohne Hardware."""
        def __init__(self):
            self._pixels = [(0,0,0)] * 64
            self._rotation = 0
        # Sensorwerte: feste Beispielwerte
        def get_temperature(self): return 21.5
        def get_pressure(self): return 1013.0
        def get_humidity(self): return 45.0
        # LED-Matrix
        def clear(self, *rgb):
            self._pixels = [(0,0,0)] * 64
        def set_pixel(self, x:int, y:int, r:int, g:int, b:int):
            if 0 <= x <= 7 and 0 <= y <= 7:
                self._pixels[y*8 + x] = (r,g,b)
        def get_pixel(self, x:int, y:int):
            if 0 <= x <= 7 and 0 <= y <= 7:
                return list(self._pixels[y*8 + x])
            return [0,0,0]
        def get_pixels(self):
            return [list(p) for p in self._pixels]
        def set_pixels(self, arr):
            if isinstance(arr, list) and len(arr) == 64:
                self._pixels = [tuple(p) for p in arr]
        def show_message(self, text, text_colour=(255,255,255), back_colour=(0,0,0), scroll_speed=0.07):
            pass
        def set_rotation(self, r:int, redraw:bool=True):
            self._rotation = int(r) % 360
        def flip_h(self, redraw:bool=True):
            new = []
            for y in range(8):
                row = [self._pixels[y*8 + x] for x in range(8)]
                new.extend(row[::-1])
            self._pixels = new
        def flip_v(self, redraw:bool=True):
            new = []
            for y in range(7,-1,-1):
                row = [self._pixels[y*8 + x] for x in range(8)]
                new.extend(row)
            self._pixels = new

def _ts() -> str:
    return datetime.now().strftime("%Y-%m-%d %H:%M:%S")

def _rgb(c) -> Tuple[int,int,int]:
    r,g,b = c
    r = max(0, min(255, int(r)))
    g = max(0, min(255, int(g)))
    b = max(0, min(255, int(b)))
    return (r,g,b)

class MySenseHat(RealSenseHat):
    """Kleine, leicht erklärbare Erweiterung.

    - Führt einfache Logs in einer Liste.
    - Klemmt Koordinaten in den Bereich 0..7 (Out-of-Bounds sicher).
    - Bietet einfache Wetter- und Linien-Funktionen.
    """
    def __init__(self):
        super().__init__()
        self.rotation = 0
        self.logs: List[str] = []
        self.log(f"INIT: hardware={'ja' if HAVE_HW else 'nein'}")

    # --------- Logging ----------
    def log(self, msg: str):
        self.logs.append(f"{_ts()} {msg}")
        if len(self.logs) > 300:
            self.logs = self.logs[-300:]

    def get_log(self) -> List[str]:
        return list(self.logs)

    # --------- Hilfen -----------
    def _clamp_xy(self, x, y):
        xi = int(round(float(x)))
        yi = int(round(float(y)))
        if xi < 0: xi = 0
        if yi < 0: yi = 0
        if xi > 7: xi = 7
        if yi > 7: yi = 7
        return xi, yi

    # --------- LED-Funktionen ---------
    def clear(self, *args, **kwargs):
        """Löscht die Matrix."""
        super().clear(*args, **kwargs)
        self.log("clear()")

    def set_pixel(self, x, y, r=None, g=None, b=None, pixel_color=None):
        """Setzt ein Pixel. Out-of-bounds wird geklemmt und geloggt."""
        if pixel_color is not None:
            r,g,b = _rgb(pixel_color)
        else:
            r = 0 if r is None else int(r)
            g = 0 if g is None else int(g)
            b = 0 if b is None else int(b)
            r,g,b = _rgb((r,g,b))
        xi, yi = self._clamp_xy(x,y)
        if int(round(float(x))) != xi or int(round(float(y))) != yi:
            self.log(f"set_pixel() OOB geklemmt auf ({xi},{yi})")
        super().set_pixel(xi, yi, r, g, b)
        self.log(f"set_pixel({xi},{yi},{r},{g},{b})")

    def get_pixel(self, x, y):
        xi, yi = self._clamp_xy(x,y)
        val = super().get_pixel(xi, yi)
        self.log(f"get_pixel({xi},{yi}) -> {val}")
        return val

    def get_pixels(self):
        arr = super().get_pixels()
        self.log("get_pixels()")
        return arr

    def show_message(self, text, text_color=(255,255,255), bg_color=(0,0,0), scroll_speed=0.07):
        tc = _rgb(text_color); bc = _rgb(bg_color)
        super().show_message(text, text_colour=tc, back_colour=bc, scroll_speed=scroll_speed)
        self.log(f"show_message('{text}')")

    def set_rotation(self, r, invert=False):
        r = int(r) % 360
        super().set_rotation(r, True)
        self.rotation = r
        if invert:
            try:
                super().flip_h(True)
                super().flip_v(True)
            except Exception:
                pass
        self.log(f"set_rotation({r}, invert={invert})")

    def flip_h(self):
        try:
            super().flip_h(True)
        except Exception:
            # Software-Variante erledigt das bereits
            pass
        self.log("flip_h()")

    def flip_v(self):
        try:
            super().flip_v(True)
        except Exception:
            pass
        self.log("flip_v()")

    # --------- Sensoren / Wetter ----------
    def get_temprature(self):  # Schreibweise gemäss Aufgabe
        t = float(super().get_temperature())
        t = round(t, 2)
        self.log(f"get_temprature() -> {t}")
        return t

    def get_pressure(self):
        p = float(super().get_pressure())
        p = round(p, 2)
        self.log(f"get_pressure() -> {p}")
        return p

    def get_humidity(self):
        h = float(super().get_humidity())
        h = round(h, 2)
        self.log(f"get_humidity() -> {h}")
        return h

    def get_meteo_sensor_values(self):
        vals = {
            'temperature': self.get_temprature(),
            'pressure': self.get_pressure(),
            'humidity': self.get_humidity()
        }
        self.log(f"get_meteo_sensor_values() -> {vals}")
        return vals

    def get_weather(self):
        vals = self.get_meteo_sensor_values()
        t,h,p = vals['temperature'], vals['humidity'], vals['pressure']
        if p < 1005 or h > 75:
            w = 'rainy/unstable'
        elif p > 1020 and h < 60:
            w = 'fair/clear'
        else:
            w = 'mixed'
        self.log(f"get_weather() -> {w}")
        return w

    # --------- Linie zeichnen ---------
    def draw_line(self, x1, y1, x2, y2, r=255, g=255, b=255, speed=0.0):
        """Einfache Bresenham-Linie."""
        x1,y1 = self._clamp_xy(x1,y1)
        x2,y2 = self._clamp_xy(x2,y2)
        r,g,b = _rgb((r,g,b))
        dx = abs(x2-x1); sx = 1 if x1<x2 else -1
        dy = -abs(y2-y1); sy = 1 if y1<y2 else -1
        err = dx + dy
        x,y = x1,y1
        while True:
            self.set_pixel(x,y,r,g,b)
            if x==x2 and y==y2: break
            e2 = 2*err
            if e2 >= dy: err += dy; x += sx
            if e2 <= dx: err += dx; y += sy
        self.log(f"draw_line(({x1},{y1})->({x2},{y2}))")
