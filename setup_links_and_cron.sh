#!/bin/bash

HOME_DIR="$HOME"
BIN_DIR="$HOME_DIR/bin"
TARGET_REPO="../Waltis_Repo_Clone/RaspberryPi4PiPlates/Python_Raspberry"

# Definition der Links als "Quelle:Ziel"
LINKS=(
    "$TARGET_REPO/04_Sense_Hat/clone_repo.py:$BIN_DIR/clone_repo.py"
    "$TARGET_REPO/04_Sense_Hat/showIP.py:$BIN_DIR/showIP.py"
    "$TARGET_REPO/../delete_pycache.sh:$BIN_DIR/cleanup"
    "$TARGET_REPO/06_Bahnhofuhr/Python_On_RaspberryPi/Bahnhof_MutterUhr.py:$BIN_DIR/Bahnhof_MutterUhr.py"
    "$TARGET_REPO/05_Schaltuhren/Schaltuhr_for_one_Relais/run.sh:$BIN_DIR/Schaltuhr_one_relais"
)

# 1. ~/bin erstellen falls nicht vorhanden
# ----------------------------------------
mkdir -p "$BIN_DIR"
echo "✅ Verzeichnis $BIN_DIR ist vorhanden."

# 2. Symbolische Links anlegen
# ----------------------------
for item in "${LINKS[@]}"; do
    SRC="${item%%:*}"
    DEST="${item##*:}"

    if [ -L "$DEST" ]; then
        echo "ℹ️  Link existiert bereits: $DEST"
    else
        ln -s "$SRC" "$DEST"
        echo "🔗 Link erstellt: $DEST -> $SRC"
    fi
done


# 3. Crontab-Eintrag vorbereiten
# ------------------------------

# Liste der Crontab-Einträge
CRON_ENTRIES=(
    "@reboot /usr/bin/python $SHOWIP_LINK                       > /dev/null 2>&1 &"
    "# @reboot /usr/bin/python $BIN_DIR/Bahnhof_MutterUhr.py    >> /home/pi/logs/mutter_uhr.log 2>&1 &"
	"# @reboot /usr/bin/python $BIN_DIR/Schaltuhr_one_relais.py >> /home/pi/logs/schaltuhr.log  2>&1 &"
)

# Marker, damit Einträge sauber wiedererkannt werden
CRON_MARK="# AUTO-CRON-ENTRIES"

CRONTAB_TMP=$(mktemp)

# Aktuelle Crontab lesen
crontab -l 2>/dev/null > "$CRONTAB_TMP"

# Falls Marker fehlt → hinzufügen + alle Einträge anhängen
if ! grep -Fq "$CRON_MARK" "$CRONTAB_TMP"; then
    {
        echo ""
        echo "$CRON_MARK"
        for entry in "${CRON_ENTRIES[@]}"; do
            echo "$entry"
        done
    } >> "$CRONTAB_TMP"

    crontab "$CRONTAB_TMP"
    echo "✅ Crontab-Einträge neu hinzugefügt."
else
    # Falls Marker existiert → sicherstellen, dass alle Einträge vorhanden sind
    UPDATED=0
    for entry in "${CRON_ENTRIES[@]}"; do
        if ! grep -Fq "$entry" "$CRONTAB_TMP"; then
            echo "$entry" >> "$CRONTAB_TMP"
            UPDATED=1
            echo "➕ Hinzugefügt: $entry"
        fi
    done

    if [ "$UPDATED" -eq 1 ]; then
        crontab "$CRONTAB_TMP"
        echo "✅ Crontab aktualisiert."
    else
        echo "🆗 Alle Crontab-Einträge sind bereits vorhanden."
    fi
fi

rm "$CRONTAB_TMP"
