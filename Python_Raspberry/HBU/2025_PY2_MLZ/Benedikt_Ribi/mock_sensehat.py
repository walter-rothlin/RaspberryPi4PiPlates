#!/usr/bin/env python3
"""Lightweight mock SenseHat implementation used for local development and tests.
Centralizes the mock so it exists only once in the codebase.
"""

class SenseHat:
    def __init__(self):
        self._pixels = [(0, 0, 0)] * 64

    def clear(self, colour=(0, 0, 0)):
        try:
            if isinstance(colour, (list, tuple)) and len(colour) == 3:
                rgb = tuple(int(min(max(0, int(v)), 255)) for v in colour)
            else:
                rgb = (0, 0, 0)
        except Exception:
            rgb = (0, 0, 0)
        self._pixels = [rgb] * 64

    def get_pixels(self):
        return list(self._pixels)

    def get_humidity(self):
        return 50.0

    def get_temperature(self):
        return 20.0

    def get_pressure(self):
        return 1013.25

    def show_letter(self, s='?', text_colour=(255, 255, 255), back_colour=(0, 0, 0)):
        # no-op for mock
        pass

    def show_message(self, message, scroll_speed=0.1):
        # no-op for mock
        pass

    def set_pixel(self, x, y, r, g=None, b=None):
        # Accept either (x,y,r,g,b) or (x,y,(r,g,b))
        if g is None and b is None and isinstance(r, (list, tuple)) and len(r) == 3:
            rr, gg, bb = r
        else:
            rr, gg, bb = r, g, b

        try:
            x_i = int(round(float(x)))
            y_i = int(round(float(y)))
        except Exception:
            return

        if 0 <= x_i < 8 and 0 <= y_i < 8:
            try:
                rr_i = int(round(float(rr))) if rr is not None else 0
                gg_i = int(round(float(gg))) if gg is not None else 0
                bb_i = int(round(float(bb))) if bb is not None else 0
            except Exception:
                rr_i, gg_i, bb_i = 0, 0, 0
            idx = y_i * 8 + x_i
            self._pixels[idx] = (rr_i % 256, gg_i % 256, bb_i % 256)
