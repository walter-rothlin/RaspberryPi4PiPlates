#!/usr/bin/python
import piplates.RELAYplate as Relay
import time

PLATE_ADDRESS = 0

print(f"Testing Plate on address {PLATE_ADDRESS}")
# Relay control
for i in range(1,8):
    Relay.relayON(PLATE_ADDRESS,i)
    print(f"Relay ON: {PLATE_ADDRESS}, {i}")
    time.sleep(1)

for i in range(1,8):
    Relay.relayOFF(PLATE_ADDRESS,i)
    print(f"Relay OFF: {PLATE_ADDRESS}, {i}")
    time.sleep(1)


print("Done")