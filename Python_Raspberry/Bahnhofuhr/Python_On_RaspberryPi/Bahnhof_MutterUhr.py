# ------------------------------------------------------------------
# Name  : Bahnhof_MutterUhr_HomeControler.py
#
# Description: REST-Enpoints for Relais Steuerung
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/Bahnhofuhr/Micro_Python_On_Nano/Bahnhof_MutterUhr_HomeControler.py
#
# Autor: Walter Rothlin
#
# History:
# 29-Dec-2024   Walter Rothlin      Initial Version with new board from Tobias
# 03-Aug-2025   Walter Rothlin      Move to another repository
# ------------------------------------------------------------------
from HomeController import HomeController
from machine import Pin, UART, Timer, RTC
from time import sleep
import time
import socket
import network
import json
import urequests


DEFAULT_TIME_URL = 'http://worldtimeapi.org/api/timezone/Europe/Zurich'
pgm_name = 'SBB-Uhr'
version = 'V5.0.0.6'
wait_for_minuten_schlag = True
minuten_takt_suspended = False

rtc = None
ssid = None
ip_adress = None

wifi_connections = [
    {'SSID': 'WalterRothlin_2', 'Password': 'waltiClaudia007'},
    {'SSID': 'Waltis_iPhone', 'Password': 'Walti007'},
]

def is_wifi_connected():
    wlan = network.WLAN(network.STA_IF)
    return wlan.isconnected()
    
def connect_to_wifi(homeController, connections, max_wifi_connect_tries=20, timeout_between_tries=0.5):
    # try to connect to Wi-Fi
    wlan = network.WLAN(network.STA_IF)
    wlan.active(True)

    for a_connection in connections:
        ssid = a_connection['SSID']
        wifi_pwd = a_connection['Password']
        
        wlan.connect(ssid, wifi_pwd)
        wifi_connect_tries = 0

        while not wlan.isconnected() and wlan.status() >= 0 and wifi_connect_tries < max_wifi_connect_tries:
            wifi_connect_tries += 1
            status_str = f"{max_wifi_connect_tries - wifi_connect_tries:2d}:{'Connecting to':13s}{ssid:16s}"
            homeController.write_lcd(status_str)
            print(status_str)
            print(f'INFO Try: {wlan.isconnected()} {wlan.status()}')
            sleep(timeout_between_tries)
        
        if wlan.isconnected():
            netConfig = wlan.ifconfig()
            ip_adr = str(netConfig[0])
            homeController.write_lcd(f"{'Connected to':16s}{ssid:16s}")
            print(f"SSID:{ssid:16s}   IP:{ip_adr:16s}")
            return ssid, ip_adr, netConfig

    print("Failed to connect to any network.")
    homeController.write_lcd("Wi-Fi Connection Failed")
    return None, None, None


def fetch_time_with_retries(url, retries=5, delay=2):
    for attempt in range(retries):
        try:
            response = urequests.get(url)
            return response  # If successful, return the response
        except OSError as e:
            print(f"Attempt {attempt + 1} failed: {e}")
            time.sleep(delay)
    raise Exception("Failed to fetch time after multiple attempts.")


def set_rtc_time(rtc, url = 'http://worldtimeapi.org/api/timezone/Europe/Zurich'):
    if not is_wifi_connected():
        print("WARNING: Not connected to Wi-Fi. Cannot fetch time.")
        return False  # Abort if no Wi-Fi
        
    clock_is_set = True
    try:
        r = fetch_time_with_retries(url)
        json_res = json.loads(r.text)
        r.close()
    except (ValueError, OSError) as e:
        print("WARNING: Time not read from REST!!!!")
        json_res = {'datetime': '2023-06-04T14:17:43.914520+02:00'} ## datetime.now().isoformat()}
        clock_is_set = False

    datetime_str = json_res['datetime']
    yyyy = int(datetime_str[:4])
    mm = int(datetime_str[5:7])
    dd = int(datetime_str[8:10])
    hh = int(datetime_str[11:13])
    min = int(datetime_str[14:16])
    sec = int(datetime_str[17:19])
    now_time = (yyyy, mm, dd, None, hh, min, sec, 0)
    rtc.datetime(now_time)
    print("RTC set to:", now_time)
    date_str = f'{dd:02d}.{mm:02d}.{yyyy:4d}'
    time_str = f'{hh:02d}:{min:02d}:{sec:02d}'
    print(f'Now: {date_str} {time_str}')
    
    clock_is_set_text = 'Clock NOT syncronized'
    if clock_is_set:
        clock_is_set_text = 'Clock is syncronized'
    return clock_is_set, clock_is_set_text



