#!/bin/bash

DEB_URL="https://release.gitkraken.com/linux/gitkraken-amd64.deb"
RPM_URL="https://release.gitkraken.com/linux/gitkraken-amd64.rpm"
TMP_DIR="./tmp"

check_gitkraken_installed() {
    if command -v gitkraken >/dev/null 2>&1; then
        echo "GitKraken is already installed."
        exit 0
    fi
}

install_deb() {
    mkdir -p $TMP_DIR
    echo "Downloading GitKraken .deb package..."
    wget -q $DEB_URL -O $TMP_DIR/gitkraken.deb
    echo "Installing GitKraken..."
    sudo dpkg -i $TMP_DIR/gitkraken.deb
    sudo apt-get install -f -y
    echo "Removing .deb package..."
    rm $TMP_DIR/gitkraken.deb
    echo "GitKraken installed and .deb package removed successfully!"
    rmdir $TMP_DIR
}

install_rpm() {
    mkdir -p $TMP_DIR
    echo "Downloading GitKraken .rpm package..."
    wget -q $RPM_URL -O $TMP_DIR/gitkraken.rpm
    echo "Installing GitKraken..."
    sudo rpm -i $TMP_DIR/gitkraken.rpm
    echo "Removing .rpm package..."
    rm $TMP_DIR/gitkraken.rpm
    echo "GitKraken installed and .rpm package removed successfully!"
    rmdir $TMP_DIR
}

check_gitkraken_installed

if [ -f /etc/debian_version ]; then
    echo "Debian-based distribution detected."
    install_deb
elif [ -f /etc/redhat-release ]; then
    echo "Red Hat-based distribution detected."
    install_rpm
else
    echo "Unsupported distribution. This script supports Debian-based and Red Hat-based distributions."
    exit 1
fi

