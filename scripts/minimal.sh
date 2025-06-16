#!/usr/bin/env bash

set -euo pipefail

# Color definitions
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Validate argument
if [[ $# -ne 1 ]]; then
  echo -e "${RED}Usage: $0 <host>\nExample: $0 pc${NC}"
  exit 1
fi

HOST="$1"
FLAKE="$HOME/.nix-config"
MINIMAL_FLAKE="$FLAKE/hosts/minimal"
SRC="$FLAKE/hosts/$HOST"

# Check source files exist
if [[ ! -f "$SRC/disko.nix" || ! -f "$SRC/hardware-configuration.nix" ]]; then
  echo -e "${RED}Missing disko.nix or hardware.nix for host: $HOST${NC}"
  exit 1
fi

# Copy host-specific files to minimal flake
cp "$SRC/disko.nix" "$MINIMAL_FLAKE/disko.nix"
cp "$SRC/hardware-configuration.nix" "$MINIMAL_FLAKE/hardware-configuration.nix"

# Run disko
nix-shell -p disko --run "sudo disko --mode disko --flake $MINIMAL_FLAKE#$HOST"

git -C ~/.nix-config add .

# Install NixOS using minimal flake
sudo nixos-install --no-root-password --flake "$MINIMAL_FLAKE#$HOST"

echo -e "${GREEN}✔ Minimal installation complete for $HOST. Please reboot to finish setup.${NC}"