def set_rtc_time_new(rtc, url=DEFAULT_TIME_URL, verbose=True):
    """
    Sets the RTC time using an external time API.

    Args:
        rtc: The RTC module object.
        url: The API endpoint to fetch the current time.
        verbose: Whether to print details about the operation.

    Returns:
        Tuple containing:
            - bool: Whether the clock is synchronized.
            - str: Synchronization status text.
            - str: The name of the weekday.
    """
    if not is_wifi_connected():
        if verbose:
            print("WARNING: Not connected to Wi-Fi. Cannot fetch time.")
        return False, "Clock NOT synchronized", "Unknown"

    clock_is_set = True
    try:
        r = fetch_time_with_retries(url)
        json_res = json.loads(r.text)
        r.close()
    except (ValueError, OSError) as e:
        if verbose:
            print("WARNING: Time not read from REST!")
        json_res = {'datetime': datetime.now().isoformat()}  # Fallback to system time
        clock_is_set = False

    datetime_str = json_res['datetime']
    dt = datetime.fromisoformat(datetime_str)

    yyyy = dt.year
    mm = dt.month
    dd = dt.day
    hh = dt.hour
    minute = dt.minute
    sec = dt.second
    weekday_name = dt.strftime("%A")  # Get weekday name

    # Include the weekday (0 = Monday, 6 = Sunday) in the RTC time tuple
    now_time = (yyyy, mm, dd, dt.weekday(), hh, minute, sec, 0)
    rtc.datetime(now_time)

    if verbose:
        print("RTC set to:", now_time)
        date_str = f'{dd:02d}.{mm:02d}.{yyyy:4d}'
        time_str = f'{hh:02d}:{minute:02d}:{sec:02d}'
        print(f'Now: {date_str} {time_str} ({weekday_name})')

    clock_is_set_text = 'Clock is synchronized' if clock_is_set else 'Clock NOT synchronized'
    return clock_is_set, clock_is_set_text, weekday_name


def get_string_from_date_time(datetime):
    return f'{datetime[0]:04d}-{datetime[1]:02d}-{datetime[2]:02d}', f'{datetime[4]:02d}:{datetime[5]:02d}:{datetime[6]:02d}'

def get_string_from_date_time_with_weekday(datetime, lang='de', short=True):
    """
    Converts a datetime tuple into formatted date and time strings, including the weekday.

    Args:
        datetime (tuple): A tuple in the format 
                          (year, month, day, weekday, hour, minute, second, subsecond).

    Returns:
        tuple: (date_string_with_weekday, time_string)
               - date_string_with_weekday: Formatted as "YYYY-MM-DD (Weekday)"
               - time_string: Formatted as "HH:MM:SS"
    """
    # Map weekday index to name (0 = Monday, 6 = Sunday)
    weekday_map_long_de = ['Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag', 'Sonntag']
    weekday_map_long_en = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
    
    weekday_map_short_de = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So']
    weekday_map_short_en = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    
    weekday_map = weekday_map_short_de
    if lang == 'de' and short:
        weekday_map = weekday_map_short_de
    elif lang == 'de' and not short:
        weekday_map = weekday_map_long_de
    elif lang == 'en' and short:
        weekday_map = weekday_map_short_en
    elif lang == 'en' and not short:
        weekday_map = weekday_map_long_en
    
    weekday_name = weekday_map[datetime[3]]
    
    # Create the date string with weekday
    date_str_with_weekday = f'{weekday_name} {datetime[2]:02d}.{datetime[1]:02d}.{datetime[0]:04d}'
    
    # Create the time string
    time_str = f'{datetime[4]:02d}:{datetime[5]:02d}:{datetime[6]:02d}'
    
    return date_str_with_weekday, time_str


def initialization():
    homeController = HomeController()
    sleep(1)
    homeController.write_lcd(pgm_name + ' ' + version)
    sleep(2)
    ssid, ip_adress, netConfig = connect_to_wifi(homeController, wifi_connections)
    if not ssid:
        return  # Stop further initialization if Wi-Fi fails
    sleep(2)
    homeController.write_lcd(f'{ssid:16s}{ip_adress:16s}')

    # Initialize RTC in the microcontroller
    rtc = RTC()
    clock_is_set, clock_is_set_text = set_rtc_time(rtc)
    date_str, time_str = get_string_from_date_time(rtc.datetime())
    
    print(f'Date/Time now: {date_str} {time_str} --> {clock_is_set_text}', end='\n\n')
    homeController.write_lcd(f'{date_str:16s}{time_str:16s}')
    
    
    addr = socket.getaddrinfo(netConfig[0], 80)[0][-1]
    server = socket.socket()
    server.bind(addr)
    server.listen(1)
    
    return homeController, rtc, ssid, ip_adress, server


