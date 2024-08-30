#!/bin/bash

echo "Installing Clang and C++ packages..."
sudo apt-get install -y clang llvm libc++-dev libc++abi-dev

echo "Verifying Clang installation..."
clang --version
llvm-config --version

echo "Clang installation completed!"

