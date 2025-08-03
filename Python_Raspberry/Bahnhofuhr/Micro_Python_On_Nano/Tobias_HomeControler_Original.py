from HomeController import HomeController
import time



def main_thread():
    homeController = HomeController()
    time.sleep(1)
    
    homeController.write_lcd("Hello")
    
    time.sleep(1)
    homeController.set_status_led("Green",1)
    time.sleep(1)
    homeController.set_status_led("Yellow",1)
    
    
    idx = 0
    while True:
        homeController.write_lcd(str(idx))
        for i in range(4):
            time.sleep(1)
            homeController.set_relais(i,1)
            
        for i in range(4):
            time.sleep(1)
            homeController.set_relais(i,0)
            
        idx += 1
        
        

main_thread()
