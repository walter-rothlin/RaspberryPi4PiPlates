#!/usr/bin/python3

#print('Hallo Flo,tt')

from sense_hat import SenseHat


class MySenseHat(SenseHat):
    def __init__(self):
        """
        Konstruktor der abgeleiteten Klasse MySenseHat.
        """
        super().__init__()

    def set_pixel(self, x, y, r, g, b):
        """
        Überschriebene set_pixel Methode:
        - Verhindert Aufrufe außerhalb der Matrixgrenzen.
        - Unterstützt Dezimalzahlen und Strings für x und y.
        """
        try:
            # Konvertieren und Runden
            x = self._convert_to_int(x)
            y = self._convert_to_int(y)

            # Begrenzungsprüfung
            if 0 <= x < 8 and 0 <= y < 8:
                super().set_pixel(x, y, r, g, b)
            else:
                print(f"Warnung: Pixel ({x}, {y}) liegt außerhalb der Matrix.")
        except ValueError as e:
            print(f"Fehler: Ungültige Eingabe für x oder y: {e}")

    def draw_line(self, x_start, y_start, x_end, y_end, r=255, g=255, b=255):
        """
        Zeichnet eine Linie zwischen zwei Punkten.
        - Unterstützt Punkte außerhalb der Matrix.
        - Zeichnet vertikale und steile Linien korrekt.
        """
        try:
            # Konvertieren und Runden
            x_start = self._convert_to_int(x_start)
            y_start = self._convert_to_int(y_start)
            x_end = self._convert_to_int(x_end)
            y_end = self._convert_to_int(y_end)

            # Vertikale Linie
            if x_start == x_end:
                step = 1 if y_start < y_end else -1
                for y in range(y_start, y_end + step, step):
                    self.set_pixel(x_start, y, r, g, b)
            else:
                # Berechnung der linearen Funktion y = a*x + b
                a = (y_end - y_start) / (x_end - x_start)
                b = y_start - a * x_start

                # Linienzeichnung
                if abs(a) <= 1:  # Für |a| <= 1 iteriere über x
                    step = 1 if x_start < x_end else -1
                    for x in range(x_start, x_end + step, step):
                        y = a * x + b
                        self.set_pixel(x, round(y), r, g, b)
                else:  # Für |a| > 1 iteriere über y
                    step = 1 if y_start < y_end else -1
                    for y in range(y_start, y_end + step, step):
                        x = (y - b) / a
                        self.set_pixel(round(x), y, r, g, b)
        except ZeroDivisionError:
            print("Fehler: Start- und Endpunkte dürfen nicht identisch sein.")
        except Exception as e:
            print(f"Fehler beim Zeichnen der Linie: {e}")

    @staticmethod
    def _convert_to_int(value):
        """
        Wandelt einen Wert in einen Integer um.
        Unterstützt Strings und Dezimalzahlen.
        """
        try:
            return int(round(float(value)))
        except (ValueError, TypeError):
            raise ValueError(f"Ungültiger Wert: {value}")


if __name__ == "__main__":
    # Testprogramm
    my_sense = MySenseHat()

    # Test 1: Pixel setzen
    print("Test: Einzelne Pixel setzen")
    my_sense.set_pixel(4, 5, 255, 0, 0)  # Rot (innerhalb der Matrix)
    my_sense.set_pixel(8, 5, 0, 255, 0)  # Grün (außerhalb der Matrix, Warnung)

    # Test 2: Linien zeichnen
    print("Test: Linien zeichnen")
    my_sense.draw_line(1, 1, 7, 5)  # Schräge Linie innerhalb der Matrix
    my_sense.draw_line(0, 0, 0, 9)  # Vertikale Linie
    my_sense.draw_line(-2, -2, 10, 10)  # Linie teilweise außerhalb der Matrix