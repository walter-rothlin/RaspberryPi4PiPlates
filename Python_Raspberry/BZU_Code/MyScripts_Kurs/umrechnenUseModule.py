#!/usr/bin/python3

# ------------------------------------------------------------------
# Name: umrechnungenUseModule.py
#
# Description: Rechnet verschiedene physikalische Grössen um.
#
# Autor: Walter Rothlin
#
# History:
# 28-Nov-2017   Walter Rothlin      Initial Version (Menu-Text)
# 29-Nov-2017   Walter Rothlin      Loop, input and case
# 30-Nov-2017   Walter Rothlin      Alle Umrechnungen implementiert
# 01-Dec-2017	Walter Rothlin      Bildschirmsteuerung mit eigenen Functions
# 05-Dec-2017	Walter Rothlin      Umrechnungs-Functions und import math
# 06-Dec-2017	Walter Rothlin      Eigene Funktions in eigenes Module ausgelagert
#
# ------------------------------------------------------------------

from  support import *

doLoop = True
while doLoop:
    VT52_cls_home()
    print("  Umrechnungen")
    print("  ============")
    print("  1: Grad in Bogenmass")  # rad  = grad*pi/180
    print("  2: Bogenmass in Grad")  # grad = rad*180/pi
    print()
    print("  3: Fahrenheit in Celsius")  #32F -> 0°C    100F -> 38.8°C     °C = (°F - 32) / 1.8
    print("  4: Celsius in Fahrenheit")  #32F -> 0°C    100F -> 38.8°C     °F = (°C * 1.8) - 32
    print()
    print("  0: Schluss")


    antwort = input("\n  Wähle:")
    if (antwort == "1"):
        VT52_cls_home()
        print("Grad --> Bogenmass")
        gradValue=float(input("Grad:"))
        print("Grad={grad:1.2f}  ==> Rad={rad:1.2f}".format(grad=gradValue,rad=grad2Rad(gradValue)))
        halt()

    if (antwort == "2"):
        VT52_cls_home()
        print("Bogenmass --> Grad")
        radValue=float(input("Rad:"))
        print("Rad={rad:1.2f}  ==> Grad={grad:1.2f}".format(rad=radValue,grad=rad2Grad(radValue)))
        halt()

    if (antwort == "3"):
        VT52_cls_home()   # http://www.metric-conversions.org/de/temperatur/fahrenheit-in-celsius.htm
        print("Fahrenheit in Celsius")
        fahrenheitValue=float(input("Fahrenheit:"))
        print("Fahrenheit={fahrenheit:1.2f}  ==> Celsius={celsius:1.2f}".format(fahrenheit=fahrenheitValue,celsius=fahrenheit2Celsius(fahrenheitValue)))
        halt()

    if (antwort == "4"):
        VT52_cls_home()   # http://www.metric-conversions.org/de/temperatur/celsius-in-fahrenheit.htm
        print("Celsius in Fahrenheit")
        celsiusValue=float(input("Celsius:"))
        print("Celsius={celsius:1.2f}  ==> Fahrenheit={fahrenheit:1.2f}".format(celsius=celsiusValue,fahrenheit=celsius2Fahrenheit(celsiusValue)))
        halt()			

    if (antwort == "0"):
        doLoop = False

print("Ende....Done")
