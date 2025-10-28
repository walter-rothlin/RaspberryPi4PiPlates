# Class_My_SenseHat.py
# Wrapper um SenseHat mit:
# - Fallback/Mock, falls Sense HAT lib nicht verfügbar
# - Robustem Farb-Parser (Hex/Name/CSV/Grau)
# - Bounds-Checks + Clamping bei set/get_pixel
# - Matrix-Cache, Flip/Rotation, Bresenham draw_line

from math import copysign
import re

try:
    from sense_hat import SenseHat as _SenseHatReal
    _HAVE_REAL = True
except Exception:
    _HAVE_REAL = False

try:
    import webcolors
except Exception:
    webcolors = None

class _SenseHatMock:
    def __init__(self):
        self._rotation = 0
        self._mat = [[(0,0,0) for _ in range(8)] for __ in range(8)]
        self._t = 22.5
        self._h = 45.0
        self._p = 1013.0

    # Sensoren
    def get_temperature(self): return self._t
    def get_humidity(self):    return self._h
    def get_pressure(self):    return self._p

    # Matrix
    def clear(self, colour=(0,0,0)):
        for y in range(8):
            for x in range(8):
                self._mat[y][x] = tuple(colour)

    def set_pixel(self, x, y, r, g, b):
        if 0 <= x < 8 and 0 <= y < 8:
            self._mat[y][x] = (int(r), int(g), int(b))

    def get_pixel(self, x, y):
        if 0 <= x < 8 and 0 <= y < 8:
            return self._mat[y][x]
        return (0,0,0)

    def get_pixels(self):
        # flatten 8x8 -> 64 Tripel
        return [c for row in self._mat for c in row]

    def set_rotation(self, angle):
        self._rotation = angle % 360

    def flip_h(self):
        for y in range(8):
            self._mat[y] = list(reversed(self._mat[y]))

    def flip_v(self):
        self._mat = list(reversed(self._mat))

    def show_letter(self, s='?', text_colour=(255,255,255), back_colour=(0,0,0)):
        # Simple Platzhalter: Matrix einfärben
        self.clear(back_colour)
        # Ein paar Pixel setzen (kein echter Font)
        pts = [(2,2),(3,2),(4,2),(3,3),(3,4)]
        for (x,y) in pts:
            self.set_pixel(x,y,*text_colour)

    def show_message(self, text, scroll_speed=0.1, text_colour=(255,255,255), back_colour=(0,0,0)):
        # Mock: füllt kurz die Matrix
        self.clear(back_colour)
        for i in range(min(len(text),8)):
            self.set_pixel(i, i, *text_colour)

