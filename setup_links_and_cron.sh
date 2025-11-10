#!/bin/bash

HOME_DIR="$HOME"
BIN_DIR="$HOME_DIR/bin"

TARGET_REPO="../Waltis_Repo_Clone/RaspberryPi4PiPlates/Python_Raspberry"

CLONE_REPO_SRC="$TARGET_REPO/04_Sense_Hat/clone_repo.py"
CLONE_REPO_LINK="$BIN_DIR/clone_repo.py"

SHOWIP_SRC="$TARGET_REPO/04_Sense_Hat/showIP.py"
SHOWIP_LINK="$BIN_DIR/showIP.py"

CLEANUP_SRC="$TARGET_REPO/../delete_pycache.sh"
CLEANUP_LINK="$BIN_DIR/cleanup"

SBB_UHR_SRC="$TARGET_REPO/06_Bahnhofuhr/Python_On_RaspberryPi/Bahnhof_MutterUhr.py"
SBB_UHR_LINK="$BIN_DIR/Bahnhof_MutterUhr.py"

SCHALTUHR_SRC="$TARGET_REPO/05_Schaltuhren/Schaltuhr_for_one_Relais/run.sh"
SCHALTUHR_LINK="$BIN_DIR/Schaltuhr_one_relais"

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

if [ ! -L "$CLEANUP_LINK" ]; then
    ln -s "$CLEANUP_SRC" "$CLEANUP_LINK"
    echo "🔗 Link erstellt: $CLEANUP_LINK -> $CLEANUP_SRC"
else
    echo "ℹ️ Link $CLEANUP_LINK existiert bereits. Überspringe."
fi

if [ ! -L "$SBB_UHR_LINK" ]; then
    ln -s "$SBB_UHR_SRC" "$SBB_UHR_LINK"
    echo "🔗 Link erstellt: $SBB_UHR_LINK -> $SBB_UHR_SRC"
else
    echo "ℹ️ Link $SBB_UHR_LINK existiert bereits. Überspringe."
fi

if [ ! -L "$SCHALTUHR_LINK" ]; then
    ln -s "$SCHALTUHR_SRC" "$SCHALTUHR_LINK"
    echo "🔗 Link erstellt: $SCHALTUHR_LINK -> $SCHALTUHR_SRC"
else
    echo "ℹ️ Link $SCHALTUHR_LINK existiert bereits. Überspringe."
fi

# 3. Crontab-Eintrag vorbereiten
CRON_ENTRY="@reboot /usr/bin/python $SHOWIP_LINK > /dev/null 2>&1 &"

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
