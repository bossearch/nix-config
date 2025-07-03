<p align="center">
  <a href="https://nixos.org">
    <picture>
      <img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/logo/nix-snowflake-colours.svg" width="100px">
    </picture>
  </a>
</p>
<hr>

# Bossearch's Nix-Config

This is my personal NixOS and Home Manager setup, structured with [Nix flakes](https://nixos.wiki/wiki/Flakes) to keep my systems declarative, reproducible, and easy to maintain. It supports multiple machines with modular configs for both system and user layers, allowing me to quickly set up and manage desktops, laptops, VMs, and even mobile environments.

## Features

- Fully declarative NixOS configuration using Flakes
- Standalone [Home Manager](https://github.com/nix-community/home-manager) integration
- Modular system and user configuration
- Using [Nixvim](https://github.com/nix-community/nixvim) to fully configure Neovim
- Declarative global themes with [nix-colors](https://github.com/Misterio77/nix-colors)
- Auto generate daily wallpaper with [gowall](https://github.com/Achno/gowall)
- Encrypted secrets with [sops-nix](https://github.com/Mic92/sops-nix)
- Disk layout and LUKS encryption with [disko](https://github.com/nix-community/disko)
- Persistent system state with [impermanence](https://github.com/nix-community/impermanence)
- Experimental mobile support via [nix-on-droid](https://github.com/t184256/nix-on-droid)
- Unattended NixOS installation [script](https://gist.github.com/bossearch/9f8b524217bddd411d6fe08061dfaab5)

## References

Key inspirations along this journey:

- [Misterio77](https://github.com/Misterio77/nix-config) – Reference and structure
- [EmergentMind](https://github.com/EmergentMind/nix-config) – Reference for secrets and remote-bootstrapping
- [VimJoyer](https://github.com/vimjoyer) – Clear and practical NixOS tutorials
- [librephoenix](https://github.com/librephoenix/nixos-config) – In-depth walkthroughs of NixOS tutorials
- [1amSimp1e](https://github.com/1amSimp1e/dots) – Where my Hyprland journey began
