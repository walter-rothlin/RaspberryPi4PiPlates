#!/usr/bin/python3




from sense_hat import SenseHat

class MySenseHat(SenseHat):
    def __init__(self):
        # Initialisierung der Superklasse
        super().__init__()
        self.default_background_color = (0, 0, 0)  #Schwarz
        self.default_foreground_color = (255, 255, 255)  #Weiss
    
    def set_pixel(self, x, y, color):
        """Überschreibt die set_pixel-Methode, überprüft die Eingaben und Grenzen."""
        try:
            # Konvertiere Strings und Dezimalzahlen zu Ganzzahlen
            x = round(float(x))
            y = round(float(y))
        except ValueError:
            print("Fehler: x und y müssen gültige Zahlen sein.")
            return

        # Überprüfen, ob die Koordinaten im gültigen Bereich liegen
        if 0 <= x <= 7 and 0 <= y <= 7:
            super().set_pixel(x, y, color)
        else:
            print(f"Fehler: Pixel-Koordinaten ({x}, {y}) liegen ausserhalb der Grenzen.")

    def draw_line(self, x_start, y_start, x_end, y_end, color=(255, 255, 255)):
        """Zeichnet eine Linie basierend auf der Formel y = ax + b."""
        try:
            # Konvertiere und runde Eingaben
            x_start, y_start = round(float(x_start)), round(float(y_start))
            x_end, y_end = round(float(x_end)), round(float(y_end))
        except ValueError:
            print("Fehler: Start- und End-Koordinaten müssen gültige Zahlen sein.")
            return

        dx = x_end - x_start
        dy = y_end - y_start

        if dx == 0:  # Vertikale Linie
            step = 1 if y_end > y_start else -1
            for y in range(y_start, y_end + step, step):
                self.set_pixel(x_start, y, color)
        else:
            a = dy / dx
            b = y_start - a * x_start

            if abs(a) <= 1:  # Flache Linie
                step = 1 if x_end > x_start else -1
                for x in range(x_start, x_end + step, step):
                    y = round(a * x + b)
                    self.set_pixel(x, y, color)
            else:  # Steile Linie
                step = 1 if y_end > y_start else -1
                for y in range(y_start, y_end + step, step):
                    x = round((y - b) / a)
                    self.set_pixel(x, y, color)

if __name__ == "__main__":
    # Test-Programm
    print("Test-Programm gestartet...")
    my_sense = MySenseHat()

    # Test: Pixel setzen
    print("Setze Pixel auf rot bei (4, 5):")
    my_sense.set_pixel(4, 5, (255, 0, 0))  # Rot

    print("Setze Pixel auf grün bei (8, 5):")
    my_sense.set_pixel(8, 5, (0, 255, 0))  # Grün (ausserhalb der Grenzen)

    # Test: Linie zeichnen
    print("Zeichne eine Linie von (0, 0) nach (7, 7):")
    my_sense.draw_line(0, 0, 7, 7, (0, 0, 255))  # Blau

    print("Zeichne eine vertikale Linie von (3, 0) nach (3, 7):")
    my_sense.draw_line(3, 0, 3, 7, (255, 255, 0))  # Gelb

    print("Test abgeschlossen.")

