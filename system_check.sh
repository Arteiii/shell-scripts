#!/bin/bash

check_debian_bookworm() {
  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    if [[ "$ID" == "debian" && "$VERSION_CODENAME" == "bookworm" ]]; then
      echo "System is running Debian 12 (Bookworm)"
      return 0
    else
      echo "This script is intended to run only on Debian 12 (Bookworm)"
      return 1
    fi
  else
    echo "/etc/os-release file not found! Cannot determine the operating system"
    return 1
  fi
}

if check_debian_bookworm; then
  echo "Running Debian 12 install script..."
  if [[ -f "./debian12_install.sh" ]]; then
    bash ./debian12_install.sh
  else
    echo "debian12_install.sh not found in the current directory"
  fi
else
  echo "Aborting script execution"
fi


