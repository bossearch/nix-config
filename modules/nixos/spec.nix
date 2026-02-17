{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.spec = mkOption {
    type = types.submodule {
      options = {
        hostname = mkOption {
          default = lib.mkDefault "pc";
          type = types.str;
        };
        username = mkOption {
          default = lib.mkDefault "bosse";
          type = types.str;
        };
        shell = mkOption {
          default = lib.mkDefault "bash";
          type = lib.types.enum [
            "bash"
            "fish"
            "zsh"
          ];
        };
        locale = mkOption {
          default = lib.mkDefault "en_US.UTF-8";
          type = lib.types.enum [
            "en_US.UTF-8"
            "id_ID.UTF-8"
          ];
        };
        timezone = mkOption {
          default = lib.mkDefault "Asia/Singapore";
          type = types.str;
        };
        theme = mkOption {
          default = lib.mkDefault "tokyo-night-dark";
          type = lib.types.enum [
            "catppuccin-mocha"
            "tokyo-night-dark"
          ];
        };
        disko = mkOption {
          type = types.submodule {
            options = {
              type = mkOption {
                default = "ext4";
                type = types.enum [
                  "btrfs-impermanence"
                  "btrfs-luks-impermanence"
                  "btrfs-luks"
                  "ext4-luks"
                  "ext4"
                ];
              };
              disk = mkOption {
                default = "/dev/vda";
                type = types.str;
              };
              swap = mkOption {
                default = "";
                type = types.str;
              };
            };
          };
          default = {};
        };
        networking = mkOption {
          type = types.submodule {
            options = {
              bridge = mkOption {
                default = false;
                type = types.bool;
              };
              firewall = mkOption {
                type = types.submodule {
                  options = {
                    enable = mkOption {
                      default = false;
                      type = types.bool;
                    };
                  };
                };
              };
            };
          };
        };
        # optional modules
        bluetooth = mkOption {
          default = false;
          type = types.bool;
        };
        bridge = mkOption {
          default = false;
          type = types.bool;
        };
        displaymanager = mkOption {
          default = false;
          type = types.bool;
        };
        dnscrypt = mkOption {
          default = false;
          type = types.bool;
        };
        pipewire = mkOption {
          default = false;
          type = types.bool;
        };
        proxychains = mkOption {
          default = false;
          type = types.bool;
        };
        silentboot = mkOption {
          default = false;
          type = types.bool;
        };
        sops = mkOption {
          default = false;
          type = types.bool;
        };
        ssh = mkOption {
          default = false;
          type = types.bool;
        };
        steam = mkOption {
          default = false;
          type = types.bool;
        };
        udevqmk = mkOption {
          default = false;
          type = types.bool;
        };
        usbguard = mkOption {
          default = false;
          type = types.bool;
        };
        virtmanager = mkOption {
          default = false;
          type = types.bool;
        };
        waydroid = mkOption {
          default = false;
          type = types.bool;
        };
        windowmanager = mkOption {
          default = lib.mkDefault "hyprland";
          type = lib.types.enum [
            "hyprland"
          ];
        };
      };
    };
  };
}
