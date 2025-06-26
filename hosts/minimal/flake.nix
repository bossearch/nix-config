{
  description = "Minimal NixOS flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    mkMinimal = host: disk: swap: swapSize:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = let
          luksKeyModule =
            if builtins.pathExists ./luks-key.nix
            then [./luks-key.nix]
            else [];
          wifiModule =
            if builtins.pathExists ./wpa.nix
            then [./wpa.nix]
            else [];
        in
          [
            inputs.disko.nixosModules.disko
            ({lib, ...}: let
              inherit (lib) mkOption types;
            in {
              options.spec = mkOption {
                type = types.submodule {
                  options = {
                    disk = mkOption {
                      type = types.str;
                    };
                    swap = mkOption {
                      type = types.bool;
                    };
                    swapSize = mkOption {
                      type = types.str;
                    };
                  };
                };
              };
            })
            ({...}: {
              spec.disk = disk;
              spec.swap = swap;
              spec.swapSize = swapSize;
            })

            ./disko.nix
            ./hardware-configuration.nix
            ./minimal.nix
            ({...}: {networking.hostName = host;})
          ]
          ++ luksKeyModule ++ wifiModule;
      };
  in {
    nixosConfigurations = {
      pc = mkMinimal "pc" "/dev/nvme0n1" true "32G";
      vm = mkMinimal "vm" "/dev/vda" false "0G";
    };
  };
}
