import SelectaShieldLibrary as Selecta
import time

SelectaShield = Selecta.SelectaPi(HomeAllMotors=False)

while True:
    print(SelectaShield.readButtons(SelectaShield.SELECT_BUTTON))
    time.sleep(0.5)
