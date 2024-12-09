#!/usr/bin/python3

# ------------------------------------------------------------------
# Name: Primzahlenrechner.py
#
# Description: Rechnet mit Primzahlen.
#
# Autor: Walter Rothlin
#
# History:
# 11-Jun-2019   Walter Rothlin      Initial Version
#
# ------------------------------------------------------------------

from  waltisLibrary import *

doLoop = True
while doLoop:
    VT52_cls_home()
    print("  Primzahlen-Rechner")
    print("  ==================")
    print("  1: Ist es eine Primzahl?")
    print("  2: Naechste groessere Primzahl")
    print("  3: Naechste kleinere Primzahl")
    print("  4: Liste aller Primzahlen")
    print("  5: Primzahlen-Zerlegung")
    print("  6: Teiler")
    print("  7: Liste der Primfaktorenzerlegung")
    print("  8: Liste der Teiler")
    print()
    print("  0: Schluss")


    antwort = input("\n  Wähle:")
    if (antwort == "1"):
        VT52_cls_home()
        print("Ist es eine Primzahl?")
        gValue = int(input("Ganze Zahl:"))
        if (isPrimzahl(gValue)):
            print(gValue,"ist eine Primzahl!!!")
        else:
            print(gValue,"ist KEINE Primzahl!!")
        halt()

    if (antwort == "2"):
        VT52_cls_home()
        print("Naechste groessere Primzahl")
        gValue=int(input("Eine Ganzezahl:"))
        if (isPrimzahl(gValue)):
            print("{g:3d} ist eine Primzahl!!!!".format(g=gValue))
        print("Von {g:3d}  die nächste grössere Primzahl ist: {np:3d}".format(g=gValue,np=getNextPrimzahl(gValue)))
        halt()

    if (antwort == "3"):
        VT52_cls_home()
        print("Naechste kleinere Primzahl")
        gValue=int(input("Eine Ganzezahl:"))
        if (isPrimzahl(gValue)):
            print("{g:3d} ist eine Primzahl!!!!".format(g=gValue))
        print("Von {g:3d}  die nächste tiefere Primzahl ist: {np:3d}".format(g=gValue,np=getPrevPrimzahl(gValue)))
        halt()

    if (antwort == "4"):
        VT52_cls_home()
        print("Liste aller Primzahlen")
        start = int(input("Start:"))
        end   = int(input("Ende :"))
        print(getPrimezahlenListe(start,end))
        halt()

    if (antwort == "5"):
        VT52_cls_home()
        print("Primzahlen-Zerlegung")
        gVal = int(input("Ganze Zahl:"))
        print(getPrimfactors(gVal))
        halt()

    if (antwort == "6"):
        VT52_cls_home()
        print("Teiler")
        gVal = int(input("Ganze Zahl:"))
        print(getDivisors(gVal))
        halt()

    if (antwort == "7"):
        VT52_cls_home()
        print("Liste der Primfaktorenzerlegung")
        start = int(input("Start:"))
        end   = int(input("Ende :"))
        retStr = ""
        for i in range(start,end+1):
            if (isPrimzahl(i)):
                print("{iP:5d}: Ist eine Primzahl".format(iP=i))
            else:
                retStr = getPrimfactors(i)
                print("{iP:5d}:".format(iP=i),retStr)
        halt()

    if (antwort == "8"):
        VT52_cls_home()
        print("Liste der Teiler")
        start = int(input("Start:"))
        end   = int(input("Ende :"))
        retStr = ""
        for i in range(start,end+1):
            if (isPrimzahl(i)):
                print("{iP:5d}: Ist eine Primzahl".format(iP=i))
            else:
                retStr = getDivisors(i)
                print("{iP:5d}:".format(iP=i),retStr)
        halt()

    if (antwort == "0"):
        doLoop = False

print("Ende....Done")