def minuten_takt(event):
    if not minuten_takt_suspended:
        homeController.toggle_relais(0)
        homeController.toggle_relais(1)

    print()
   
def sekunden_takt(event):
    global wait_for_minuten_schlag
    # date_str, time_str = get_string_from_date_time(rtc.datetime())
    date_str, time_str = get_string_from_date_time_with_weekday(rtc.datetime())
    
    homeController.write_lcd(f'{date_str:^16s}{time_str:^16s}', do_clear=False)

    if wait_for_minuten_schlag and time_str[-2:] == '00':
        wait_for_minuten_schlag = False
        print('Minuten Takt should start!!')
        
    if not minuten_takt_suspended:
        print('.', end='')
    else:
        print(':', end='')

def set_time_forward(minutes=10, sleep_time=0.5):
    minuten_takt_suspended = True
    homeController.set_status_led('Yellow', 1)
    for i in range(minutes):
        homeController.toggle_relais(0)
        homeController.toggle_relais(1)
        sleep(sleep_time)
        
    minuten_takt_suspended = False
    homeController.set_status_led('Yellow', 0)
    
def calc_minutes_from_timestamp(time_stamp):
    print(f'calc_minutes_from_timestamp({time_stamp})')
    hour_str = time_stamp[0:2]
    min_str = time_stamp[3:5]
    print(f'{hour_str} {min_str}')
    try:
        curr_hour = int(hour_str)
        curr_min = int(min_str)
    except Exception as e:
        print(f"ERROR in calc_minutes_from_timestamp cast: {e}")
        curr_hour = 0
        curr_min = 0
    if curr_hour >= 12:
        curr_hour -= 12
    return curr_hour * 60 + curr_min
    
def calc_minutes_diff(current_time=None, time_displayed='12:00'):
    print(f'calc_minutes({current_time}, {time_displayed})')
    if current_time is None:
        date_str, time_str = get_string_from_date_time_with_weekday(rtc.datetime())
        current_time = time_str[0:5]
    
    print(f'calc_minutes_diff({current_time}, {time_displayed})')

    display_min = calc_minutes_from_timestamp(time_displayed)
    curr_min = calc_minutes_from_timestamp(current_time)
    
    minutes_behind = curr_min - display_min

    print(f'{curr_min} - {display_min} = {minutes_behind}')
    if minutes_behind > 0:
        return minutes_behind
    else:
        return minutes_behind
    
def get_parameters_from_url(url_str):
    ret_val = {}
    end_point, params_str = url_str.split("?")
    end_point = end_point.replace('/', '')
    for param in params_str.split("&"):
        key, value = param.split("=")
        ret_val[key] = value
        # print(f'{key}:{value}')
    print(f'Endpoint:{end_point}  Params:{ret_val}')
    return end_point, ret_val
    




 
    
# =================  
# main
# =================  
homeController, rtc, ssid, ip_adress, server = initialization()

