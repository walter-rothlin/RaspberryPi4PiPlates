from machine import Pin, UART
from time import sleep
import socket
import network
import json

relais = [Pin(r, Pin.OUT) for r in [13, 14, 15, 16]]
for r in relais:
    r.off()

status_ok = Pin(6, Pin.OUT)
status_ok.off()
status_warning = Pin(7, Pin.OUT)
status_warning.off()
status_wifi = Pin(8, Pin.OUT)
status_wifi.off()

wlan = network.WLAN(network.STA_IF)
path
wlan.active(True)
wlan.connect('WalterRothlin_2', 'waltiClaudia007')

while not wlan.isconnected() and wlan.status() >= 0:
    status_warning.toggle()
    sleep(0.5)

if wlan.isconnected():
    status_wifi.on()
    status_warning.off()
    netConfig = wlan.ifconfig()
    print(netConfig[0])

addr = socket.getaddrinfo(netConfig[0], 80)[0][-1]
server = socket.socket()
server.bind(addr)
server.listen(1)

# Auf eingehende Verbindungen hören
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
                if int(params["relais"]) >= 0 and int(params["relais"]) < 4:
                    if params["status"] == "on":
                        relais[int(params["relais"]) - 1].on()
                        status_warning.off()
                        status_ok.on()
                    elif params["status"] == "off":
                        relais[int(params["relais"]) - 1].off()
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
            response = {"url": "192.168.1.145/cgi/",
                        "relais": [1, 2, 3, 4],
                        "status": ["on", "off"],
                        "example": "192.168.1.145/cgi/?relais=1&status=on"}

        else:
            response = {"operation status": "FAIL"}
            code = 422
            status_warning.on()
            status_ok.off()

        response = json.dumps(response)
        conn.send(f'HTTP/1.0 {code} OK\r\nContent-type: {content_type}\r\n\r\n')
        conn.send(response)
        conn.close()

    except OSError as e:
        break
    except (KeyboardInterrupt):
        break

try:
    conn.close()
except NameError:
    pass
server.close()
print('Server beendet')

