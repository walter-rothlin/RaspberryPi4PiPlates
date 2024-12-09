import pigpio
import time

class LEDController:

    PIN_RED = 24
    PIN_GREEN = 22
    PIN_BLUE = 17

    pi = pigpio.pi()

    def set(self, pin, value):
        self.pi.set_PWM_dutycycle(pin, value)

    def clear(self):
        self.set(self.PIN_RED, 0)
        self.set(self.PIN_BLUE, 0)
        self.set(self.PIN_GREEN, 0)

    def setGreen(self, value):
        self.set(self.PIN_GREEN, value)

    def setBlue(self, value):
        self.set(self.PIN_BLUE, value)

    def setRed(self, value):
        self.set(self.PIN_RED, value)

    def clearRed(self):
        self.set(self.PIN_RED, 0)

    def clearBlue(self):
        self.set(self.PIN_BLUE, 0)

    def clearGreen(self):
        self.set(self.PIN_GREEN, 0)

