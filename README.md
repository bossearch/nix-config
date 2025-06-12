# Bossearch's Nix-Config

NixOS and Home Manager config files using [Nix flakes](https://nixos.wiki/wiki/Flakes).

## Features

- Fully declarative NixOS configuration using Flakes
- Home Manager integration
- Modular system and user configuration
- Using [Nixvim](https://github.com/nix-community/nixvim) to fully configure Neovim
- Declarative global themes with [nix-colors](https://github.com/Misterio77/nix-colors)
- Auto generate daily wallpaper with [gowall](https://github.com/Achno/gowall)

## Getting Started

> [!IMPORTANT]
> Make sure you've replaced `hostname` with the machine name defined under `hosts/`, and `username` with the one defined under `home/`, then run `nixos-install`. Once the installation is complete, follow the steps below.

Clone and install:

```bash
nix-shell -p git --run "git clone https://github.com/bossearch/nix-config ~/.nix-config && ~/.nix-config/scripts/install.sh"
```

## References

Key inspirations along this journey:

- [Misterio77](https://github.com/Misterio77/nix-config) – Reference and structure
- [EmergentMind](https://github.com/EmergentMind/nix-config) – Inspiration for future secret management
- [VimJoyer](https://github.com/vimjoyer) – Clear and practical NixOS tutorials
- [librephoenix](https://github.com/librephoenix/nixos-config) – In-depth walkthroughs of NixOS tutorials
- [1amSimp1e](https://github.com/1amSimp1e/dots) Where my Hyprland journey began
