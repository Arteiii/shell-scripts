#!/bin/bash

echo "Removing Network Manager..."
sudo apt purge -y network-manager network-manager-gnome
sudo apt autoremove -y

echo "Network Manager has been removed"