class MySenseHat:
    def __init__(self):
        if _HAVE_REAL:
            self._sense = _SenseHatReal()
        else:
            self._sense = _SenseHatMock()
        self.rotation = 0  # eigener Rotation-Status

    # ---------- Parser ----------
    def parse_int(self, v, default=0, min_=None, max_=None):
        try:
            val = int(float(str(v).strip().replace(',', '.')))
            if min_ is not None and val < min_: val = min_
            if max_ is not None and val > max_: val = max_
            return val
        except Exception:
            return default

    def parse_float(self, v, default=0.0, min_=None, max_=None):
        try:
            val = float(str(v).strip().replace(',', '.'))
            if min_ is not None and val < min_: val = min_
            if max_ is not None and val > max_: val = max_
            return val
        except Exception:
            return default

    def parse_rgb(self, value, default=(0,0,0)):
        if value is None:
            return default
        if isinstance(value, (list, tuple)) and len(value) == 3:
            return tuple(self._clip(int(x)) for x in value)
        s = str(value).strip().lower().replace(' ', '').replace("'", "")
        # hex
        if s.startswith('#'): s = s[1:]
        if re.fullmatch(r'[0-9a-f]{6}', s):
            r = int(s[0:2], 16); g = int(s[2:4], 16); b = int(s[4:6], 16)
            return (r, g, b)
        # css name
        if webcolors:
            try:
                rgb = webcolors.name_to_rgb(s)
                return (rgb.red, rgb.green, rgb.blue)
            except ValueError:
                pass
        # "r,g,b" oder "r g b"
        s2 = s.replace('(', '').replace(')', '')
        parts = re.split(r'[,\s]+', s2)
        if len(parts) == 3:
            try:
                r,g,b = (self._clip(int(p)) for p in parts)
                return (r,g,b)
            except Exception:
                return default
        # Zahl -> grau
        try:
            v = self._clip(int(float(s)))
            return (v,v,v)
        except Exception:
            return default

    def _clip(self, v):
        return max(0, min(255, int(v)))

    def _clamp_xy(self, x, y):
        cx = max(0, min(7, int(x)))
        cy = max(0, min(7, int(y)))
        return (cx, cy), (cx != x or cy != y)

    # ---------- Sensoren ----------
    def get_temperature(self):
        return float(self._sense.get_temperature())

    def get_humidity(self):
        return float(self._sense.get_humidity())

    def get_pressure(self):
        return float(self._sense.get_pressure())

    # ---------- Matrix ----------
    def clear(self, colour=(0,0,0)):
        c = self.parse_rgb(colour, default=(0,0,0))
        self._sense.clear(c)

    def set_rotation(self, angle):
        angle = (int(angle) // 90) * 90
        self.rotation = angle
        try:
            self._sense.set_rotation(angle)
        except Exception:
            # Mock hat eigenes Feld bereits
            if hasattr(self._sense, 'set_rotation'):
                self._sense.set_rotation(angle)

    def flip_h(self):
        if hasattr(self._sense, 'flip_h'):
            self._sense.flip_h()
        else:
            # Notfall: manuell spiegeln via get/set
            rows = [self.get_row(y) for y in range(8)]
            for y in range(8):
                rows[y] = list(reversed(rows[y]))
            self._apply_rows(rows)

    def flip_v(self):
        if hasattr(self._sense, 'flip_v'):
            self._sense.flip_v()
        else:
            rows = [self.get_row(y) for y in range(8)]
            rows = list(reversed(rows))
            self._apply_rows(rows)

    def get_pixels(self):
        # Als Liste von 64 Tripeln
        data = self._sense.get_pixels()
        # Reale SenseHat liefert flache Liste von 64 (r,g,b)
        # Mock liefert bereits so; wir normalisieren auf [ [r,g,b], ... ]
        norm = []
        for c in data:
            if isinstance(c, (list, tuple)) and len(c) == 3:
                norm.append([int(c[0]), int(c[1]), int(c[2])])
            else:
                norm.append([0,0,0])
        return norm

    def set_pixel(self, x, y, colour):
        (cx, cy), clamped = self._clamp_xy(x, y)
        r,g,b = self.parse_rgb(colour, default=(0,0,0))
        self._sense.set_pixel(cx, cy, r, g, b)
        return clamped, cx, cy

    def get_pixel(self, x, y):
        (cx, cy), clamped = self._clamp_xy(x, y)
        rgb = self._sense.get_pixel(cx, cy)
        if isinstance(rgb, (list, tuple)) and len(rgb) == 3:
            rgb = (int(rgb[0]), int(rgb[1]), int(rgb[2]))
        else:
            rgb = (0,0,0)
        return clamped, cx, cy, rgb

    def show_letter(self, s='?', text_colour=(255,255,255), back_colour=(0,0,0)):
        tc = self.parse_rgb(text_colour, default=(255,255,255))
        bc = self.parse_rgb(back_colour, default=(0,0,0))
        self._sense.show_letter(s=s, text_colour=tc, back_colour=bc)

    def show_message(self, text, scroll_speed=0.1, text_colour=(255,255,255), back_colour=(0,0,0)):
        tc = self.parse_rgb(text_colour, default=(255,255,255))
        bc = self.parse_rgb(back_colour, default=(0,0,0))
        self._sense.show_message(text, scroll_speed=scroll_speed, text_colour=tc, back_colour=bc)

    # Hilfen für Flip-Notfälle
    def get_row(self, y):
        return [self._sense.get_pixel(x, y) for x in range(8)]
    def _apply_rows(self, rows):
        for y in range(8):
            for x in range(8):
                r,g,b = rows[y][x]
                self._sense.set_pixel(x, y, r, g, b)

    # ---------- Linienzeichnen (Bresenham) ----------
    def draw_line(self, x1, y1, x2, y2, colour):
        colour = self.parse_rgb(colour, default=(255,255,255))
        # Bresenham-Algorithmus
        points = []
        dx = abs(x2 - x1)
        dy = -abs(y2 - y1)
        sx = 1 if x1 < x2 else -1
        sy = 1 if y1 < y2 else -1
        err = dx + dy
        x, y = x1, y1

        while True:
            # Pixel setzen mit Clamping
            self.set_pixel(x, y, colour)
            (cx, cy), _ = self._clamp_xy(x, y)
            points.append({'x': x, 'y': y, 'used_x': cx, 'used_y': cy})
            if x == x2 and y == y2:
                break
            e2 = 2 * err
            if e2 >= dy:
                err += dy
                x += sx
            if e2 <= dx:
                err += dx
                y += sy
        return points
