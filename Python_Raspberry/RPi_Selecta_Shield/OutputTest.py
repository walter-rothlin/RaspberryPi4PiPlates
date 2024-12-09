import SelectaShieldLibrary as Selecta
import time

SelectaShield = Selecta.SelectaPi(HomeAllMotors=False)
time.sleep(1)

while True:
    SelectaShield.setMotors([1, 0, 0, 0, 0, 0])
    SelectaShield.setLEDs([1, 0, 0, 0, 0, 0])
    time.sleep(2)
    SelectaShield.setMotors([0, 1, 0, 0, 0, 0])
    SelectaShield.setLEDs([0, 1, 0, 0, 0, 0])
    time.sleep(2)
    SelectaShield.setMotors([0, 0, 1, 0, 0, 0])
    SelectaShield.setLEDs([0, 0, 1, 0, 0, 0])
    time.sleep(2)
    SelectaShield.setMotors([0, 0, 0, 1, 0, 0])
    SelectaShield.setLEDs([0, 0, 0, 1, 0, 0])
    time.sleep(2)
    SelectaShield.setMotors([0, 0, 0, 0, 1, 0])
    SelectaShield.setLEDs([0, 0, 0, 0, 1, 0])
    time.sleep(2)
    SelectaShield.setMotors([0, 0, 0, 0, 0, 1])
    SelectaShield.setLEDs([0, 0, 0, 0, 0, 1])
    time.sleep(2)