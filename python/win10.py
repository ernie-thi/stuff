import os
import sys
import requests

def install_applications():
  """Installs the following applications on Windows 10:

  * Discord
  * SolidWorks
  * Microsoft Office 365
  * Anki
  * Zoom
  * Steam
  * Balena Etcher
  * Microsoft Teams
  * OBS Studio
  * Spotify
  * Ultimaker Cura
  * Visual Studio Code
  """

  # Check if all applications are already installed.
  for application in ["discord", "solidworks", "microsoft office 365", "anki", "zoom", "steam", "balena etcher", "microsoft teams", "obs studio", "spotify", "ultimaker cura", "visual studio code"]:
    if os.path.exists(f"C:\\Program Files\\{application}"):
      print(f"{application} is already installed.")
      continue

  # Download the installers for all applications.
  installers = {
    "discord": "https://discord.com/api/download?platform=win",
    "solidworks": "https://www.solidworks.com/download/trial",
    "microsoft office 365": "https://www.microsoft.com/en-us/microsoft-365/buy/microsoft-365-subscriptions",
    "anki": "https://apps.ankiweb.net/download/desktop/",
    "zoom": "https://zoom.us/download",
    "steam": "https://store.steampowered.com/about/",
    "balena etcher": "https://www.balena.io/etcher/download/",
    "microsoft teams": "https://www.microsoft.com/en-us/microsoft-teams/download-app",
    "obs studio": "https://obsproject.com/download",
    "spotify": "https://www.spotify.com/download/windows/",
    "ultimaker cura": "https://ultimaker.com/software/ultimaker-cura",
    "visual studio code": "https://code.visualstudio.com/download",
  }

  for application, installer_url in installers.items():
    print(f"Downloading {application} installer...")
    with open(f"{application}.exe", "wb") as f:
      f.write(requests.get(installer_url).content)

  # Install all applications.
  for application in installers:
    print(f"Installing {application}...")
    os.start(f"{application}.exe")

  # Check if all applications were installed successfully.
  for application in ["discord", "solidworks", "microsoft office 365", "anki", "zoom", "steam", "balena etcher", "microsoft teams", "obs studio", "spotify", "ultimaker cura", "visual studio code"]:
    if not os.path.exists(f"C:\\Program Files\\{application}"):
      print(f"{application} was not installed successfully.")

if __name__ == "__main__":
  install_applications()
