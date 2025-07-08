#!/usr/bin/python3

from sense_hat import SenseHat
from time import sleep

sense = SenseHat()
sense.clear()

print("Hallo anzeigen")
sense.show_message("Hallo")


print("Hallo gelb auf cyan langsam anzeigen")
sense.show_message("Hallo",scroll_speed=0.3,text_colour=[125,125,0],back_colour=[0,125,125])

sense.clear()

print("Hallo flip_v anzeigen (Keine Wirkung!)")
sense.flip_v()
sense.show_message("Hallo flip_v")

print("Hallo flip_h anzeigen (Keine Wirkung!)")
sense.flip_h()
sense.show_message("Hallo flip_h")

print("Hallo set_rotation(180)")
sense.set_rotation(180)
sense.show_message("Hallo set_rotation(180)")


sense.show_letter("Q")
sleep(2)

for i in reversed(range(0,10)):
    sense.show_letter(str(i))
    sleep(1)

sense.clear()

