#!/usr/bin/python3

# ------------------------------------------------------------------
# Name  : LED_Taster.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/01_GPIO_IN_OUT/LED_Taster.py
#
# Description: LED_Taster
#
# GPIO PIN Belegung:     http://www.peterliwiese.ch/img/GPIO_RPi.png
# GPIO Simple Schaltung: http://www.peterliwiese.ch/img/RPi_GPIO_LED_Switch_schema.png
#
# Autor: Walter Rothlin
#
# History:
# 28-Sep-2025   Walter Rothlin    Initial Version

# ------------------------------------------------------------------
import time
import RPi.GPIO as GPIO

# GPIO Setup
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

RED_LED_PIN = 6
GREEN_LED_PIN = 13
TASTER_PIN = 5

# Taster als Eingang mit internem Pull-Up
GPIO.setup(TASTER_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)

# LEDs als Ausgang
GPIO.setup(RED_LED_PIN, GPIO.OUT)
GPIO.setup(GREEN_LED_PIN, GPIO.OUT)

# PWM-Setup (0-100% Duty Cycle)
red_pwm = GPIO.PWM(RED_LED_PIN, 1000)  # 1 kHz
green_pwm = GPIO.PWM(GREEN_LED_PIN, 1000)

red_pwm.start(0)  # LEDs aus
green_pwm.start(0)


def fade_led(pwm_led, fade_in=True, duration=1.0, steps=50):
    """Sanft die LED hoch- oder runterdimmen"""
    for i in range(steps + 1):
        if fade_in:
            duty = (i / steps) * 100
        else:
            duty = (1 - i / steps) * 100
        pwm_led.ChangeDutyCycle(duty)
        time.sleep(duration / steps)


try:
    while True:
        if GPIO.input(TASTER_PIN) == 0:
            # Grün LED sanft hoch, Rot LED aus
            fade_led(green_pwm, fade_in=True)
            red_pwm.ChangeDutyCycle(0)

            # Grün LED sanft runter, Rot LED sanft hoch
            fade_led(green_pwm, fade_in=False)
            fade_led(red_pwm, fade_in=True)

            # Rot LED sanft runter
            fade_led(red_pwm, fade_in=False)

            # Warten, bis Taster losgelassen wird
            while GPIO.input(TASTER_PIN) == 0:
                time.sleep(0.05)

        time.sleep(0.05)

except KeyboardInterrupt:
    red_pwm.stop()
    green_pwm.stop()
    GPIO.cleanup()


