# Raspberry Pi Schaltuhr (Flask)

Diese Anwendung stellt ein Web-Interface bereit, um einen Relay-Ausgang am Raspberry Pi zeitgesteuert zu schalten.
Features:
- Wochentagsbezogene Schaltzeiten (Mehrfachauswahl)
- Manuelle Ein/Aus-Steuerung
- Bootstrap-basiertes Frontend
- Konfiguration in `config.json`

## Installation (auf dem Raspberry Pi)
```bash
sudo apt update
sudo apt install python3 python3-venv python3-pip
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

## Starten
```bash
# optional: aktivieren des virtuellen env
source venv/bin/activate
python3 app.py
```

Die App läuft dann unter `http://<deine_pi_ip>:5000`

## Hinweise
- Standardmäßig wird GPIO BCM-Pin 17 verwendet (siehe `RELAY_PIN` in `scheduler.py`). Passe `config.json` an, falls du einen anderen Pin nutzen willst.
- Beim Testen auf einem Nicht-Raspberry-System verwendet die App ein Fake-GPIO (keine Hardwareänderung).
- Für Produktionsbetrieb: systemd-Service erstellen oder einen WSGI-Server (gunicorn) verwenden.
