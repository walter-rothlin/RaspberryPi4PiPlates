# ------------------------------------------------------------------
# Name  : Bahnhof_MutterUhr_01.py
#
# Description: REST-Enpoints for Relais Steuerung
# Source: https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_Micro_For_RPi_Pico/Bahnhof_MutterUhr_01.py
#
# Autor: Walter Rothlin
#
# History:
# 01-Jan-2023   Tobias Rothlin      Initial Version
# 03-Jun-2023   Walter Rothlin      Removed Hard-Coded IP from docs
#                                   Added Timer-Event
# 04-Jun-2023   Walter Rothlin      Set RTC via REST Service
# 30-Jun-2023   Walter Rothlin      Var clock_is_set_text added
# ------------------------------------------------------------------
pgm_name = 'SBB-Uhr'
version = '2.0.0.2'
from machine import Pin, UART, Timer, RTC
from time import sleep
import socket
import network
import json
import urequests


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


def set_rtc_time(rtc):
    # rtc.datetime((2020, 1, 21, None, 10, 32, 36, 0))
    clock_is_set = True
    try:
        r = urequests.get("http://worldtimeapi.org/api/timezone/Europe/Zurich")
        json_res = json.loads(r.text)
    except ValueError as e:
        print('WARNING: Time not read from REST!!!!')
        json_res = {'datetime': '2023-06-04T14:17:43.914520+02:00'}
        clock_is_set = False

    # print(json_res['datetime'])
    yyyy = int(json_res['datetime'][:4])
    mm = int(json_res['datetime'][5:7])
    dd = int(json_res['datetime'][8:10])
    tz = int(json_res['datetime'][27:29])
    # print('tz:',tz)
    hh = int(json_res['datetime'][11:13])  # + tz

    min = int(json_res['datetime'][14:16])
    sec = int(json_res['datetime'][17:19])
    now_time = (yyyy, mm, dd, None, hh, min, sec, 0)
    # print('now_time:', now_time)
    rtc.datetime(now_time)
    return clock_is_set


# Echtzeituhr im Mikrocontroller initialisieren
rtc = RTC()

# Init HW
relais = [Pin(r, Pin.OUT) for r in [13, 14, 15, 16]]
for r in relais:
    r.off()

status_ok = Pin(6, Pin.OUT)
status_ok.off()
status_warning = Pin(7, Pin.OUT)
status_warning.off()
status_wifi = Pin(8, Pin.OUT)
status_wifi.off()

# try to connect to WIFI
wlan = network.WLAN(network.STA_IF)
wlan.active(True)
# wlan.connect('WalterRothlin_2', 'waltiClaudia007')
wlan.connect('WIFI-PSC', 'Wlan-PSC!')

max_wifi_connect_tries = 100
wifi_connect_tries = 0
while not wlan.isconnected() and wlan.status() >= 0 and wifi_connect_tries < max_wifi_connect_tries:
    wifi_connect_tries += 1
    status_wifi.toggle()
    print(f'WARNING ({wifi_connect_tries:3d}): Not connected to WIFI!!!!')
    sleep(0.5)

if wifi_connect_tries < max_wifi_connect_tries:
    ip_adr = ''
    clock_is_set = False
    if wlan.isconnected():
        status_wifi.on()
        status_warning.off()
        netConfig = wlan.ifconfig()
        ip_adr = str(netConfig[0])
        clock_is_set = set_rtc_time(rtc)

    addr = socket.getaddrinfo(netConfig[0], 80)[0][-1]
    server = socket.socket()
    server.bind(addr)
    server.listen(1)
    status_ok.on()

    clock_is_set_text = 'Clock NOT syncronized'
    if clock_is_set:
        clock_is_set_text = 'Clock is syncronized'

    print(pgm_name, 'Version:', version)
    print('Actual IP:', ip_adr, end='\n')
    print('Date/Time now: ', get_string_from_date_time(rtc.datetime()), clock_is_set_text, end='\n\n')

watchdog_timer = Timer()
watchdog_timer.init(period=2000, mode=Timer.PERIODIC, callback=watch_dog_cb_fct)

minuten_clock = Timer()
minuten_clock.init(period=60000, mode=Timer.PERIODIC, callback=minuten_takt)

