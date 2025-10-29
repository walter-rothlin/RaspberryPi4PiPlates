#! /usr/bin/env python3

# ##############################################################################
# LZK2 Python 2: Sub-Class of Sense (Hat)
# Autor: Christian Meier
# Created: 2025-10-01
# Changes: 2025-10-27 Added draw_speed parameter to draw_line method
#
# Getestet mit Python 3.11.2 auf Debian 12.12 (Raspberry Pi OS)
#
# Eingesetzte Hilfsmittel:
# - Editor: Visual Studio Code
# - Linter / Formatter Plugin: Ruff
# - Code Completion: GitHub Copilot
# ##############################################################################

from time import sleep
from sense_hat import SenseHat


class MySenseHat(SenseHat):
    max_matrix_idx = 7
    min_matrix_idx = 0

    def __init__(self, debug=False):
        super().__init__()
        self.debug = debug

    @property
    def debug(self):
        return self.__debug

    @debug.setter
    def debug(self, value):
        self.__debug = bool(value)

    def __is_inside_matrix(self, x, y):
        """Check if coordinates (x, y) are inside the led matrix."""
        inside = (
            self.max_matrix_idx >= x >= self.min_matrix_idx
            and self.max_matrix_idx >= y >= self.min_matrix_idx
        )
        if self.debug and not inside:
            print(f"DEBUG: Coordinates ({x}, {y}) are out of matrix bounds.")
        return inside

    def __convert_to_int(self, value):
        """Convert value to int if possible, otherwise return None."""
        if isinstance(value, int):
            return value
        if isinstance(value, float):
            return int(round(value))
        if isinstance(value, str):
            try:
                value = float(value)
            except ValueError:
                if self.debug:
                    print(f"DEBUG: Cannot convert '{value}' to float.")
                return None
            return int(round(value))
        if self.debug:
            print(f"DEBUG: Unsupported type '{type(value)}' for conversion to int.")
        return None

    def set_pixel(self, x, y, *args):
        """Override SenseHat.set_pixel, Does not raise out of matrix errors. Accepts int, float or string for coordinates."""
        x = self.__convert_to_int(x)
        y = self.__convert_to_int(y)
        if x is None or y is None:
            return
        if not self.__is_inside_matrix(x, y):
            return
        super().set_pixel(x, y, *args)

    def draw_line(self, x_start, y_start, x_end, y_end, color, draw_speed=0):
        """Draw a line from (x_start, y_start) to (x_end, y_end) using Bresenham's Line Algorithm."""
        x_start = self.__convert_to_int(x_start)
        y_start = self.__convert_to_int(y_start)
        x_end = self.__convert_to_int(x_end)
        y_end = self.__convert_to_int(y_end)
        if None in (x_start, y_start, x_end, y_end):
            return

        # 1:1 implementation from Wikipedia (bottom of the page code section)
        # Source: https://en.wikipedia.org/wiki/Bresenham's_line_algorithm
        dx = abs(x_end - x_start)
        sx = 1 if x_start < x_end else -1
        dy = -abs(y_end - y_start)
        sy = 1 if y_start < y_end else -1
        error = dx + dy

        pixels = []
        while True:
            pixels.append((x_start, y_start, color))
            e2 = 2 * error
            if e2 >= dy:
                if x_start == x_end:
                    break
                error += dy
                x_start += sx
            if e2 <= dx:
                if y_start == y_end:
                    break
                error += dx
                y_start += sy
        for pixel in pixels:
            self.set_pixel(pixel[0], pixel[1], pixel[2])
            if draw_speed > 0 and 7 >= pixel[0] >= 0 and 7 >= pixel[1] >= 0:
                sleep(draw_speed)


if __name__ == "__main__":
    # TEST FUNCTIONS ###########################################################
    s = MySenseHat(debug=True)

    def test_set_pixel():
        test_cases = [
            (4, 5, (255, 0, 0)),  # valid int input
            (8, 5, (0, 255, 0)),  # out of range
            (-1, -1, (255, 255, 255)),  # out of range
            (3.6, 4.2, (0, 0, 255)),  # valid float input
            (-3.6, -4.2, (0, 0, 255)),  # out of range
            ("5", "2", (255, 255, 0)),  # valid string input
            ("8", "-2", (255, 0, 255)),  # out of range
            ("a", "b", (255, 255, 255)),  # invalid string input
            ((99, 10), [5, 7], (255, 255, 255)),  # invalid input types
        ]
        s.clear()
        for x, y, color in test_cases:
            s.set_pixel(x, y, color)
            sleep(0.5)
        sleep(2)

    def test_draw_line():
        test_cases = [
            # horizontal, vertical and diagonal lines
            (0, 0, 7, 7, (255, 0, 0)),  # diagonal line
            (0, 7, 7, 0, (0, 255, 0)),  # diagonal line
            (-1.2, 2.8, 8.3, 2.6, (0, 0, 255)),  # horizontal line
            (3, -1, 3, 8, (255, 255, 0)),  # vertical line
            ("-1", "-1", "6.8", "7.2", (255, 165, 0)),  # string coordinates
            # non 45 degree lines
            (0, 3, 7, 6, (255, 165, 0)),  # shallow slope +
            (0, 5, 7, 3, (255, 165, 0)),  # shallow slope -
            (3, 0, 6, 7, (128, 0, 128)),  # steep slope +
            (3, 7, 5, 0, (128, 0, 128)),  # steep slope -
            # invalid inputs
            ("a", "b", "c", "d", (255, 255, 255)),  # invalid string coordinates
            ((0, 1), 0, (-4, 10), 10, (255, 255, 255)),  # invalid input types
        ]
        for x0, y0, x1, y1, color in test_cases:
            s.clear()
            s.draw_line(x0, y0, x1, y1, color)
            sleep(2)

    # EXECUTE TESTS ############################################################
    s.clear()
    test_set_pixel()
    s.clear()
    test_draw_line()
