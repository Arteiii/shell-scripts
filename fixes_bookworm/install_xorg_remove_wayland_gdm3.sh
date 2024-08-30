#!/bin/bash

echo "Installing Xorg..."
sudo apt install -y xorg

echo "Removing Wayland components..."
sudo apt purge -y gnome-shell-wayland wayland* libwayland*

CUSTOM_CONF="/etc/gdm3/custom.conf"
if [ -f "$CUSTOM_CONF" ]; then
  echo "Disabling Wayland in GDM3..."
  sed -i '/^#.*WaylandEnable=false/s/^#//' $CUSTOM_CONF
  
  if grep -q "^WaylandEnable=false" $CUSTOM_CONF; then
    echo "WaylandEnable=false is already set in $CUSTOM_CONF."
  else
    echo "[daemon]" >> $CUSTOM_CONF
    echo "WaylandEnable=false" >> $CUSTOM_CONF
    echo "Added WaylandEnable=false to $CUSTOM_CONF."
  fi
else
  echo "$CUSTOM_CONF not found. Creating $CUSTOM_CONF."
  sudo touch $CUSTOM_CONF
  echo "[daemon]" | sudo tee -a $CUSTOM_CONF
  echo "WaylandEnable=false" | sudo tee -a $CUSTOM_CONF
  echo "Created and configured $CUSTOM_CONF."
fi

echo "Reboot the system to apply changes..."


