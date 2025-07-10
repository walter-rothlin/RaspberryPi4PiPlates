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
# 10-Jul-2025   Walter Rothlin      delete clone first and set chmod 755 after cloning
# ------------------------------------------------------------------
import subprocess
import os
import shutil

clone_liste = {
    "https://github.com/walter-rothlin/RaspberryPi4PiPlates": "Waltis_Repo_Clone",
}

def clone_github_repo(repo_url, clone_dir):
    if not repo_url:
        print("❌ Fehler: Es wurde keine Repository-URL angegeben.")
        return

    # Zielverzeichnis vorbereiten
    if os.path.exists(clone_dir):
        print(f"🧹 Entferne komplettes Zielverzeichnis: {clone_dir}")
        shutil.rmtree(clone_dir)

    os.makedirs(clone_dir, exist_ok=True)

    try:
        print(f"🔄 Klone Repository von: {repo_url}")
        subprocess.run(["git", "clone", repo_url], cwd=clone_dir, check=True)
        print("✅ Repository erfolgreich geklont.")

        # Repository-Ordnername bestimmen (z.B. "RaspberryPi4PiPlates")
        repo_name = os.path.splitext(os.path.basename(repo_url))[0]
        target_path = os.path.join(clone_dir, repo_name)

        # .py-Dateien chmod 755 setzen
        for root, dirs, files in os.walk(target_path):
            for file in files:
                if file.endswith('.py'):
                    file_path = os.path.join(root, file)
                    os.chmod(file_path, 0o755)
                    print(f"🔧 Setze chmod 755 für: {file_path}")

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

