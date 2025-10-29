# Multi-Relais Schaltuhr (Flask)

Web-App für mehrere Relais am Raspberry Pi.
- Gemeinsame Liste für alle Relais
- Wochentagsbezogene Schaltzeiten
- Manuelle Ein/Aus-Steuerung pro Relais
- Bootstrap-Frontend

Installation:
```
sudo apt update
sudo apt install python3 python3-venv python3-pip
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python3 app.py
```
