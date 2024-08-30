#!/bin/bash

echo "Downloading and installing rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

echo "Sourcing the Rust environment..."
source $HOME/.cargo/env

echo "Verifying Rust installation..."
rustc --version
cargo --version

echo "Rust installation completed!"

