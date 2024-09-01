#!/bin/bash

# get interface_name via: ip link show

if [ -z "$1" ]; then
  echo "Usage: $0 <interface_name>"
  exit 1
fi

INTERFACE="$1"

if ! ip link show "$INTERFACE" > /dev/null 2>&1; then
  echo "Error: Interface '$INTERFACE' does not exist."
  exit 1
fi

echo "Bringing up the interface $INTERFACE..."
sudo ip link set dev "$INTERFACE" up

echo "Requesting IP address via DHCP for $INTERFACE..."
sudo dhclient "$INTERFACE"

echo "Network configuration for $INTERFACE:"
ip addr show "$INTERFACE"

echo "Network setup complete! The interface $INTERFACE should now be configured to use DHCP"

