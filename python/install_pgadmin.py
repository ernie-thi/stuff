!#/usr/bin/env python3
import subprocess

def install_pgadmin():
  """Installs pgAdmin on Fedora."""

  # Enable the pgAdmin repository.
  subprocess.check_call([
    "sudo", "dnf", "install", "https://ftp.postgresql.org/pub/pgadmin/pgadmin4/yum/pgadmin4-fedora-repo-2-1.noarch.rpm"
  ])

  # Install pgAdmin.
  subprocess.check_call([
    "sudo", "dnf", "install", "pgadmin4"
  ])

  # Configure pgAdmin.
  subprocess.check_call([
    "sudo", "/usr/pgadmin4/bin/setup-web.sh"
  ])

  # Access pgAdmin.
  print("Open a web browser and navigate to `http://localhost:5000/pgadmin4`.")
  print("You will be prompted to create a new user account.")

if __name__ == "__main__":
  install_pgadmin()
