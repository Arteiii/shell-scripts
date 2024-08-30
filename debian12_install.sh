#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

SCRIPT_LIST=(
  "./fixes_bookworm/python_libs.sh" 
  "./fixes_bookworm/install_xorg_remove_wayland_gdm3.sh" 
  "./gnome_set_pfp/set_pfp.sh" 
  "./additional_software/keepassxc_i.sh" 
  "./additional_software/gitkraken_i.sh"
  "./additional_software/essentials_i.sh"
  "./additional_software/rust_i.sh"
  "./additional_software/clang_i.sh"
  "./additional_software/fonts/install_jetbrains_nerdfont.sh"
  "./config/git_config_arteii.sh"
)

for script in "${SCRIPT_LIST[@]}"; do
  if [ -f "./$script" ]; then
    echo "Running $script..."
    sudo bash ./"$script"
  else
    echo "Script $script not found in the current directory"
  fi
done

echo "All specified scripts have been executed"

echo "Rebooting system..."
sudo reboot