# -----------------   
# html-Pages
# ----------------- 
test_page_str = f'''
<HTML>
   <BODY>
    <H1>{pgm_name} {version}</H1>
    <h3>End_Point: set_relais():</h3>
    <UL>
      <LI><a href="http://192.168.1.110/set_relais?relais=3&status=on">192.168.1.110/set_relais?relais=3&status=on</a></LI>
      <LI><a href="http://192.168.1.110/set_relais?relais=3&status=off">192.168.1.110/set_relais?relais=3&status=off</a></LI>
      <LI><a href="http://192.168.1.110/set_relais?relais=3&status=toggle">192.168.1.110/set_relais?relais=3&status=toggle</a><br/></LI>
      
      <LI><a href="http://192.168.1.110/set_relais?relais=3&status=1">192.168.1.110/set_relais?relais=3&status=1</a></LI>
      <LI><a href="http://192.168.1.110/set_relais?relais=3&status=0">192.168.1.110/set_relais?relais=3&status=0</a></LI>
      <LI><a href="http://192.168.1.110/set_relais?relais=3&status=!">192.168.1.110/set_relais?relais=3&status=!</a></LI>
    </UL>
    <br/>
    
    <h3>End_Point: set_led_status()</h3>
    <UL>
      <LI><a href="http://192.168.1.110/set_led_status?color=Green&status=on">192.168.1.110/set_led_status?color=Green&status=on</a></LI>
      <LI><a href="http://192.168.1.110/set_led_status?color=Green&status=off">192.168.1.110/set_led_status?color=Green&status=off</a></LI>
      <LI><a href="http://192.168.1.110/set_led_status?color=Green&status=toggle">192.168.1.110/set_led_status?color=Green&status=toggle</a><br/></LI>
      
      <LI><a href="http://192.168.1.110/set_led_status?color=Yellow&status=1">192.168.1.110/set_led_status?color=Yellow&status=1</a></LI>
      <LI><a href="http://192.168.1.110/set_led_status?color=Yellow&status=0">192.168.1.110/set_led_status?color=Yellow&status=0</a></LI>
      <LI><a href="http://192.168.1.110/set_led_status?color=Yellow&status=!">192.168.1.110/set_led_status?color=Yellow&status=!</a></LI>
    </UL>
    
    <h3>End_Point: set_minute_suspended():</h3>
    <UL>
      <LI><a href="http://192.168.1.110/set_minute_suspended?status=on">192.168.1.110/set_minute_suspended?status=on</a></LI>
      <LI><a href="http://192.168.1.110/set_minute_suspended?status=True">192.168.1.110/set_minute_suspended?status=True</a></LI>
      <LI><a href="http://192.168.1.110/set_minute_suspended?status=1">192.168.1.110/set_minute_suspended?status=1</a><br/></LI>
      
      <LI><a href="http://192.168.1.110/set_minute_suspended?status=off">192.168.1.110/set_minute_suspended?status=off</a></LI>
      <LI><a href="http://192.168.1.110/set_minute_suspended?status=False">192.168.1.110/set_minute_suspended?status=False</a></LI>
      <LI><a href="http://192.168.1.110/set_minute_suspended?status=0">192.168.1.110/set_minute_suspended?status=0</a></LI>
    </UL>
    
    <h3>End_Point: set_time_forward():</h3>
    <UL>
      <LI><a href="http://192.168.1.110/set_time_forward?minutes=20">/set_time_forward?minutes=20</a></LI>
      <LI><a href="http://192.168.1.110/set_time_forward?minutes=20&sleep_time=0.2">/set_time_forward?minutes=20&sleep_time=0.2</a></LI>
      <LI><a href="http://192.168.1.110/set_time_forward?minutes=10&sleep_time=0.2">/set_time_forward?minutes=10&sleep_time=0.2</a></LI>
    </UL>
    
    <h3>End_Point: set_time():</h3>
    <UL>
      <LI><a href="http://192.168.1.110/set_time?time_displayed=12:45">/set_time?time_displayed=12:45</a></LI>
    </UL>
    <br/>
   </BODY>
</HTML>
''' 

home_page_str = f'''
<HTML>
   <BODY>
   <H1>{pgm_name}</H1>
   Firmeware Version:{version}</BR>
   Date/Time:{get_string_from_date_time_with_weekday(rtc.datetime())}</BR>
   <center>
   <img src='https://www.watson.ch/imgdb/f3e1/Qx,A,0,0,500,500,208,208,83,83;Ani/6271968486555948'><BR/>
   <A href='https://blog.nationalmuseum.ch/2022/09/die-teure-schweizer-bahnhofsuhr/'>Geschichte</A>
   <A href='https://digital.sbb.ch/de/design-system/lyne/components/clock/'>Live Uhr</A>
   
   </center>
   </BR>
   </BR>
   </BR>
   </BODY>
</HTML>
''' 
# ----------------- 

print('Sekunden Takt started!!')
sekunden_clock = Timer()
sekunden_clock.init(period=1000, mode=Timer.PERIODIC, callback=sekunden_takt)

while wait_for_minuten_schlag:
    sleep(0.5)

print('Minuten Takt started!!')
minuten_clock = Timer()
minuten_clock.init(period=60000, mode=Timer.PERIODIC, callback=minuten_takt)

