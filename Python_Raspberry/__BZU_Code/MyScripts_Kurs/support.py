#!/usr/bin/python3

# ------------------------------------------------------------------
# Name: support.py
#
# Description: Library - Module
#
# Autor: Walter Rothlin
#
# History:  
# 06-Dec-2017   Walter Rothlin      Initial Version (Eigene Funktions von umrechnen.py ausgelagert)
#
# ------------------------------------------------------------------
import math

# Bildschirmsteuerung
# -------------------
def VT52_cls():
	print("\033[2J",end="", flush=True)

def VT52_home():
	print("\033[H",end="", flush=True)

def VT52_cls_home():
    VT52_cls()
    VT52_home()

def halt():
    ant=input("Weiter?")

# Pysikalische Umrechnungen
# -------------------------
def grad2Rad(grad):
    return math.pi*grad/180

def rad2Grad(rad):
    return 180*rad/math.pi

def fahrenheit2Celsius(fahrenheit):
    return (fahrenheit-32)/1.8
	
def celsius2Fahrenheit(celsius):
    return (celsius*1.8)+32
	
# Primzahlen Functions
# --------------------
def isPrimzahl(aZahl):
    isPrim = True
    if (aZahl == 1):
        isPrim = True
    else:
        if (aZahl == 2):
            isPrim = True
        else:
            obergrenze = aZahl - 1
            obergrenze = int((aZahl / 2) + 2)
            for i in range(2,obergrenze):
                if ((aZahl % i) == 0):
                    isPrim = False
    return isPrim

