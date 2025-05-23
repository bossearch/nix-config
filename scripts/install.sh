#!/usr/bin/env bash

# Automated script to install my nix-config credit, to `https://github.com/librephoenix/nixos-config`
# If you new to nixos i highly recommend to watch his yt channel.

set -e

# Color definitions
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

HOSTNAME=$(hostname)
USERNAME=$(whoami)

# Validate username and hostname
if [[ "$USERNAME" != "bosse" ]] || [[ "$HOSTNAME" != "pc" && "$HOSTNAME" != "vm" ]]; then
  echo -e "${RED}Error:${NC} This setup only supports username 'bosse' and hostname 'pc' or 'vm'."
  echo -e "${YELLOW}Detected username:${NC} $USERNAME"
  echo -e "${YELLOW}Detected hostname:${NC} $HOSTNAME"
  exit 1
fi

# Set flake directory
FLAKE=~/.nix-config

# Generate hardware config for new system
sudo cp /etc/nixos/hardware-configuration.nix $FLAKE/hosts/$HOSTNAME/hardware-configuration.nix

# Rebuild system
sudo nixos-rebuild switch --flake $FLAKE#$HOSTNAME

# Install and build home-manager configuration
nix run home-manager --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake $FLAKE#$USERNAME@$HOSTNAME

PAGER=cat home-manager news --flake $FLAKE#$USERNAME@$HOSTNAME

echo -e "${GREEN}Installation complete. It is recommended to reboot your system now.${NC}"