# Auf eingehende Requests hören
print('Server started!')
while True:
    try:
        print('Waiting for HTTP-Request')
        homeController.set_status_led('Green', 1) 
        conn, addr = server.accept()
        request = str(conn.recv(1024))

        path = request.split("HTTP")[0].split("GET ")[-1].rstrip().lstrip()

        print(f'Request {path} received!')
        code = 200
        content_type = "application/json"
        if "set_relais?" in path:
            print(path)
            response = {"operation status": "OK"}
            end_point, params = get_parameters_from_url(path)
            print(f'Endpoint:{end_point}  Params:{params}')
            
            if params['status'] == 'on' or params['status'] == '1':
                homeController.set_relais(params['relais'], 1)
            elif params['status'] == 'off' or params['status'] == '0':
                homeController.set_relais(params['relais'], 0)
            elif params['status'] == 'toggle' or params['status'] == '!':
                homeController.toggle_relais(params['relais'])
                
            response = {'endpoint:': end_point,
                        'parameters': params,
                       }
        elif "set_led_status?" in path:
            print(path)
            response = {"operation status": "OK"}
            end_point, params = get_parameters_from_url(path)
            print(f'Endpoint:{end_point}  Params:{params}')
            
            
            if params['status'] == 'on' or params['status'] == '1':
                homeController.set_status_led(params['color'], 1)
            elif params['status'] == 'off' or params['status'] == '0':
                homeController.set_status_led(params['color'], 0)
            elif params['status'] == 'toggle' or params['status'] == '!':
                homeController.toggle_status_led(params['color'])
            
            response = {'endpoint:': end_point,
                        'parameters': params,
                       }
                       
        elif "set_minute_suspended?" in path:
            print(path)
            response = {"operation status": "OK"}
            end_point, params = get_parameters_from_url(path)
            print(f'Endpoint:{end_point}  Params:{params}')
            
            
            if params['status'] == 'on' or params['status'] == 'True' or params['status'] == '1':
                minuten_takt_suspended = True
                homeController.set_status_led('Yellow', 1)
            elif params['status'] == 'off' or params['status'] == 'False' or params['status'] == '0':
                minuten_takt_suspended = False
                homeController.set_status_led('Yellow', 0)
            
            
            response = {'endpoint:': end_point,
                        'parameters': params,
                       }                      
                       
        elif "set_time_forward?" in path:
            print(path)
            response = {"operation status": "OK"}
            end_point, params = get_parameters_from_url(path)
            print(f'Endpoint:{end_point}  Params:{params}')
            
            try:
                minutes = int(params['minutes'])
            except Exception as e:
                minutes = 1
                print(f"ERROR in minutes cast: {e}")
            
            try:            
                sleep_time = float(params['sleep_time'])
            except Exception as e:
                sleep_time = 0.5
                print(f"ERROR in sleep_time cast: {e}")
            
            set_time_forward(minutes=minutes, sleep_time=sleep_time)
            
            
            response = {'endpoint:': end_point,
                        'parameters': params,
                       }                       

        elif "set_time?" in path:
            print(path)
            response = {"operation status": "OK"}
            end_point, params = get_parameters_from_url(path)
            print(f'Endpoint:{end_point}  Params:{params}')
            
            try:            
                sleep_time = float(params['sleep_time'])
            except Exception as e:
                sleep_time = 0.5
                print(f"ERROR in sleep_time cast: {e}")
            minutes = calc_minutes_diff(time_displayed=params['time_displayed'])
            if minutes > 0:
                set_time_forward(minutes=minutes, sleep_time=sleep_time)
            else:
                minuten_takt_suspended = True
                homeController.set_status_led('Yellow', 1)

            
            response = {'endpoint:': end_point,
                        'parameters': params,
                       }   
                   
        elif path == "/status":
            response = {'ssid': ssid,
                        'ip_adress': ip_adress,
                       }
                       
        elif path == "/docs":
            response = {"url": f"{ip_adr}/cgi/",
                        "relais": [0, 1, 2, 3],
                        "status": ["on", "off"],
                        "example_1": f"{ip_adr}" + "/cgi?relais=1&status=on",
                        "example_2": f"{ip_adr}" + "/cgi?relais=1&status=off",
                        "example_3": f"{ip_adr}" + "/cgi?relais=1&status=toggle"
                        }
        
        elif path == "/test":
            content_type = "text/html"
            response = test_page_str
            
        else:
            content_type = "text/html"
            response = home_page_str
            
        if content_type == "application/json":
            response = json.dumps(response)

        conn.send(f'HTTP/1.0 {code} OK\r\nContent-type: {content_type}\r\n\r\n')
        conn.send(response)
        conn.close()
    except OSError as e:
        print(f'ERROR: {e}')
        break
    except (KeyboardInterrupt):
        homeController.write_lcd(f'Closing Server')
        break
 
    
server.close()
homeController.set_status_led('Green', 0)
print('Server beendet')
