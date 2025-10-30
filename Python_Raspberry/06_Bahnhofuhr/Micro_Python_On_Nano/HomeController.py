# ------------------------------------------------------------------
# Name  : HomeControler.py
#
# Description: Class und Lib-Fct for Home Controller V1.0
# Source: https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_Micro_For_RPi_Pico/HomeControler.py
#
# Autor: Tobias Rothlin
#
# History:
# 28-Dec-2024   Tobias Rothlin      Initial Version
# 29-Dec-2024   Walter Rothlin      modified set_relais(), get_relais(), write_lcd()
# ------------------------------------------------------------------
from machine import Pin
import machine
from gpio_lcd import GpioLcd

def capitalize(text):
    return text[0].upper() + text[1:].lower() if text else text
    
class HomeController:
    def __init__(self):
        self.log_idx = 0

        # Init Relais Pins
        self.relais = [Pin(10, Pin.OUT), Pin(11, Pin.OUT), Pin(12, Pin.OUT), Pin(13, Pin.OUT)]

        # Init Status LED Pins
        self.statusLED ={"Green": Pin(28,Pin.OUT), "Yellow": Pin(27,Pin.OUT)}

        # Init Board Switch
        self.boardSwitch = Pin(3, Pin.IN)

        self.boardSwitch.irq(trigger=Pin.IRQ_FALLING, handler=self.board_switch_handler)

        # Init LCD Display
        self.lcd = GpioLcd(rs_pin=Pin(15,Pin.OUT),
                          enable_pin=Pin(14,Pin.OUT),
                          d4_pin=Pin(20,Pin.OUT),
                          d5_pin=Pin(21,Pin.OUT),
                          d6_pin=Pin(22,Pin.OUT),
                          d7_pin=Pin(26,Pin.OUT),
                          num_lines=2, num_columns=16)
        self.lcd.clear()

        # Tun off all Outputs
        for relai in self.relais:
            relai.value(0)


        for led in self.statusLED:
            self.statusLED[led].value(0)    

        self.lcd.putstr("Startup Done.")

    #-------------------
    # Relais
    #-------------------
    def toggle_relais_old(self, relai):
        # print(f'toggle_relais({relai})')
        relai = round(float(relai))
        if relai >= 0 and relai < 4:
            if self.get_relais(relai) == 1:
                self.set_relais(relai, 0)
            else:
                self.set_relais(relai, 1)
            return True
        else:
            return False
            
    def toggle_relais(self, relai):
        # print(f'toggle_relais({relai})')
        relai = round(float(relai))
        if relai >= 0 and relai < 4:
            self.relais[relai].toggle()

    def set_relais(self, relai, value):
        # print(f'set_relais({relai}, {value})')
        relai = round(float(relai))
        value = round(float(value))
        if relai >= 0 and relai < 4 and value >= 0 and value <= 1:
            self.relais[relai].value(value)
            return True
        else:
            return False

    def get_relais(self, relai):
        # print(f'get_relais({relai})')
        relai = round(float(relai))
        if relai >= 0 and relai < 4:
            return self.relais[relai].value()
        else:
            return None

    #-------------------
    # LED
    #-------------------
    def toggle_status_led_old(self, led):
        # print(f'toggle_status_led({led})')
        led = capitalize(led)
        if led in self.statusLED:
            if self.get_status_led(led) == 1:
                self.set_status_led(led, 0)
            else:
                self.set_status_led(led, 1)
            return True
        else:
            return False
            
    def toggle_status_led(self, led):
        # print(f'toggle_status_led({led})')
        led = capitalize(led)
        if led in self.statusLED:
            self.statusLED[led].toggle()
            
    def set_status_led(self, led, value):
        value = round(float(value))
        led = capitalize(led)
        if led in self.statusLED and value >= 0 and value <= 1:
            self.statusLED[led].value(value)
            return True
        else:
            return False

    def get_status_led(self, led):
        led = capitalize(led)
        if led in self.statusLED:
            return self.statusLED[led].value()
        else:
            return None
        
    #-------------------
    # LED
    #-------------------
    def write_lcd(self, text, do_clear=True):
        if do_clear:
            self.lcd.clear()
        self.lcd.putstr(text)

    def clear_lcd(self):
        self.lcd.clear()

    #-------------------
    # Board-Switch
    #-------------------
    def get_board_switch(self):
        return self.boardSwitch.value()
        
    def board_switch_handler(self, pin):
        self.clear_lcd()
        print("Board Switch Pressed")
