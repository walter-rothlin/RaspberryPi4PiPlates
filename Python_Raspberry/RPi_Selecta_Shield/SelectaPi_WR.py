#!/usr/bin/python3
    
import SelectaShieldLibrary as Selecta

SelectaShield = Selecta.SelectaPi(HomeAllMotors=True, DrinkNames=("Cola", "Cola", "Sprite", "Fanta", "Valser", "Valser"))

def firstInstanceOf(List, ItemToSearch):
    for ItemIndex in range(len(List)):
        if List[ItemIndex] == ItemToSearch:
            return ItemIndex
    return -1 #'ItemToSearch' could not be found in 'List'

while True:
    #Endless Program Loop
    SelectButtonValues = SelectaShield.readButtons(SelectaShield.SELECT_BUTTON)
    SelectButtonONIndex = firstInstanceOf(SelectButtonValues, SelectaShield.ON)
    if(SelectButtonONIndex != -1):
        #if(SelectaShield.checkSlotLevel(SelectButtonONIndex) == SelectaShield.FULL):
        SelectaShield.setLEDs(SelectButtonValues)
        SelectaShield.executeMotorCycles(1, SelectButtonONIndex)
        SelectaShield.setLEDs((0, 0, 0, 0, 0, 0))
