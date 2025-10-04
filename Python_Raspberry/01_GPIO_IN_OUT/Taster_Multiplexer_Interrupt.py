'''
   +3.3V / Pull-Up
Taster1 ---+
Taster2 ---|--> 74HC165 Parallel Inputs (D0-D7)
Taster3 ---|
Taster4 ---+

Pi GPIO 5 ----> CLK  (Clock Input)
Pi GPIO 6 ----> QH   (Data Output)

Optional: CLR, PL Pins auf VCC oder Pi GPIO


CLK: Takt für Shift-Register

QH: Serieller Ausgang zum Pi

Taster auf GND, Register Inputs aktivieren Pull-Up

Mehr Taster: kaskadieren weitere 74HC165

Testen einzelner Tasten
if taster_register & 0b0001:
    print("Taster1 gedrückt")

'''



import RPi.GPIO as GPIO
import time

DATA_PIN = 6   # QH Pin
CLK_PIN = 5    # Clock Pin

NUM_TASTER = 4  # Anzahl Taster im Register

GPIO.setmode(GPIO.BCM)
GPIO.setup(DATA_PIN, GPIO.IN)
GPIO.setup(CLK_PIN, GPIO.OUT)

taster_register = 0

def read_shift_register():
    """Liest NUM_TASTER Bits vom 74HC165 aus"""
    result = 0
    for i in range(NUM_TASTER):
        GPIO.output(CLK_PIN, False)
        time.sleep(0.001)
        bit = GPIO.input(DATA_PIN)
        result |= (bit << i)
        GPIO.output(CLK_PIN, True)
        time.sleep(0.001)
    return result

def shift_register_callback(channel):
    global taster_register
    taster_register = read_shift_register()
    print(f"Taster Register: {taster_register:0{NUM_TASTER}b}")

# Optional: Interrupt auf CLK Pin (steigend/fallend)
GPIO.add_event_detect(CLK_PIN, GPIO.RISING, callback=shift_register_callback, bouncetime=50)

try:
    print("Programm läuft. Taster werden über 74HC165 ausgelesen...")
    while True:
        time.sleep(1)  # Hauptloop macht nichts, Interrupt aktualisiert Register

except KeyboardInterrupt:
    GPIO.cleanup()
