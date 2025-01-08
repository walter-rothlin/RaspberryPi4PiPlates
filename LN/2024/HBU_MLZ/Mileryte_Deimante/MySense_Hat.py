from sense_hat import SenseHat

class MySense_Hat:
    def __init__(self):
        self.sense = SenseHat()

    def get_temperature(self):
        return self.sense.get_temperature()

    def get_humidity(self):
        return self.sense.get_humidity()

    def get_pressure(self):
        return self.sense.get_pressure()

    def set_pixel(self, x, y, r, g, b):
        if 0 <= x <= 7 and 0 <= y <= 7:
            self.sense.set_pixel(x, y, r, g, b)
        else:
            raise ValueError(f"Invalid coordinates: ({x}, {y}). x and y must be between 0 and 7.")

    def clear(self, r=0, g=0, b=0):
        self.sense.clear(r, g, b)

    def show_message(self, message, text_colour=(255, 255, 255), scroll_speed=0.1):
        self.sense.show_message(message, text_colour=text_colour, scroll_speed=scroll_speed)

    def set_rotation(self, r, redraw=True):
        if r not in [0, 90, 180, 270]:
            raise ValueError("Invalid rotation angle. Must be one of 0, 90, 180, or 270 degrees.")
        
        self.sense.set_rotation(r)
        
        if redraw:
            self.sense.clear()

    def show_letter(self, char, text_colour=(255, 255, 255), back_colour=(0, 0, 0)):
        self.sense.show_letter(char, text_colour=text_colour, back_colour=back_colour)