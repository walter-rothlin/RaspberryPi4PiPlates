#!/usr/bin/env python3
"""
MySenseHat – Unterklasse von SenseHat (gemäss UML-Diagramm)

Öffentliche Attribute:
    + default_background_color : (r,g,b)
    + default_foreground_color : (r,g,b)

Überschriebene/Neue Methoden:
    + set_pixel(x, y, color)      # robust: Strings/Float -> int, Grenzprüfung 0..7
    + draw_line(start_point, end_point, bg_color=None, fg_color=None)
        - start_point, end_point als (x, y)-Tupel/Listen (Strings/Float erlaubt)
        - vertikale Linien werden speziell behandelt
        - hohe Auflösung (step=0.1) bei steilen Geraden (|a| > 1)
        - wenn bg_color gesetzt ist, wird das Display vorher damit gefüllt
"""

from __future__ import annotations
from sense_hat import SenseHat


class MySenseHat(SenseHat):
    """Unterklasse gemäss UML mit robustem set_pixel und draw_line."""

    WIDTH = 8
    HEIGHT = 8

    def __init__(self):
        super().__init__()
        # Öffentliche Attribute gemäss Diagramm
        self.default_background_color = (0, 0, 0)
        self.default_foreground_color = (255, 255, 255)
        print("MySenseHat initialized")

    # ------------------------------ Helpers ----------------------------------
    @staticmethod
    def _to_int_coord(value) -> int:
        """int/float/str -> gerundeter int; ValueError bei Ungeeignetem."""
        v = float(value)
        return int(round(v))

    @staticmethod
    def _normalize_color(color) -> tuple[int, int, int]:
        """(r,g,b) auf 0..255 einrenken; erlaubt int/float/str."""
        if not isinstance(color, (tuple, list)) or len(color) != 3:
            raise ValueError("color must be a tuple/list of length 3")
        out = []
        for c in color:
            c = int(round(float(c)))
            out.append(max(0, min(255, c)))
        return tuple(out)

    @staticmethod
    def _parse_point(pt) -> tuple[float, float]:
        """(x,y) als tuple/list (auch str/float) -> (float, float)."""
        if not isinstance(pt, (tuple, list)) or len(pt) != 2:
            raise ValueError("point must be a 2-tuple/list (x, y)")
        x, y = pt
        return float(x), float(y)

    def _in_bounds(self, x: int, y: int) -> bool:
        return 0 <= x < self.WIDTH and 0 <= y < self.HEIGHT

    # -------------------------- Override: set_pixel --------------------------
    def set_pixel(self, x, y, color):
        """
        Erweiterung:
        - x, y dürfen str/float/int sein -> werden zu gerundeten ints
        - color wird auf (r,g,b) 0..255 normalisiert
        - out-of-range wird NICHT an die Oberklasse durchgereicht
        """
        try:
            xi = self._to_int_coord(x)
            yi = self._to_int_coord(y)
        except (TypeError, ValueError):
            print(f"Fehler: Ungültige Koordinaten x={x!r}, y={y!r}")
            return

        try:
            color = self._normalize_color(color)
        except (TypeError, ValueError):
            print(f"Fehler: Ungültige Farbe color={color!r}")
            return

        if self._in_bounds(xi, yi):
            super().set_pixel(xi, yi, color)
        else:
            print(f"Warnung: Pixel ({xi},{yi}) ausserhalb 0..7 -> ignoriert")

    # ------------------------------ draw_line --------------------------------
    def draw_line(self, start_point, end_point, bg_color=None, fg_color=None):
        """
        Zeichnet eine Linie zwischen zwei Punkten (x,y).
        - start_point, end_point: (x, y) – str/float erlaubt.
        - fg_color: Linienfarbe; fällt auf default_foreground_color zurück.
        - bg_color: optional; wenn gesetzt, wird das Display vorher damit gefüllt.
        """
        try:
            x1, y1 = self._parse_point(start_point)
            x2, y2 = self._parse_point(end_point)
        except (TypeError, ValueError) as e:
            print(f"Fehler: {e}")
            return

        # Farben vorbereiten
        if fg_color is None:
            color = self.default_foreground_color
        else:
            try:
                color = self._normalize_color(fg_color)
            except (TypeError, ValueError):
                print(f"Fehler: Ungültige fg_color={fg_color!r}")
                return

        if bg_color is not None:
            try:
                self.clear(self._normalize_color(bg_color))
            except (TypeError, ValueError):
                print(f"Fehler: Ungültige bg_color={bg_color!r}")
                return

        # Vertikale Linie
        if x2 == x1:
            y_min, y_max = sorted((y1, y2))
            y = y_min
            step = 0.1  # feine Schrittweite für geschlossene Linie
            while y <= y_max + 1e-9:
                self.set_pixel(x1, y, color)
                y += step
            return

        # Allgemeine Gerade: y = a*x + b
        a = (y2 - y1) / (x2 - x1)
        b = y1 - a * x1

        step = 0.1 if abs(a) > 1 else 1.0  # „grosse Auflösung“ bei |a|>1
        x = x1
        forward = x2 >= x1
        while (x <= x2 + 1e-9) if forward else (x >= x2 - 1e-9):
            y = a * x + b
            self.set_pixel(x, y, color)
            x += step if forward else -step


# ----------------------------- Demo / Tests ---------------------------------
def _demo():
    hat = MySenseHat()

    print("\n--- Test A: default colors sichtbar machen ---")
    hat.clear(hat.default_background_color)

    print("\n--- Test B: set_pixel im Bereich ---")
    hat.set_pixel(4, 5, (255, 0, 0))  # rot

    print("\n--- Test C: Out-of-Range wird abgefangen ---")
    hat.set_pixel(8, 5, (0, 255, 0))  # ausserhalb -> Warnung

    print("\n--- Test D: Dezimal- und String-Koordinaten ---")
    hat.set_pixel("2", "3.6", (0, 0, 255))  # (2,4) nach Rundung

    print("\n--- Test E: draw_line gemäss UML-Signatur ---")
    hat.draw_line((0, 0), (7, 7), bg_color=(0, 0, 64), fg_color=(255, 255, 255))
    hat.draw_line((3, 0), (3, 7), fg_color=(255, 0, 0))
    hat.draw_line((1, -3), (2, 10), fg_color=(255, 255, 0))

    print("\nFertig. (Auf der LED-Matrix solltest du die Linien sehen.)")


if __name__ == "__main__":
    _demo()
