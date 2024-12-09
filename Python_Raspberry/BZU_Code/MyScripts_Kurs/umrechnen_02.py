#!/usr/bin/python3

# ------------------------------------------------------------------
# Name: umrechnungen.py
#
# Description: Rechnet verschiedene physikalische Grössen um.
#
# Autor: Walter Rothlin
#
# History:
# 28-Nov-2017   Walter Rothlin      Initial Version (Menu-Text)
# 29-Nov-2017   Walter Rothlin      Loop, input and case
#
# ------------------------------------------------------------------
doLoop = True
while doLoop:
    print("\033[2J",end="", flush=True)   # clear Screen
    print("\033[H",end="", flush=True)    # set cursor to home position
    print("  Umrechnungen")
    print("  ============")
    print("  1: Grad in Bogenmass")  # rad  = grad*pi/180
    print("  2: Bogenmass in Grad")  # grad = rad*180/pi
    print()
    print("  3: Fahrenheit in Celsius")  #32F -> 0°C    100F -> 38.8°C     °C = (°F - 32) / 1.8
    print("  4: Celsius in Fahrenheit")  #32F -> 0°C    100F -> 38.8°C     °F = (°C * 1.8) + 32
    print()
    print("  0: Schluss")


    antwort = input("\n  Wähle:")
    if (antwort == "1"):
        print("")
	
    if (antwort == "0"):
        doLoop = False

print("Ende....Done")
