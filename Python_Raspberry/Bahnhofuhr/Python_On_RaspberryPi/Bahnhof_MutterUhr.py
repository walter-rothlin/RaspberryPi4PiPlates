
#!/usr/bin/python
#
# ------------------------------------------------------------------
# Name  : Bahnhof_MutterUhr.py
#
# Description: Mutteruhr ohne Drift und mit REST-Services zum richten und start/stop
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/Bahnhofuhr/Python_On_RaspberryPi/Bahnhof_MutterUhr.py
#
# Autor: Walter Rothlin
#
# History:
# 03-Aug-2025   Walter Rothlin      Initial Version based on https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_WaltisExamples/Code_02_BasicPython/pythonBasics_08j_repeating_timer_REST_Controlled.py
# 25-Aug-2025   Walter Rothlin      GPIO Test
# ------------------------------------------------------------------
import RPi.GPIO as GPIO
import time

# Pin-Definition (BCM-Nummerierung)
GPIO_PIN = 26  

# Anfangszustand
current_state = False


def switchGPIO():
    global current_state
    current_state = not current_state
    if current_state:
        GPIO.output(GPIO_PIN, GPIO.LOW)
    else:
        GPIO.output(GPIO_PIN, GPIO.HIGH)
    

def tickArgs(count=10, delay=5):
    print('tick ', end='', flush=True)
    for x in range(count):
        print('.', end='', flush=True)
        switchGPIO()
        time.sleep(delay)
    print()
    return "done"
    
if __name__ == '__main__':
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(GPIO_PIN, GPIO.OUT)
    print(f'Set GPIO_PIN:{GPIO_PIN} to HIGH (Off)')
    GPIO.output(GPIO_PIN, GPIO.HIGH)
    do_loop = True
    while do_loop:
        antwort = input('Weiter (s=stopp):')
        if antwort == 's':
            do_loop=False
        else:
            switchGPIO()
    
    time.sleep(5)
    
    tickArgs(count=5, delay=1)
    
    print(f'Set GPIO_PIN:{GPIO_PIN} to LOW (on)')
    GPIO.output(GPIO_PIN, GPIO.LOW)
    