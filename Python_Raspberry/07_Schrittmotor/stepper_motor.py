#! /usr/bin/env python3

from time import sleep
import RPi.GPIO as GPIO

GPIO.setmode(GPIO.BCM)

# PIN-Zuweisung am Raspberry
A = 18
B = 23
C = 24
D = 25

time = 0.001

# PINS definieren
GPIO.setup(A, GPIO.OUT)
GPIO.setup(B, GPIO.OUT)
GPIO.setup(C, GPIO.OUT)
GPIO.setup(D, GPIO.OUT)
GPIO.output(A, False)
GPIO.output(B, False)
GPIO.output(C, False)
GPIO.output(D, False)

# Ansteuerung der Spulen des Motors
def Step1():
    GPIO.output(D, True)
    sleep(time)
    GPIO.output(D, False)

def Step2():
    GPIO.output(D, True)
    GPIO.output(C, True)
    sleep(time)
    GPIO.output(D, False)
    GPIO.output(C, False)

def Step3():
    GPIO.output(C, True)
    sleep(time)
    GPIO.output(C, False)

def Step4():
    GPIO.output(B, True)
    GPIO.output(C, True)
    sleep(time)
    GPIO.output(B, False)
    GPIO.output(C, False)

def Step5():
    GPIO.output(B, True)
    sleep(time)
    GPIO.output(B, False)

def Step6():
    GPIO.output(A, True)
    GPIO.output(B, True)
    sleep(time)
    GPIO.output(A, False)
    GPIO.output(B, False)

def Step7():
    GPIO.output(A, True)
    sleep(time)
    GPIO.output(A, False)

def Step8():
    GPIO.output(D, True)
    GPIO.output(A, True)
    sleep(time)
    GPIO.output(D, False)
    GPIO.output(A, False)

# Eine komplette Umdrehung Gegenuhrzeiger
def complete_rotation_backward():
    print("Eine komplette Umdrehung rückwärts")
    for i in range(512):
        Step1()
        Step2()
        Step3()
        Step4()
        Step5()
        Step6()
        Step7()
        Step8()

# Eine komplette Umdrehung Uhrzeiger
def complete_rotation_forward():
    print("Eine komplette Umdrehung vorwärts")
    for i in range(512):
        Step8()
        Step7()
        Step6()
        Step5()
        Step4()
        Step3()
        Step2()
        Step1()

# 1/2 Umdrehung Gegenuhrzeiger
def half_rotation_backward():
    print("1/2 Umdrehung rückwärts")
    for i in range(256):
        Step1()
        Step2()
        Step3()
        Step4()
        Step5()
        Step6()
        Step7()
        Step8()

# 1/2 Umdrehung Uhrzeiger
def half_rotation_forward():
    print("1/2 Umdrehung vorwärts")
    for i in range(256):
        Step8()
        Step7()
        Step6()
        Step5()
        Step4()
        Step3()
        Step2()
        Step1()

# 1/4 Umdrehung Gegenuhrzeiger
def quarter_rotation_backward():
    print("1/4 Umdrehung rückwärts")
    for i in range(128):
        Step1()
        Step2()
        Step3()
        Step4()
        Step5()
        Step6()
        Step7()
        Step8()

# 1/4 Umdrehung Uhrzeiger
def quarter_rotation_forward():
    print("1/4 Umdrehung vorwärts")
    for i in range(128):
        Step8()
        Step7()
        Step6()
        Step5()
        Step4()
        Step3()
        Step2()
        Step1()

# Einen Schritt Gegenuhrzeiger (Step1 bis Step8)
def step_backward():
    Step1()
    Step2()
    Step3()
    Step4()
    Step5()
    Step6()
    Step7()
    Step8()

# Einen Schritt Uhrzeiger (Step8 bis Step1)
def step_forward():
    Step8()
    Step7()
    Step6()
    Step5()
    Step4()
    Step3()
    Step2()
    Step1()

# Funktion für Sekundenzeiger-Bewegung
def move_second_hand():
    steps_per_revolution = 512
    steps_done = 0
    # Berechne, wie viele Steps (also komplette Sequenzen) pro Sekunde ausgeführt werden sollen
    for sec in range(60):
        steps_this_second = ((sec + 1) * steps_per_revolution) // 60 - (sec * steps_per_revolution) // 60
        for s in range(steps_this_second):
            step_forward()
            steps_done += 1
        sleep(1 - (steps_this_second * 8 * time))  # 8x time pro Step-Sequenz
    print(f"Schritte ausgeführt: {steps_done}")

def main():
    print("Sekundenzeiger: 1 Umdrehung in 60 Sekunden")
    move_second_hand()
    GPIO.cleanup()

if __name__ == "__main__":
    main()