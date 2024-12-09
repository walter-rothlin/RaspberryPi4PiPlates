import SelectaShieldLibrary as Selecta
import random
import time

random.seed()

SelectaMachine = Selecta.SelectaPi(HomeAllMotors=False)

for i in range(6):
    SelectaMachine.setMotor(True, i)
    time.sleep(float(random.randint(5, 30)) / 10)
    SelectaMachine.setMotor(False, i)
