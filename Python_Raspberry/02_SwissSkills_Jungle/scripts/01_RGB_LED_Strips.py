#!/usr/bin/python
#
# ------------------------------------------------------------------
# Name  : 01_RGB_LED_Strips.py
# ------------------------------------------------------------------
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/02_SwissSkilla_Jungle/scripts/01_RGB_LED_Strips.py
#
# Description: Swissskills
# 
# Autor: Walter Rothlin
#
# History:
# 08-Sep-2025   Walter Rothlin      Initial Version
# ------------------------------------------------------------------
import RPi.GPIO as GPIO
import time

class LEDController:

    PIN_RED   = 17
    PIN_GREEN = 22
    PIN_BLUE  = 27

    def __init__(self):
        print(f'__init()__...')
        GPIO.setmode(GPIO.BCM)
        GPIO.setwarnings(False)

        print(f' PINS as OUT')
        GPIO.setup(self.PIN_RED, GPIO.OUT)
        GPIO.setup(self.PIN_GREEN, GPIO.OUT)
        GPIO.setup(self.PIN_BLUE, GPIO.OUT)

        print(f' PINS as PWM')
        self.pwm_red   = GPIO.PWM(self.PIN_RED, 1000)
        self.pwm_green = GPIO.PWM(self.PIN_GREEN, 1000)
        self.pwm_blue  = GPIO.PWM(self.PIN_BLUE, 1000)

        print(f' PINS start')
        self.pwm_red.start(0)
        self.pwm_green.start(0)
        self.pwm_blue.start(0)
        
        print(f'.... __init()__ done')

    def set(self, pin, value):
        # common-cathode
        duty = max(0, min(100, int(value / 255 * 100)))
        if pin == self.PIN_RED:
            self.pwm_red.ChangeDutyCycle(duty)
        elif pin == self.PIN_GREEN:
            self.pwm_green.ChangeDutyCycle(duty)
        elif pin == self.PIN_BLUE:
            self.pwm_blue.ChangeDutyCycle(duty)

    def set_01(self, pin, value):
        # common-anode
        value = 255 - value  # 0 -> fully on, 255 -> off
        duty = max(0, min(100, int(value / 255 * 100)))
        
        if pin == self.PIN_RED:
            self.pwm_red.ChangeDutyCycle(duty)
        elif pin == self.PIN_GREEN:
            self.pwm_green.ChangeDutyCycle(duty)
        elif pin == self.PIN_BLUE:
            self.pwm_blue.ChangeDutyCycle(duty)


    def clear(self):
        self.set(self.PIN_RED, 0)
        self.set(self.PIN_GREEN, 0)
        self.set(self.PIN_BLUE, 0)

    def setGreen(self, value): self.set(self.PIN_GREEN, value)
    def setBlue(self, value):  self.set(self.PIN_BLUE, value)
    def setRed(self, value):   self.set(self.PIN_RED, value)

    def cleanup_old(self):
        # ✅ PWM zuerst stoppen und Referenzen löschen
        for pwm in (self.pwm_red, self.pwm_green, self.pwm_blue):
            try:
                pwm.stop()
            except:
                pass

        self.pwm_red = None
        self.pwm_green = None
        self.pwm_blue = None

        # ✅ Erst danach GPIO cleanup
        GPIO.cleanup()

    def cleanup(self):
        try:
            self.pwm_red.stop()
            self.pwm_green.stop()
            self.pwm_blue.stop()
        except:
            pass

        # Remove objects completely
        self.pwm_red = self.pwm_green = self.pwm_blue = None

        import gc
        gc.collect()  # forces PWM objects to die NOW, not later

        GPIO.cleanup()

    def cleanup_latest(self):
        # Stop PWM
        for pwm in (self.pwm_red, self.pwm_green, self.pwm_blue):
            try:
                pwm.stop()
            except:
                pass

        # Remove PWM references
        self.pwm_red = self.pwm_green = self.pwm_blue = None

        # ⚡ Force all pins HIGH before cleanup
        GPIO.output(self.PIN_RED, GPIO.HIGH)
        GPIO.output(self.PIN_GREEN, GPIO.HIGH)
        GPIO.output(self.PIN_BLUE, GPIO.HIGH)

        GPIO.cleanup()


if __name__ == '__main__':
    led = LEDController()

    try:
        print('MAIN: alles löschen')
        led.clear()
        time.sleep(5)
        
        print('MAIN: alles setzen (weiß)')
        led.setRed(255)
        led.setGreen(255)
        led.setBlue(255)
        time.sleep(2)
        
        print('MAIN: alles löschen')
        led.clear()
        time.sleep(1)
        
        print('MAIN: Red setzen')
        led.setRed(255)
        time.sleep(2)
        led.clear()
        
        print('MAIN: Green setzen')
        led.setGreen(255)
        time.sleep(2)
        led.clear()
        
        print('MAIN: Blue setzen')
        led.setBlue(255)
        time.sleep(2)
        led.clear()
        
        print('MAIN: runter dimmen (weiß → aus)')
        for color in range(255, -1, -1):
            led.setRed(color)
            led.setGreen(color)
            led.setBlue(color)
            time.sleep(0.01)
        led.clear()

    except KeyboardInterrupt:
        print("\nAbbruch durch User")

    finally:
        print("Cleanup GPIO & PWM")
        led.clear()
        led.cleanup()

