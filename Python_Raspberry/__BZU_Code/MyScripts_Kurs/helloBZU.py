#!/usr/bin/python3


# ------------------------------------------------------------------
# Name: helloBZU.py
#
# Description: Zeigt die verschiedenen Varianten vom print Befehl
#
# Autor: Walter Rothlin
#
# History:
# 26-Sep-2017   Walter Rothlin      Initial Version
# 24-Oct-2017	Walter Rothlin		Eigene Functions mit Parametern
# 28-Nov_2017   Walter Rothlin      Modified for lessons
# ------------------------------------------------------------------

print("Hello BZU") # Titel
print("=========")
print("\n")

l,b = 10, 34

print("Flaeche:",l,"*",b,"=",l*b)
print("Flaeche: ",l,"*",b," = ",l*b,sep="")
print("Flaeche:",str(l)+"*"+str(b),"=",l*b)


laenge_1=5.68
laenge_2="5.67"
laenge_3=3
laenge_4=3.0
print(laenge_1,laenge_2,laenge_3,laenge_4)


vorname  =  "Willi Max"
nachname =  "Meister"

print(vorname)
print(nachname)

print(vorname + " " + nachname)
print(vorname,nachname,laenge_2,sep=vorname)
print("Laenge:",laenge_1)
print("Laenge:",laenge_1,sep="")
print("Laenge:" + str(laenge_1))


print(laenge_1 + 100)
# print(laenge_2 + 100)
print(laenge_3 + laenge_4)

print("Kreisflaeche:",end="\n\n", flush=True)
print(45.08)

radius = 4.5678
flaeche=radius*radius*3.1415926

print("Radius:",radius,"    ","Fläche:",flaeche)
print("Radius:%-10.2f   Fläche:%10.2f" % (radius,flaeche))
print("Radius:%8.4f" % radius)
print("       12345678901234567890")


strOut = "Radius: {radius:10.2f}  Flaeche:{flaeche:8.2f}".format(flaeche=flaeche,radius=radius)
print(strOut)


for radius in range(-10,-100,-30):
    print("Radius={radius:10.2f}   Fläche={flaeche:10.2f}".format(radius=radius,flaeche=radius*radius*3.1415926))
print("Schluss")

for buchstabe in "BINGO":
    print(buchstabe)

for eineNummer in [1,5,5.5,6.768,"BZU"]:
    print(eineNummer)


name=input("Wie ist Dein Name? ")
print("Hallo " + name)


print("Widerstandsberechnung")
print("=====================")

spannung=float(input("Spannung: "))
strom=float(input("Stromstärke: "))

widerstand=spannung/strom
print("Widerstand R=",widerstand)



