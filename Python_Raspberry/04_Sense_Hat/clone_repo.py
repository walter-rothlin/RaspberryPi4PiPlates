#!/usr/bin/python3

# ------------------------------------------------------------------
# Name: clone-repo.py
# https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/refs/heads/main/Python_Raspberry/04_Sense_Hat/clone_repo.py
#
# Description: Erstellt einen lokalen Clone eines Git repositories
#
# Autor: Walter Rothlin
#
# History:
# 08-Jul-2025   Walter Rothlin      Initial Version
# ------------------------------------------------------------------
import subprocess
import os
import shutil

clone_liste = {
    "https://github.com/walter-rothlin/RaspberryPi4PiPlates": "../Waltis_Repo_Clone",
}

def clone_github_repo(repo_url, clone_dir):
    if not repo_url:
        print("❌ Fehler: Es wurde keine Repository-URL angegeben.")
        return

    # Zielordner vorbereiten
    repo_name = os.path.splitext(os.path.basename(repo_url))[0]
    target_path = os.path.join(clone_dir, repo_name)

    # Wenn das Verzeichnis bereits existiert, löschen
    if os.path.exists(target_path):
        print(f"🧹 Entferne vorhandenes Verzeichnis: {target_path}")
        shutil.rmtree(target_path)

    # Sicherstellen, dass das übergeordnete Verzeichnis existiert
    os.makedirs(clone_dir, exist_ok=True)

    # Klonen
    try:
        print(f"🔄 Klone Repository von: {repo_url}")
        subprocess.run(["git", "clone", repo_url], cwd=clone_dir, check=True)
        print("✅ Repository erfolgreich geklont.\n")
    except subprocess.CalledProcessError as e:
        print("❌ Fehler beim Klonen des Repositories:")
        print(e)

def clone_repos(clone_liste):
    for repo_url, zielverzeichnis in clone_liste.items():
        print(f"🚀 Bearbeite Repo: {repo_url}")
        clone_github_repo(repo_url, zielverzeichnis)
        
def clone_them():
    clone_repos(clone_liste)

if __name__ == "__main__":
    clone_them()
