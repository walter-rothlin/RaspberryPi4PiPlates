MLZ_PY2_2025_Ribi_Benedikt — Raspberry Pi deployment guide

This README explains how to run `MLZ_PY2_2025_Ribi_Benedikt.py` on a Raspberry Pi (with Sense HAT).

Prerequisites
- A Raspberry Pi with Raspbian / Raspberry Pi OS installed (ARM, up-to-date).
- Sense HAT hardware attached (or Sense HAT emulator if you don't have hardware).
- Network access to the Pi (SSH or local keyboard/monitor).

Quick install steps (recommended)

1) Update APT and install system packages (on the Pi):

```bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y python3-pip python3-venv git
# Install Sense HAT system package (provides underlying drivers and Python bindings)
sudo apt install -y sense-hat
```

Note: If you do not have real hardware and want to test, you can install the Sense HAT emulator:

```bash
sudo apt install -y sense-emu
# and optionally the GUI
sudo apt install -y python3-sense-emu
```

2) Clone or copy the project to the Pi (example using git):

```bash
cd /home/pi
git clone <your-repo-url> MLZ_Project
cd MLZ_Project/MLZ_2025_PY2
```

3) Create a Python virtual environment and install pip dependencies:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements-pi.txt
```

Important: The `sense_hat` package is normally provided by the OS package (`apt install sense-hat`). If you installed `sense-emu` for testing, the emulator provides the same `sense_hat` Python package.

4) Run the app:

```bash
source .venv/bin/activate
python3 MLZ_PY2_2025_Ribi_Benedikt.py
```

The app will listen on port 5002 by default and bind to all interfaces (0.0.0.0). Open a browser and go to http://<pi-ip>:5002/ to use the web UI.

Optional: Run as systemd service (auto start on boot)

Create `/etc/systemd/system/mlz-sense.service` (use sudo) with content:

```ini
[Unit]
Description=MLZ Sense HAT Flask App
After=network.target

[Service]
User=pi
WorkingDirectory=/home/pi/MLZ_Project/MLZ_2025_PY2
Environment="PATH=/home/pi/MLZ_Project/MLZ_2025_PY2/.venv/bin"
ExecStart=/home/pi/MLZ_Project/MLZ_2025_PY2/.venv/bin/python3 MLZ_PY2_2025_Ribi_Benedikt.py
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

Then enable and start:

```bash
sudo systemctl daemon-reload
sudo systemctl enable mlz-sense.service
sudo systemctl start mlz-sense.service
sudo journalctl -u mlz-sense -f
```

Troubleshooting
- If `from sense_hat import SenseHat` fails, ensure you installed `sense-hat` via apt or `sense-emu` if using the emulator. Reboot after installing the Sense HAT driver packages.
- If permission issues occur while accessing hardware, ensure you run as `pi` user or use sudo for hardware-specific actions.
- To test without hardware, consider running `python3 -c 'from sense_hat import SenseHat; s=SenseHat(); print(s.get_temperature())'` after installing `sense-emu`.

Security note
- The example Flask app runs without authentication. If you expose the Pi to untrusted networks, protect the app (reverse proxy, firewall, or enable authentication).

Contact
- If you want, I can add an optional systemd unit, a Dockerfile for containerization on Raspberry Pi, or add a small start script. Tell me which you prefer.

Run tests locally
------------------

If you have the project's virtual environment available, run the MySenseHat pytest suite locally to validate the negative tests:

PowerShell (Windows):

```powershell
# activate venv (example)
& .\.venv-1\Scripts\Activate.ps1
python -m pytest tests/test_mysensehat_negative.py -q
```

Bash (Linux/macOS or Raspberry Pi):

```bash
source .venv/bin/activate
python -m pytest tests/test_mysensehat_negative.py -q
```

The tests run against the `MySenseHat` implementation (or the mock/emulator fallback) and verify out-of-bounds handling, invalid input resilience and draw_line robustness.
