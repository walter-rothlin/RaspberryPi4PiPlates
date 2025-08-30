# ------------------------------------------------------------------
# Name  : PCB_V0_SBB_Uhr.py
#
# Description: Starts two Timer-Threads (2s Watchdog, 60s Clock)
# Source: 
#
# Autor: Walter Rothlin
#
# History:
# 30-Aug-2025   Walter Rothlin      Simple Version initiated
# ------------------------------------------------------------------
from machine import Pin, UART, Timer, RTC
from time import sleep
import socket
import network
import urequests, json, utime
import ntptime, utime

pgm_name = 'SBB-Uhr'
version = '1.0'

wifi_list = [
  {'SSID': 'WalterRothlin_2', 'PW': 'waltiClaudia007'},
  {'SSID': 'WIFI-PSC'       , 'PW': 'Wlan-PSC!'}
]

def get_string_from_date_time(datetime):
    # return '---' + str(datetime)
    return f'{datetime[0]:04d}-{datetime[1]:02d}-{datetime[2]:02d} {datetime[4]:02d}:{datetime[5]:02d}:{datetime[6]:02d}'
    
    
def minuten_takt(event):
    relais[0].toggle()
    relais[1].toggle()
    print(get_string_from_date_time(rtc.datetime()))
    

def watch_dog_cb_fct(event):
    status_ok.off()
    sleep(1)
    status_ok.on()

def is_dst_simple(year, month, day, weekday):
    """
    Returns True if DST is active (CEST) for Zurich.
    DST: last Sunday in March -> last Sunday in October
    """
    # March: DST starts last Sunday
    if month == 3:
        last_sunday = 31 - ((day + weekday) % 7)
        return day >= last_sunday
    # October: DST ends last Sunday
    if month == 10:
        last_sunday = 31 - ((day + weekday) % 7)
        return day < last_sunday
    # April -> September: DST active
    return 4 <= month <= 9


def set_rtc_time_berlin_simple(rtc):
    try:
        import ntptime
        ntptime.settime()
        clock_is_set = True
    except Exception as e:
        print("WARNING: Could not fetch time from NTP:", e)
        clock_is_set = False

    t = utime.localtime()
    yyyy, mm, dd, hh, minute, second, weekday, _ = t

    tz_offset = 1  # CET
    if is_dst_simple(yyyy, mm, dd, weekday):
        tz_offset += 1  # CEST

    hh = (hh + tz_offset) % 24
    now_time = (yyyy, mm, dd, weekday, hh, minute, second, 0)
    rtc.datetime(now_time)

    return clock_is_set



    
def connect_wifi(wifi_list, status_wifi, status_warning, max_tries=100):
    """
    Tries to connect to a Wi-Fi network from wifi_list.
    Returns (connected: bool, ssid: str|None, ip_address: str|None).
    """
    wlan = network.WLAN(network.STA_IF)
    wlan.active(True)

    for wifi in wifi_list:
        ssid = wifi['SSID']
        pw   = wifi['PW']
        print(f"Trying to connect to WiFi: {ssid}")

        wlan.connect(ssid, pw)
        tries = 0

        while not wlan.isconnected() and tries < max_tries:
            tries += 1
            status_wifi.toggle()
            print(f'WARNING ({tries:3d}): Not connected to WIFI {ssid}') 
            sleep(0.5)

        if wlan.isconnected():
            status_wifi.on()
            status_warning.off()
            ip_adr = wlan.ifconfig()[0]
            print(f"✅ Connected to {ssid}, IP: {ip_adr}")
            return True, ssid, ip_adr

    # if all failed
    status_wifi.off()
    status_warning.on()
    print("❌ ERROR: Could not connect to any WiFi network!")
    return False, None, None

    
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



# Echtzeituhr im Mikrocontroller initialisieren
rtc = RTC()


# Connect to WIFI
connected, wifi_ssid, ip_adr = connect_wifi(wifi_list, status_wifi, status_warning)
if connected:
    clock_is_set = set_rtc_time_berlin_simple(rtc)
    addr = socket.getaddrinfo(ip_adr, 80)[0][-1]
    server = socket.socket()
    server.bind(addr)
    server.listen(1)
    status_ok.on()

    clock_is_set_text = 'Clock NOT synchronized'
    if clock_is_set:
        clock_is_set_text = 'Clock is synchronized'
        
    print(pgm_name, 'Version:', version)
    print('Actual IP:', ip_adr, end='\n')
    print('Date/Time now: ', get_string_from_date_time(rtc.datetime()), clock_is_set_text, end='\n\n')


print('starting two Timers...')
watchdog_timer = Timer()
watchdog_timer.init(period=2000, mode=Timer.PERIODIC, callback=watch_dog_cb_fct)
print('  Watchdog 2s started')
minuten_clock = Timer()
minuten_clock.init(period=60000, mode=Timer.PERIODIC, callback=minuten_takt)
print('  Clock 60s started')




