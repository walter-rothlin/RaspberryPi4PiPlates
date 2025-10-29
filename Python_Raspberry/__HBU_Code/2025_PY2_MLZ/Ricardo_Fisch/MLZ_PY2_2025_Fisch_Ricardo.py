
# -*- coding: utf-8 -*-
"""Flask-REST-Service für Sense HAT (einfach & erklärbar).

- Bietet Endpoints gemäss Kriterien.
- Nutzt MySenseHat (kann ohne Hardware laufen).
- Zeigt Logs am Ende der index.html.
"""
from __future__ import annotations
from flask import Flask, jsonify, request, render_template
from Class_My_SenseHat import MySenseHat

# ---- Konfiguration (leicht anpassbar) ----
IP_ADDRESS = "192.168.107.59"     # ggf. anpassen (z.B. 192.168.1.23)
PORT = 5000
VERSION = "MLZ_PY2_2025_Fisch_Ricardo"

app = Flask(__name__, template_folder="templates")
sense = MySenseHat()  # unsere einfach erklärbare SenseHat-Hülle

# ---- Seiten ----
@app.get("/")
def index():
    # Startseite mit Buttons/Links + Logs am Ende
    return render_template("index.html", version=VERSION, logs=sense.get_log())

@app.get("/led_tester")
def led_tester():
    # Einfache Testseite für die LED-Matrix
    return render_template("LED_Matrix_Tester.html", version=VERSION)

# ---- Hilfsfunktionen (Antwortformat) ----
def ok(**data):
    data.setdefault("status", "ok")
    return jsonify(data), 200

def err(msg, code=400, **data):
    data.update({"status": "error", "message": msg})
    return jsonify(data), code

# ---- Basis-Endpoints ----
@app.get("/get_status")
def get_status():
    return ok(version=VERSION, rotation=sense.rotation)

@app.delete("/clear")
def clear():
    sense.clear()
    return ok(message="cleared")

@app.post("/show_letter")
def show_letter():
    # Kleines Extra (ähnlich zur Aufgabe erwähnt)
    body = request.get_json(silent=True) or {}
    letter = body.get("letter", "A")
    color = body.get("color", [255,255,255])
    bg = body.get("bg", [0,0,0])
    # Implementierung via show_message (vereinfachend)
    sense.show_message(letter, text_color=tuple(color), bg_color=tuple(bg))
    return ok(letter=letter)

# ---- Kriterien-Endpoints ----
@app.post("/set_rotation")
def set_rotation():
    body = request.get_json(silent=True) or {}
    rotation = int(body.get("rotation", 0))
    invert = bool(body.get("invert", False))
    sense.set_rotation(rotation, invert=invert)
    return ok(rotation=sense.rotation, invert=invert)

@app.post("/flip_h")
def flip_h():
    sense.flip_h()
    return ok(message="flipped horizontally")

@app.post("/flip_v")
def flip_v():
    sense.flip_v()
    return ok(message="flipped vertically")

@app.get("/get_pixels")
def get_pixels():
    return ok(pixels=sense.get_pixels())

@app.post("/set_pixel")
def set_pixel():
    body = request.get_json(silent=True) or {}
    x = body.get("x", 0)
    y = body.get("y", 0)
    color = body.get("color", [255,0,0])
    sense.set_pixel(x, y, pixel_color=tuple(color))
    return ok(x=int(float(x)), y=int(float(y)), color=color)

@app.get("/get_pixel")
def get_pixel():
    try:
        x = request.args.get("x", "0")
        y = request.args.get("y", "0")
        val = sense.get_pixel(x, y)
        return ok(x=int(float(x)), y=int(float(y)), color=val)
    except Exception as e:
        return err(str(e))

@app.post("/show_message")
def show_message():
    body = request.get_json(silent=True) or {}
    text = body.get("text", "Hello")
    tc = tuple(body.get("text_color", [255,255,255]))
    bg = tuple(body.get("bg_color", [0,0,0]))
    sense.show_message(text, text_color=tc, bg_color=bg)
    return ok(text=text)

@app.get("/get_temprature")  # Schreibweise aus den Kriterien
def get_temprature():
    return ok(value=sense.get_temprature())

@app.get("/get_pressure")
def get_pressure():
    return ok(value=sense.get_pressure())

@app.get("/get_humidity")
def get_humidity():
    return ok(value=sense.get_humidity())

@app.get("/get_meteo_sensor_values")
def get_meteo_sensor_values():
    return ok(values=sense.get_meteo_sensor_values())

@app.get("/get_weather")
def get_weather():
    return ok(weather=sense.get_weather())

@app.post("/draw_line")
def draw_line():
    body = request.get_json(silent=True) or {}
    x1 = body.get("x1", 0); y1 = body.get("y1", 0)
    x2 = body.get("x2", 7); y2 = body.get("y2", 7)
    color = tuple(body.get("color", [255,255,255]))
    speed = float(body.get("speed", 0.0))
    sense.draw_line(x1, y1, x2, y2, color[0], color[1], color[2], speed)
    return ok(message="line drawn")

if __name__ == "__main__":
    # App starten (für lokale Tests)
    app.run(host=IP_ADDRESS, port=PORT, debug=True)
