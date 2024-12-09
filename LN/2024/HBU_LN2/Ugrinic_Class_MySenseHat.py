#!/usr/bin/python3
# ------------------------------------------------------------------
# Name: MySenseHat.py
#
# Description: Lernzielkontrolle 2
#
# Autor: Djordje Ugrinic
#
# History:
# 03-Dec-2024	Djordje Ugrinic     create file
# 03-Dec-2024	Djordje Ugrinic     write subclass
# 03-Dec-2024	Djordje Ugrinic     test
#
# ------------------------------------------------------------------
from sense_hat import SenseHat

class MySenseHat(SenseHat):
    def __init__(self):
        super().__init__()
        self.default_background_color = (0, 0, 0)
        self.default_foreground_color = (255, 255, 255)

    def set_pixel(self, x, y, *args, **kwargs):
        try:
            x = float(x)
            y = float(y)
            x = int(round(x))
            y = int(round(y))
        except ValueError:
            print(f"Invalid x or y value: x={x}, y={y}")
            return

        if 0 <= x <= 7 and 0 <= y <= 7:
            super().set_pixel(x, y, *args, **kwargs)
        else:
            print(f"x or y value out of bounds: x={x}, y={y}")

    def draw_line(self, start_point, end_point, bg_color=None, fg_color=None):
        bg_color = bg_color or self.default_background_color
        fg_color = fg_color or self.default_foreground_color

        x_start, y_start = start_point
        x_end, y_end = end_point

        try:
            x_start = float(x_start)
            y_start = float(y_start)
            x_end = float(x_end)
            y_end = float(y_end)
        except ValueError:
            print("Invalid start or end point values")
            return

        dx = x_end - x_start
        dy = y_end - y_start

        steps = int(max(abs(dx), abs(dy)))

        if steps == 0:
            self.set_pixel(x_start, y_start, fg_color)
            return

        x_increment = dx / steps
        y_increment = dy / steps

        x = x_start
        y = y_start

        for _ in range(steps + 1):
            self.set_pixel(x, y, fg_color)
            x += x_increment
            y += y_increment

# =================
# Automated Testing
# =================
def AUTO_TEST_set_pixel(verbal=False):
    test_suite = 'set_pixel'
    tests_performed = 0
    tests_failed = 0
    test_cases = """
        Nr|x      |y      |color         |Expected_Output
        # Valid inputs within bounds
        01|2      |3      |(255,0,0)    |Success
        02|6      |6      |(0,255,0)    |Success
        03|0.9    |4.2    |(0,0,255)    |Success
        04|7      |7      |(255,255,255)|Success
        
        # Invalid inputs outside bounds
        10|-1     |2      |(255,0,0)    |Out of bounds
        11|8      |6      |(0,255,0)    |Out of bounds
        12|5      |-3     |(0,0,255)    |Out of bounds
        13|3      |8      |(255,255,255)|Out of bounds

        # Inputs as strings
        20|"2"    |"3"    |(255,0,0)    |Success
        21|"6.5"  |"3.7"  |(0,255,0)    |Success
        22|"8"    |"7"    |(0,0,255)    |Out of bounds

        # Invalid string inputs
        30|"abc"  |"4"    |(255,0,0)    |Invalid input
        31|"2"    |"xyz"  |(0,255,0)    |Invalid input
    """

    if verbal:
        print("")
        print("=" * 30)
        print(f"Testsuite: {test_suite}")
        print("=" * 30)

    list_of_test_cases = test_cases.strip().split("\n")
    for a_test_case in list_of_test_cases[2:]:
        if a_test_case.strip() == "":
            continue

        if a_test_case.strip().startswith('#'):
            if verbal:
                print("-" * 30)
                print(a_test_case.strip())
            continue

        # Prepare Test
        tests_performed += 1
        list_of_test_values = a_test_case.split("|")
        test_case = list_of_test_values[0].strip()

        x = list_of_test_values[1].strip()
        y = list_of_test_values[2].strip()
        color = eval(list_of_test_values[3].strip())
        expected_result = list_of_test_values[4].strip()

        # Perform Test
        try:
            sense = MySenseHat()
            sense.set_pixel(x, y, color)

            if 0 <= int(float(x)) <= 7 and 0 <= int(float(y)) <= 7:
                result = "Success"
            else:
                result = "Out of bounds"

            if result != expected_result:
                tests_failed += 1
                print(f"Test {test_case} failed!")
                print(f"  Input: set_pixel({x}, {y}, {color})")
                print(f"  Expected: {expected_result}, Got: {result}")
        except ValueError:
            result = "Invalid input"
            if result != expected_result:
                tests_failed += 1
                print(f"Test {test_case} failed!")
                print(f"  Input: set_pixel({x}, {y}, {color})")
                print(f"  Expected: {expected_result}, Got: {result}")
        except Exception as e:
            tests_failed += 1
            print(f"Test {test_case} failed with exception: {e}")

    if verbal:
        print("\nSummary:")
        print(f"  Tests performed: {tests_performed}")
        print(f"  Tests failed   : {tests_failed}")

# Run Tests
if __name__ == '__main__':
    print("Running automated tests...\n")
    AUTO_TEST_set_pixel(verbal=True)

    # Example manual tests
    sense = MySenseHat()
    sense.set_pixel(4, 5, (255, 0, 0))  # Red pixel
    sense.set_pixel(8, 5, (0, 255, 0))  # Out of bounds
    sense.draw_line((1, 1), (6, 4), fg_color=(0, 0, 255))  # Blue line
    sense.draw_line((2, 2), (2, 6), fg_color=(255, 255, 0))  # Yellow vertical line