# Auf eingehende Requests hören
while True:
    try:
        conn, addr = server.accept()
        request = str(conn.recv(1024))

        path = request.split("HTTP")[0].split("GET ")[-1].rstrip().lstrip()

        code = 200
        content_type = "application/json"

        if "?" in path and "relais" in path and "status" in path:
            response = {"operation status": "OK"}
            status_warning.off()
            path, params_str = path.split("/?")
            params = {}
            for param in params_str.split("&"):
                key, value = param.split("=")
                params[key] = value
                response[key] = value

            if "status" in params and "relais" in params:
                if int(params["relais"]) >= 0 and int(params["relais"]) <= 4:
                    if params["status"] == "on":
                        relais[int(params["relais"]) - 1].on()
                        status_warning.off()
                        status_ok.on()
                    elif params["status"] == "off":
                        relais[int(params["relais"]) - 1].off()
                        status_warning.off()
                        status_ok.on()
                    elif params["status"] == "toggle":
                        relais[int(params["relais"]) - 1].toggle()
                        status_warning.off()
                        status_ok.on()
                    else:
                        response["operation status"] = "STATUS DOES NOT EXIST"
                        response["path"] = path
                        code = 422
                        status_warning.on()
                        status_ok.off()

                else:
                    response["operation status"] = "INDEX OUT OF RANGE"
                    response["path"] = path
                    response["idx"] = int(params["relais"])
                    code = 422
                    status_warning.on()
                    status_ok.off()
            else:
                response["operation status"] = "INVALID PARAMS"
                response["path"] = path
                code = 422
                status_warning.on()
                status_ok.off()

        elif path == "/docs":
            code = 200
            response = {"url": f"{ip_adr}/cgi/",
                        "relais": [1, 2, 3, 4],
                        "status": ["on", "off"],
                        "example_1": f"{ip_adr}" + "/cgi/?relais=1&status=on",
                        "example_2": f"{ip_adr}" + "/cgi/?relais=1&status=off",
                        "example_3": f"{ip_adr}" + "/cgi/?relais=1&status=toggle"
                        }
        elif path == "/status":
            code = 200
            response = {"firmware":
                            {"name": f"{pgm_name}",
                             "version": f"{version}"
                             },
                        "relais": [f"{relais[0].value()}",
                                   f"{relais[1].value()}",
                                   f"{relais[2].value()}",
                                   f"{relais[3].value()}"],
                        "LED-Status":
                            {"status_ok": f"{status_ok.value()}",
                             "status_warning": f"{status_warning.value()}",
                             "status_wifi": f"{status_wifi.value()}"}
                        }
        else:
            content_type = "text/html"
            code = 200
            response = f'''
            <HTML>
               <BODY>
               <H1>{pgm_name}</H1>
               Firmeware Version:{version}</BR>
               Date/Time (RTC):{get_string_from_date_time(rtc.datetime())} {clock_is_set_text}</BR>
               <center>
               <img src='https://www.watson.ch/imgdb/f3e1/Qx,A,0,0,500,500,208,208,83,83;Ani/6271968486555948'><BR/>
               <A href='https://blog.nationalmuseum.ch/2022/09/die-teure-schweizer-bahnhofsuhr/'>Die Uhr</A>
               </center>
               </BR>
               </BR>
               </BR>
               Folgende Endpoints sind vorhanden:
               <UL>
                 <LI><A target="_new" href="http://{ip_adr}/cgi/?relais=3&status=on">http://{ip_adr}/cgi/?relais=3&status=on</A></LI>
                 <LI><A target="_new" href="http://{ip_adr}/cgi/?relais=3&status=off">http://{ip_adr}/cgi/?relais=3&status=off</A></LI>
                 <LI><A target="_new" href="http://{ip_adr}/cgi/?relais=3&status=toggle">http://{ip_adr}/cgi/?relais=3&status=toggle</A></BR></LI>
                 <LI><A target="_new" href="http://{ip_adr}/docs">http://{ip_adr}/docs</A></LI>
                 <LI><A target="_new" href="http://{ip_adr}/status">http://{ip_adr}/status</A></LI>
               </UL></BR></BR>
               Relais-Status:</BR>
               <table>
                   <tr><td>Relais</td><td>Status</td><td>On</td><td>Off</td><td>Toggle</td></tr>
                   <tr><td>Relais 1</td><td><center>{relais[0].value()}<center></td>
                       <td><A target="_new" href="http://{ip_adr}/cgi/?relais=1&status=on">ON</A></td>
                       <td><A target="_new" href="http://{ip_adr}/cgi/?relais=1&status=off">OFF</A></td>
                       <td><A target="_new" href="http://{ip_adr}/cgi/?relais=1&status=toggle">Toggle</A></td>
                   </tr>
                   <tr><td>Relais 2</td><td><center>{relais[1].value()}<center></td>
                       <td><A target="_new" href="http://{ip_adr}/cgi/?relais=2&status=on">ON</A></td>
                       <td><A target="_new" href="http://{ip_adr}/cgi/?relais=2&status=off">OFF</A></td>
                       <td><A target="_new" href="http://{ip_adr}/cgi/?relais=2&status=toggle">Toggle</A></td>
                   </tr>
                   <tr><td>Relais 3</td><td><center>{relais[2].value()}<center></td>
                       <td><A target="_new" href="http://{ip_adr}/cgi/?relais=3&status=on">ON</A></td>
                       <td><A target="_new" href="http://{ip_adr}/cgi/?relais=3&status=off">OFF</A></td>
                       <td><A target="_new" href="http://{ip_adr}/cgi/?relais=3&status=toggle">Toggle</A></td>
                   </tr>
                   <tr><td>Relais 4</td><td><center>{relais[3].value()}<center></td>
                       <td><A target="_new" href="http://{ip_adr}/cgi/?relais=4&status=on">ON</A></td>
                       <td><A target="_new" href="http://{ip_adr}/cgi/?relais=4&status=off">OFF</A></td>
                       <td><A target="_new" href="http://{ip_adr}/cgi/?relais=4&status=toggle">Toggle</A></td>
                   </tr>
               </table>
               </BR></BR>
               LED-Status:</BR>
               &nbsp;&nbsp;status_ok (Green): {status_ok.value()}</BR>
               &nbsp;&nbsp;status_warning (Orange): {status_warning.value()}</BR>
               &nbsp;&nbsp;status_wifi (Blue): {status_wifi.value()}</BR>
               </BODY>
            </HTML>
            '''

        if content_type == "application/json":
            response = json.dumps(response)

        conn.send(f'HTTP/1.0 {code} OK\r\nContent-type: {content_type}\r\n\r\n')
        conn.send(response)
        conn.close()

    except OSError as e:
        for r in relais:
            r.off()
        status_ok.off()
        status_wifi.off()
        status_warning.on()
        break
    except (KeyboardInterrupt):
        for r in relais:
            r.off()
        status_ok.off()
        status_wifi.off()
        status_warning.on()
        break

try:
    conn.close()
except NameError:
    pass
server.close()
print('Server beendet')

