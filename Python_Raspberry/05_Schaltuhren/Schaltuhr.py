#!/usr/bin/python3

# ------------------------------------------------------------------
# Name  : Schaltuhr.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/01_GPIO_IN_OUT/Schaltuhr.py
#
# Description: Frei programmierbare Schaltuhr
#
#
# Autor: Walter Rothlin
#
# History:
# 28-Sep-2025   Walter Rothlin    Initial Version
#
# ------------------------------------------------------------------
import RPi.GPIO as GPIO
import time
import threading
from datetime import datetime
from flask import Flask, request, jsonify, render_template, redirect, url_for
import socket


class Schaltuhr:
    def __init__(self, init_state, verbal=False):
        self.__state = init_state
        GPIO.setmode(GPIO.BCM)
        for aPin in self.__state:
            if verbal:
                print(f"\ninit_ports:{aPin}")
            if aPin['Init_State'] == 'Off':
                GPIO.setup(aPin['GPIO'], GPIO.OUT)
                GPIO.output(aPin['GPIO'], GPIO.HIGH)
                aPin['State'] = 'Off'
                if verbal:
                    print(f"Init GPIO_PIN:{aPin['GPIO']} to HIGH (Off)")
            elif aPin['Init_State'] == 'On':
                GPIO.setup(aPin['GPIO'], GPIO.OUT)
                GPIO.output(aPin['GPIO'], GPIO.LOW)
                aPin['State'] = 'On'
                if verbal:
                    print(f"Init GPIO_PIN:{aPin['GPIO']} to LOW (On)")
            if verbal:
                print()
        print()

    def __str__(self):
        retStr = "Schaltuhr (V0.1)"
        for aPin in self.__state:
            retStr += f"""
                Nr:{aPin['Nr']}   GPIO:{aPin['GPIO']}     State:{aPin['State']}
            """
        return retStr

    def set_all_relais(self, state='Off', verbal=False):
        if verbal:
            print(f"set_all_relais(self, state='{state}', verbal={verbal}):")
        for aPin in self.__state:
            self.set_relais(switch_Nr=aPin['Nr'], state=state)

    def set_relais(self, switch_Nr=None, GPIO_Nr=None, state='Off', verbal=False):
        for aSwitch in self.__state:
            print("--> ", aSwitch)
            if switch_Nr is not None and str(aSwitch['Nr']) == str(switch_Nr) and aSwitch['Init_State'] != 'NotUsed':
                if state == 'On':
                    GPIO.output(aSwitch['GPIO'], GPIO.LOW)
                    aSwitch['State'] = 'On'
                    if verbal:
                        print(f"Set aGPIO_PIN:{aSwitch['GPIO']} to LOW (On)")
                elif state == 'Off':
                    GPIO.output(aSwitch['GPIO'], GPIO.HIGH)
                    aSwitch['State'] = 'Off'
                    if verbal:
                        print(f"Set aGPIO_PIN:{aSwitch['GPIO']} to HIGH (Off)")
                elif state.capitalize() == 'Toggle':
                    if aSwitch['State'] == 'On':
                        self.set_relais(switch_Nr=switch_Nr, GPIO_Nr=GPIO_Nr, state='Off', verbal=True)
                    else:
                        self.set_relais(switch_Nr=switch_Nr, GPIO_Nr=GPIO_Nr, state='On', verbal=True)

            elif GPIO_Nr is not None and str(aSwitch['GPIO']) == str(GPIO_Nr) and aSwitch['Init_State'] != 'NotUsed':
                if state == 'On':
                    GPIO.output(GPIO_Nr, GPIO.LOW)
                    aSwitch['State'] = 'On'
                    if verbal:
                        print(f"Set aGPIO_PIN:{aSwitch['GPIO']} to LOW (On)")
                elif state == 'Off':
                    GPIO.output(GPIO_Nr, GPIO.HIGH)
                    aSwitch['State'] = 'Off'
                    if verbal:
                        print(f"Set aGPIO_PIN:{aSwitch['GPIO']} to HIGH (Off)")
                elif state.upper() == 'TOGGLE':
                    if aSwitch['State'] == 'On':
                        self.set_relais(switch_Nr=switch_Nr, GPIO_Nr=GPIO_Nr, state='Off', verbal=True)
                    else:
                        self.set_relais(switch_Nr=switch_Nr, GPIO_Nr=GPIO_Nr, state='On', verbal=True)


if __name__ == '__main__':
    def halt(prompt='Weiter?'):
        input(prompt)


    Schaltuhr_Pins = [
        {'Nr': 0, 'GPIO': 21, 'Init_State': 'Off', 'State': None},
        {'Nr': 1, 'GPIO': 20, 'Init_State': 'Off', 'State': None},
        {'Nr': 2, 'GPIO': 19, 'Init_State': 'NotUsed', 'State': None},
        {'Nr': 3, 'GPIO': 26, 'Init_State': 'NotUsed', 'State': None},
    ]

    Schaltpunkte = [
        {'Time': '12:00:01', 'Date': None, 'Nr': 0, 'GPIO': None, 'State': 'On'},
    ]

    schaltuhr = Schaltuhr(Schaltuhr_Pins, verbal=False)
    print('\n\n', schaltuhr, '\n\n')
    halt()

    schaltuhr.set_relais(switch_Nr=1, state='On')
    print('\n\n', schaltuhr, '\n\n')
    halt()

    schaltuhr.set_relais(switch_Nr=0, state='On')
    schaltuhr.set_relais(switch_Nr=1, state='Off')
    schaltuhr.set_relais(switch_Nr=2, state='On')
    print('\n\n', schaltuhr, '\n\n')
    halt()

    schaltuhr.set_relais(GPIO_Nr=21, state='Off')
    schaltuhr.set_relais(switch_Nr=1, state='Toggle')
    print('\n\n', schaltuhr, '\n\n')
    halt()

    schaltuhr.set_relais(GPIO_Nr=21, state='Toggle')
    print('\n\n', schaltuhr, '\n\n')
    halt()

    schaltuhr.set_relais(switch_Nr=0)
    schaltuhr.set_relais(GPIO_Nr=21)
    print('\n\n', schaltuhr, '\n\n')
    halt(1)

    print('\n\nCalling set_all_relais')
    schaltuhr.set_all_relais('Off')
    print('\n\n', schaltuhr, '\n\n')


