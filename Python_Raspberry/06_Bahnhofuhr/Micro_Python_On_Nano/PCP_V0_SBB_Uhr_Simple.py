# ------------------------------------------------------------------
# Name  : PCB_V0_SBB_Uhr_Simple.py
#
# Description: Starts two Timer-Threads (2s Watchdog, 60s Clock)
# Source: 
#
# Autor: Walter Rothlin
#
# History:
# 30-Aug-2025   Walter Rothlin      Simple Version initiated
# ------------------------------------------------------------------
pgm_name = 'SBB-Uhr-Simple'
version = '1.0'
from machine import Pin, UART, Timer, RTC
from time import sleep
    
    
def minuten_takt(event):
    relais[0].toggle()
    relais[1].toggle()
    print(get_string_from_date_time(rtc.datetime()))
    

def watch_dog_cb_fct(event):
    status_ok.off()
    sleep(1)
    status_ok.on()
  
# main
# ====
print(f'{pgm_name} ({version}) started...')
status_ok = Pin(6, Pin.OUT)
status_warning = Pin(7, Pin.OUT)
status_wifi = Pin(8, Pin.OUT)

status_ok.on()
status_warning.on()
status_wifi.on()
# Init HW
relais = [Pin(r, Pin.OUT) for r in [13,14,15,16]]
for r in relais:
    r.off()

sleep(1)
status_warning.off()
sleep(1)
status_wifi.off()



print('starting two Timers...')
watchdog_timer = Timer()
watchdog_timer.init(period=2000, mode=Timer.PERIODIC, callback=watch_dog_cb_fct)
print('  Watchdog 2s started')
minuten_clock = Timer()
minuten_clock.init(period=60000, mode=Timer.PERIODIC, callback=minuten_takt)
print('  Clock 60s started')



