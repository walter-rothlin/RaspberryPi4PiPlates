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

"""Compatibility shim: try to import real SenseHat, then emulator, otherwise provide
a minimal mock SenseHat base class so MySenseHat can be imported and used during
development on machines without the Sense HAT libraries installed.
"""
try:
    from sense_hat import SenseHat
    _BASE_IMPL = 'hardware'
except Exception:
    try:
        from sense_emu import SenseHat
        _BASE_IMPL = 'emulator'
    except Exception:
        # Use the centralized mock implementation from mock_sensehat.py.
        # If it's not available, raise an ImportError so the failure is
        # explicit during development rather than silently falling back.
        try:
            from mock_sensehat import SenseHat
            _BASE_IMPL = 'mock'
        except Exception as e:
            raise ImportError("No SenseHat implementation available: install 'sense_hat', 'sense_emu' or provide 'mock_sensehat.py'.") from e

import time

class MySenseHat:
    """Wrapper around a real SenseHat-like object that provides robust
    helpers (set_pixel, draw_line) while delegating sensor and display calls
    to the underlying implementation. Use composition to ensure a single
    authoritative implementation of public behaviour.
    """

    def __init__(self, base=None):
        """Create a MySenseHat wrapper.

        If `base` is provided, it must implement the SenseHat API (clear,
        set_pixel, get_pixels, show_message, show_letter, get_temperature,
        get_humidity, get_pressure, etc.). If omitted, a default `SenseHat()`
        instance is created from this module's compatibility imports.
        """
        if base is None:
            self._base = SenseHat()
        else:
            self._base = base
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
            # Normalize color input: allow r to be a tuple/list (r,g,b)
            if g is None and b is None and isinstance(r, (tuple, list)) and len(r) == 3:
                rr, gg, bb = r
            else:
                rr, gg, bb = r, g, b

            # Try to coerce color values to ints safely
            try:
                rr_i = int(round(float(rr))) if rr is not None else 0
            except Exception:
                rr_i = 0
            try:
                gg_i = int(round(float(gg))) if gg is not None else 0
            except Exception:
                gg_i = 0
            try:
                bb_i = int(round(float(bb))) if bb is not None else 0
            except Exception:
                bb_i = 0

            # Delegate to the underlying implementation
            try:
                self._base.set_pixel(x_val, y_val, rr_i, gg_i, bb_i)
            except Exception as e:
                # If the base implementation doesn't accept the 5-arg form,
                # try a common alternative (x,y,(r,g,b))
                try:
                    self._base.set_pixel(x_val, y_val, (rr_i, gg_i, bb_i))
                except Exception:
                    # Swallow exceptions to keep behaviour tolerant in tests
                    print(f"Warn: set_pixel delegation failed: {e}")
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

    # --- Delegation helpers so external code can use the SenseHat API ---
    def clear(self, colour=(0, 0, 0)):
        try:
            return self._base.clear(colour)
        except Exception:
            # Some mocks accept no args
            try:
                return self._base.clear()
            except Exception:
                return None

    def get_pixels(self):
        return self._base.get_pixels()

    def set_pixels(self, pixel_list):
        """
        Set a list of pixels on the 8x8 matrix. Accepts a list/tuple of up to 64
        elements where each element is either a (r,g,b) tuple/list or a single
        int (greyscale). Entries beyond 64 are ignored. Invalid entries are
        skipped.
        """
        if not isinstance(pixel_list, (list, tuple)):
            return 0
        count = 0
        for i, p in enumerate(pixel_list[:64]):
            x = i % 8
            y = i // 8
            try:
                # reuse existing set_pixel normalization
                self.set_pixel(x, y, p)
                count += 1
            except Exception:
                # be tolerant: skip bad entries
                continue
        return count

    def show_letter(self, s='?', text_colour=(255, 255, 255), back_colour=(0, 0, 0)):
        try:
            return self._base.show_letter(s, text_colour, back_colour)
        except Exception:
            # Some base implementations expose show_message only
            try:
                return self._base.show_message(s)
            except Exception:
                return None

    def show_message(self, message, scroll_speed=0.1):
        try:
            return self._base.show_message(message, scroll_speed)
        except Exception:
            try:
                return self._base.show_message(message)
            except Exception:
                return None

    def get_temperature(self):
        return self._base.get_temperature()

    def get_humidity(self):
        return self._base.get_humidity()

    def get_pressure(self):
        return self._base.get_pressure()


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