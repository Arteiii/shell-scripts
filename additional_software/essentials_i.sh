#!/bin/bash

echo "Installing Git..."
sudo apt-get install -y git

echo "Installing Build Essentials..."
sudo apt-get install -y build-essential

echo "Installing curl..."
sudo apt-get install -y curl

echo "Verifying Git installation..."
git --version

echo "Git installation completed!"


