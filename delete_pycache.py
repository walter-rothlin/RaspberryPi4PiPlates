#!/usr/bin/env python3

# ------------------------------------------------------------------
# Name: delete_pycache.py
#
# Description: Löscht rekursiv alle __pycache__-Verzeichnisse
#
# Autor: Walter Rothlin
#
# History:
# 08-Jul-2025   Walter Rothlin      Initial Version
# ------------------------------------------------------------------

import os
import shutil

def delete_pycache_dirs(start_path="."):
    deleted_count = 0
    for root, dirs, files in os.walk(start_path):
        for dirname in dirs:
            if dirname == "__pycache__":
                full_path = os.path.join(root, dirname)
                try:
                    shutil.rmtree(full_path)
                    print(f"🗑️  Gelöscht: {full_path}")
                    deleted_count += 1
                except Exception as e:
                    print(f"❌ Fehler beim Löschen von {full_path}: {e}")
    print(f"\n✅ Fertig. Insgesamt {deleted_count} __pycache__-Verzeichnisse gelöscht.")

if __name__ == "__main__":
    # Startpfad kann hier angepasst werden (z.B. "/home/pi/projects")
    startverzeichnis = "."  # aktuelles Verzeichnis
    delete_pycache_dirs(startverzeichnis)
