#!/bin/bash

HOME_DIR="$HOME"
BIN_DIR="$HOME_DIR/bin"

TARGET_REPO="/home/pi-u05/Waltis_Repo_Clone/RaspberryPi4PiPlates/Python_Raspberry/04_Sense_Hat"
CLONE_REPO_SRC="$TARGET_REPO/clone_repo.py"
SHOWIP_SRC="$TARGET_REPO/showIP.py"

CLONE_REPO_LINK="$BIN_DIR/clone_repo.py"
SHOWIP_LINK="$BIN_DIR/showIP.py"

# 1. ~/bin erstellen falls nicht vorhanden
mkdir -p "$BIN_DIR"
echo "✅ Verzeichnis $BIN_DIR ist vorhanden."

# 2. Symbolische Links nur erstellen, wenn nicht vorhanden
if [ ! -L "$CLONE_REPO_LINK" ]; then
    ln -s "$CLONE_REPO_SRC" "$CLONE_REPO_LINK"
    echo "🔗 Link erstellt: $CLONE_REPO_LINK -> $CLONE_REPO_SRC"
else
    echo "ℹ️ Link $CLONE_REPO_LINK existiert bereits. Überspringe."
fi

if [ ! -L "$SHOWIP_LINK" ]; then
    ln -s "$SHOWIP_SRC" "$SHOWIP_LINK"
    echo "🔗 Link erstellt: $SHOWIP_LINK -> $SHOWIP_SRC"
else
    echo "ℹ️ Link $SHOWIP_LINK existiert bereits. Überspringe."
fi

# 3. Crontab-Eintrag vorbereiten
CRON_ENTRY="@reboot /usr/bin/python3 $SHOWIP_LINK > /dev/null 2>&1 &"

# Crontab temporär sichern
CRONTAB_TMP=$(mktemp)
crontab -l 2>/dev/null > "$CRONTAB_TMP"

if grep -Fxq "$CRON_ENTRY" "$CRONTAB_TMP"; then
    echo "✅ Crontab-Eintrag ist bereits vorhanden."
else
    echo "$CRON_ENTRY" >> "$CRONTAB_TMP"
    crontab "$CRONTAB_TMP"
    echo "✅ Crontab-Eintrag hinzugefügt:"
    echo "$CRON_ENTRY"
fi

rm "$CRONTAB_TMP"
