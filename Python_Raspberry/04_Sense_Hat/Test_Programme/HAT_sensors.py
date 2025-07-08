#!/usr/bin/python3

from sense_hat import SenseHat
import time

"""

  Sense HAT Sensors Display
  
  Select Temperature, Pressure, or Humidity  with the Joystick
  to visualize the current sensor values on the LED.
  
  Note: Requires sense_hat 2.2.0 or later

"""

sense = SenseHat()

green = (0, 255, 0)
red = (255, 0, 0)
blue = (0, 0, 255)
white = (125,125,125)


def show_t():
  sense.show_letter("T", back_colour = red)
  time.sleep(.5)

def show_p():
  sense.show_letter("P", back_colour = green)
  time.sleep(.5)

def show_h():
  sense.show_letter("H", back_colour = blue)
  time.sleep(.5)

def update_screen(mode, show_letter = False):
  if mode == "temp":
    if show_letter:
      show_t()
    temp = sense.temp
    temp_value = temp / 2.5 + 16
    pixels = [red if i < temp_value else white for i in range(64)]

  elif mode == "pressure":
    if show_letter:
      show_p()
    pressure = sense.pressure
    pressure_value = pressure / 20
    pixels = [green if i < pressure_value else white for i in range(64)]

  elif mode == "humidity":
    if show_letter:
      show_h()
    humidity = sense.humidity
    humidity_value = 64 * humidity / 100
    pixels = [blue if i < humidity_value else white for i in range(64)]

  sense.set_pixels(pixels)

####
# Intro Animation
####

show_t()
show_p()
show_h()

update_screen("temp")

index = 0
sensors = ["temp", "pressure", "humidity"]

####
# Main game loop
####

while True:
  selection = False
  events = sense.stick.get_events()
  for event in events:
    # Skip releases
    if event.action != "released":
      if event.direction == "left":
        index -= 1
        selection = True
      elif event.direction == "right":
        index += 1
        selection = True
      if selection:
        current_mode = sensors[index % 3]
        update_screen(current_mode, show_letter = True)
  
  if not selection:      
    current_mode = sensors[index % 3]
    update_screen(current_mode)
  