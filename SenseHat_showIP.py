#!/usr/bin/python

#***************************
# Autor Mischa Sach
#   
# Letzte Aenderung 17/06/2025
#
# zuerst crontab -e  in bash eingeben und Zeile
# @reboot /home/mischa/Documents/2025_FF_Rsp/sense_hat_examples.py
# einfuegen oder wo du dein Programm hast gespeichert damit es beim
# booten startet.
#
#***************************


import time
from sense_hat import SenseHat
import socket
from datetime import datetime

sense = SenseHat()  # Sense HAT initialisieren

def get_ip():
    # Funktion zum Ermitteln der lokalen IP-Adresse
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        s.connect(("8.8.8.8", 80))  # Verbindung zu externer Adresse aufbauen (Google DNS)
        ip = s.getsockname()[0]     # Eigene IP-Adresse auslesen
    except Exception:
        ip = "Keine Verbindung"     # Fehlerfall: Keine Verbindung möglich
    finally:
        s.close()                   # Socket schließen
    return ip


loop = True
while loop:
    sense.show_letter("?")  # Zeigt ein Fragezeichen als Hinweis auf eine Eingabe an
    for event in sense.stick.get_events():  # Alle aktuellen Joystick-Events abfragen
        if event.action == "pressed":       # Nur auf "gedrückt"-Events reagieren
            if event.direction == "middle":
                # Mittlerer Knopf: IP-Adresse anzeigen
                ip = get_ip()
                sense.show_message("IP: " + ip, scroll_speed=0.08)
            elif event.direction == "left":
                # Links: Aktuelles Datum anzeigen (grün)
                datum = datetime.now().strftime("%d.%m.%Y")
                sense.show_message(datum, scroll_speed=0.08, text_colour=[0,255,0])
            elif event.direction == "right":
                # Rechts: Aktuelle Uhrzeit anzeigen (blau)
                zeit = datetime.now().strftime("%H:%M")
                sense.show_message(zeit, scroll_speed=0.08, text_colour=[0,0,255])
            elif event.direction == "up":
                # Oben: Temperatur anzeigen (rot)
                temp = round(sense.get_temperature(), 1)
                sense.show_message(f"Temp: {temp}C", scroll_speed=0.08, text_colour=[255, 0, 0])
            elif event.direction == "down":
                # Unten: Programm beenden
                sense.show_message("Bye!", scroll_speed=0.08)
                loop = False  # Schleife und damit das Programm beenden